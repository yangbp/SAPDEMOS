CLASS cx_demo_t100 DEFINITION
  PUBLIC
  INHERITING FROM cx_static_check
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_t100_message .

    CONSTANTS:
      BEGIN OF demo,
        msgid TYPE symsgid VALUE 'SABAPDEMOS',
        msgno TYPE symsgno VALUE '888',
        attr1 TYPE scx_attrname VALUE 'TEXT1',
        attr2 TYPE scx_attrname VALUE 'TEXT2',
        attr3 TYPE scx_attrname VALUE 'TEXT3',
        attr4 TYPE scx_attrname VALUE 'TEXT4',
      END OF demo .
    DATA text1 TYPE sstring .
    DATA text2 TYPE sstring .
    DATA text3 TYPE sstring .
    DATA text4 TYPE sstring .

    METHODS constructor
      IMPORTING
        !textid   LIKE if_t100_message=>t100key OPTIONAL
        !previous LIKE previous OPTIONAL
        !text1    TYPE sstring OPTIONAL
        !text2    TYPE sstring OPTIONAL
        !text3    TYPE sstring OPTIONAL
        !text4    TYPE sstring OPTIONAL .
protected section.
private section.
ENDCLASS.



CLASS CX_DEMO_T100 IMPLEMENTATION.


  method CONSTRUCTOR.
CALL METHOD SUPER->CONSTRUCTOR
EXPORTING
PREVIOUS = PREVIOUS
.
me->TEXT1 = TEXT1 .
me->TEXT2 = TEXT2 .
me->TEXT3 = TEXT3 .
me->TEXT4 = TEXT4 .
clear me->textid.
if textid is initial.
  IF_T100_MESSAGE~T100KEY = IF_T100_MESSAGE=>DEFAULT_TEXTID.
else.
  IF_T100_MESSAGE~T100KEY = TEXTID.
endif.
  endmethod.
ENDCLASS.
