REPORT demo_string_template_time_form.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS: main.
  PRIVATE SECTION.
    CLASS-METHODS: setup,
      teardown,
      check_system.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA: seconds   TYPE i,
          timetable TYPE TABLE OF t,
          comp      TYPE i.

    CONSTANTS n     TYPE i VALUE 4.

    DATA: BEGIN OF result,
            raw        TYPE string,
            iso        TYPE string,
            h24        TYPE string,
            h12_1_12_a TYPE string,
            h12_1_12_b TYPE string,
            h12_0_11_a TYPE string,
            h12_0_11_b TYPE string,
          END OF result,
          results LIKE TABLE OF result.

    FIELD-SYMBOLS: <time> TYPE t,
                   <col>  TYPE string.

    setup( ).

    timetable =
      VALUE #( FOR j = 1 UNTIL j > 24 / n
               LET s = ( j - 1 ) * 3600 * n IN
               ( CONV t( s ) )
               ( CONV t( s + 1 ) )
               ( CONV t( s + ( n - 1 ) * 3600 + 59 * 60 + 59 ) ) ).

    LOOP AT timetable ASSIGNING <time>.
      result-raw = |{ <time> TIME = RAW }|.
      result-iso = |{ <time> TIME = ISO }|.
      SELECT land
             FROM t005x
             WHERE land LIKE '@%'
             ORDER BY PRIMARY KEY
             INTO (@DATA(land)).
        comp = sy-dbcnt + 2.
        ASSIGN COMPONENT comp OF STRUCTURE result TO <col>.
        <col> = |{ <time> COUNTRY = land }|.
      ENDSELECT.
      APPEND result TO results.
    ENDLOOP.

    teardown( ).

    cl_demo_output=>display( results ).

  ENDMETHOD.
  METHOD setup.
    DATA: descr    TYPE REF TO cl_abap_elemdescr,
          fixvals  TYPE ddfixvalues,
          fixval   LIKE LINE OF fixvals,
          ans      TYPE c LENGTH 1.
    check_system( ).
    SELECT SINGLE land
           FROM t005x
           WHERE land LIKE '@%'
           INTO (@DATA(land)).
    IF sy-subrc = 0.
      CALL FUNCTION 'POPUP_TO_CONFIRM'
        EXPORTING
          titlebar              = 'Confirmation'
          text_question         = 'Delete existing' &
                                  ' entries with keys' &
                                  ' @1, @2, ...  in T005X?'
          text_button_1         = 'Yes'
          text_button_2         = 'No'
          display_cancel_button = ' '
        IMPORTING
          answer                = ans.
      IF ans = 1.
        teardown( ).
      ELSE.
        cl_demo_output=>display( 'Execution not possible' ).
        LEAVE PROGRAM.
      ENDIF.
    ENDIF.
    descr ?= cl_abap_elemdescr=>describe_by_name( 'T005X-TIMEFM' ).
    fixvals = descr->get_ddic_fixed_values( ).
    LOOP AT fixvals INTO fixval.
      IF fixval-low IS INITIAL.
        CONTINUE.
      ENDIF.
      INSERT t005x FROM @( VALUE #(
        land = '@' && |{ fixval-low }|
        timefm = |{ fixval-low }| ) ).
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
