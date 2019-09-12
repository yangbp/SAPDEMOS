REPORT demo_string_template_date_form.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS: main.
  PRIVATE SECTION.
    CLASS-DATA: fixvals TYPE ddfixvalues,
                fixval  LIKE LINE OF fixvals.
    CLASS-METHODS: setup,
                   teardown,
                   check_system.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA: BEGIN OF result,
                  datfm  TYPE string,
                  format TYPE string,
                  result TYPE string,
                END OF result,
                results LIKE TABLE OF result.

    setup( ).

    SELECT land, datfm
           FROM t005x
           WHERE land LIKE '@%'
           ORDER BY PRIMARY KEY
           INTO (@DATA(land),@DATA(datfm)).
      result-datfm = datfm.
      READ TABLE fixvals WITH KEY low = datfm
           TRANSPORTING ddtext INTO fixval.
      IF sy-subrc = 0.
        result-format = fixval-ddtext.
      ELSE.
        CLEAR result-format.
      ENDIF.
      result-result = |{ sy-datum COUNTRY = land }|.
      APPEND result TO results.
    ENDSELECT.

    teardown( ).

    cl_demo_output=>display( results ).

  ENDMETHOD.
  METHOD setup.
    DATA: descr    TYPE REF TO cl_abap_elemdescr,
          ans      TYPE c LENGTH 1.
    check_system( ).
    SELECT SINGLE land
           FROM t005x
           WHERE land LIKE '@%'
           INTO (@DATA(land)).
    IF sy-subrc = 0.
      CALL FUNCTION 'POPUP_TO_CONFIRM'
        EXPORTING
          titlebar                      = 'Confirmation'
          text_question                 = 'Delete existing' &
                                          ' entries with keys' &
                                          ' @1, @2, ...  in T005X?'
          text_button_1                 = 'Yes'
          text_button_2                 = 'No'
          display_cancel_button         = ' '
        IMPORTING
          answer                        = ans.
      IF ans = 1.
        teardown( ).
      ELSE.
        cl_demo_output=>display( 'Execution not possible' ).
        LEAVE PROGRAM.
      ENDIF.
    ENDIF.
    descr ?= cl_abap_elemdescr=>describe_by_name( 'T005X-DATFM' ).
    fixvals = descr->get_ddic_fixed_values( p_langu = sy-langu ).
    LOOP AT fixvals INTO fixval.
      INSERT t005x FROM @( VALUE #(
        land = '@' && |{ fixval-low }|
        datfm = |{ fixval-low }| ) ).
    ENDLOOP.
    COMMIT WORK.
  ENDMETHOD.
  METHOD teardown.
    DELETE FROM t005x WHERE land LIKE '@%'.
    COMMIT WORK.
  ENDMETHOD.
  METHOD check_system.
    IF cl_abap_demo_services=>is_production_system( ).
      cl_demo_output=>display(
        'This demo cannot be executed in a production system' ).
      LEAVE PROGRAM.
    ENDIF.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
