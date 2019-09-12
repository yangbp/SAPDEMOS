REPORT demo_message_oref.

CLASS cx_t100 DEFINITION INHERITING FROM cx_dynamic_check.
  PUBLIC SECTION.
    INTERFACES if_t100_message.
    METHODS constructor IMPORTING id    TYPE symsgid
                                  no    TYPE symsgno
                                  text1 TYPE csequence OPTIONAL
                                  text2 TYPE csequence OPTIONAL
                                  text3 TYPE csequence OPTIONAL
                                  text4 TYPE csequence OPTIONAL.
    DATA text1 TYPE c LENGTH 50.
    DATA text2 TYPE c LENGTH 50.
    DATA text3 TYPE c LENGTH 50.
    DATA text4 TYPE c LENGTH 50.
ENDCLASS.

CLASS cx_t100 IMPLEMENTATION.
  METHOD constructor.
    super->constructor( ).
    me->text1 = text1.
    me->text2 = text2.
    me->text3 = text3.
    me->text4 = text4.
    if_t100_message~t100key-msgid = id.
    if_t100_message~t100key-msgno = no.
    if_t100_message~t100key-attr1 = 'TEXT1'.
    if_t100_message~t100key-attr2 = 'TEXT2'.
    if_t100_message~t100key-attr3 = 'TEXT3'.
    if_t100_message~t100key-attr4 = 'TEXT4'.
  ENDMETHOD.
ENDCLASS.

CLASS msg_demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
  PRIVATE SECTION.
    CLASS-METHODS meth
      RAISING cx_t100.
ENDCLASS.

CLASS msg_demo IMPLEMENTATION.
  METHOD main.
    TRY.
        meth( ).
      CATCH cx_t100 INTO DATA(oref).
        cl_demo_output=>display( oref->get_text( ) ).
        MESSAGE oref TYPE 'I' DISPLAY LIKE 'E'.
    ENDTRY.
  ENDMETHOD.
  METHOD meth.
    RAISE EXCEPTION TYPE cx_t100
      EXPORTING
        id    = 'SABAPDEMOS'
        no    = '888'
        text1 = 'I'
        text2 = 'am'
        text3 = 'an'
        text4 = 'Exception!'.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  msg_demo=>main( ).
