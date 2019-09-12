REPORT demo_raise_error_message_shrt.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    TRY.
        CALL FUNCTION 'DEMO_FUNCTION_MESSAGE'
          EXPORTING
            message_type  = 'A'
            message_place = 'in Function Module'
            message_event = 'START-OF-SELECTION'
          EXCEPTIONS
            error_message = 4.
        IF sy-subrc <> 0.
          RAISE EXCEPTION TYPE cx_demo_dyn_t100 USING MESSAGE.
        ENDIF.
      CATCH cx_demo_dyn_t100 INTO DATA(oref).
        cl_demo_output=>display(
          |Caught exception:\n\n| &&
          |"{ oref->get_text( ) }", Type { oref->msgty } | ).
        MESSAGE oref TYPE 'I' DISPLAY LIKE oref->msgty.
    ENDTRY.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
