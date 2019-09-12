REPORT demo_message_oref_global.

CLASS msg_demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
  PRIVATE SECTION.
    CLASS-METHODS meth
      RAISING cx_demo_t100.
ENDCLASS.

CLASS msg_demo IMPLEMENTATION.
  METHOD main.
    TRY.
        meth( ).
      CATCH cx_demo_t100 INTO DATA(oref).
        cl_demo_output=>display( oref->get_text( ) ).
        MESSAGE oref TYPE 'I' DISPLAY LIKE 'E'.
    ENDTRY.
  ENDMETHOD.
  METHOD meth.
    RAISE EXCEPTION TYPE cx_demo_t100
      EXPORTING
        textid = cx_demo_t100=>demo
        text1  = 'I'
        text2  = 'am'
        text3  = 'an'
        text4  = 'Exception!'.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  msg_demo=>main( ).
