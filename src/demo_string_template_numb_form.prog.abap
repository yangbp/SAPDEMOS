REPORT demo_string_template_numb_form.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
  PRIVATE SECTION.
    CLASS-METHODS: setup,
      teardown,
      check_system.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA number TYPE p DECIMALS 2 VALUE '1234567.89'.

    DATA: BEGIN OF result,
            xdezp  TYPE string,
            format TYPE string,
          END OF result,
          results LIKE TABLE OF result.

    setup( ).

    SELECT land, xdezp
           FROM t005x
           WHERE land LIKE '@%'
           ORDER BY PRIMARY KEY
           INTO (@DATA(land),@DATA(xdezp)).
      results = VALUE #( BASE results
        ( xdezp  = xdezp
          format = |{ number COUNTRY = land }| ) ).
    ENDSELECT.

    teardown( ).

    cl_demo_output=>display( results ).

  ENDMETHOD.
  METHOD setup.
    CONSTANTS xdezp_values TYPE string VALUE ` XY`.
    DATA: ans TYPE c LENGTH 1,
          key TYPE c LENGTH 1.
    check_system( ).
    SELECT SINGLE land
           FROM t005x
           WHERE land LIKE '@%'
           INTO (@DATA(land)).
    IF sy-subrc = 0.
      CALL FUNCTION 'POPUP_TO_CONFIRM'
        EXPORTING
          titlebar              = 'Confirmation'
          text_question         = 'Delete existing'
                                  &
                                  ' entries with keys'
                                  &
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
    DO strlen( xdezp_values ) TIMES.
      key = |{ substring( val =  xdezp_values
                          off = sy-index - 1
                          len = 1 )  }|.
      INSERT t005x FROM @( VALUE #(
        land = '@' && key
        xdezp = key ) ).
    ENDDO.
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
