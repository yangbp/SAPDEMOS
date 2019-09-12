REPORT demo_raise_message.

CLASS cx_dyn_t100 DEFINITION INHERITING FROM cx_dynamic_check.
  PUBLIC SECTION.
    INTERFACES if_t100_dyn_msg.
    ALIASES msgty FOR if_t100_dyn_msg~msgty.
ENDCLASS.

CLASS msg_demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
  PRIVATE SECTION.
    CLASS-METHODS meth
      RAISING cx_dyn_t100.
ENDCLASS.

CLASS msg_demo IMPLEMENTATION.
  METHOD main.
    TRY.
        meth( ).
      CATCH cx_dyn_t100 INTO DATA(oref).
        cl_demo_output=>display(
          |Caught exception:\n\n| &&
          |"{ oref->get_text( ) }", Type { oref->msgty } | ).
        MESSAGE oref TYPE 'I' DISPLAY LIKE oref->msgty.
    ENDTRY.
  ENDMETHOD.
  METHOD meth.
    RAISE EXCEPTION TYPE cx_dyn_t100
          MESSAGE e888(sabapdemos) WITH 'I' 'am' 'an' 'Exception!'.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  msg_demo=>main( ).
