class CX_DEMO_CR_LOCK definition
  public
  inheriting from CX_DEMO_CR_CAR_RENTAL
  final
  create public .

public section.
*"* public components of class CX_DEMO_CR_LOCK
*"* do not include other source files here!!!

  constants:
    begin of CX_DEMO_CR_LOCK,
      msgid type symsgid value 'SABAP_DEMOS_CR',
      msgno type symsgno value '010',
      attr1 type scx_attrname value '',
      attr2 type scx_attrname value '',
      attr3 type scx_attrname value '',
      attr4 type scx_attrname value '',
    end of CX_DEMO_CR_LOCK .
  constants:
    begin of DELETE_LOCK,
      msgid type symsgid value 'SABAP_DEMOS_CR',
      msgno type symsgno value '012',
      attr1 type scx_attrname value '',
      attr2 type scx_attrname value '',
      attr3 type scx_attrname value '',
      attr4 type scx_attrname value '',
    end of DELETE_LOCK .
  constants:
    begin of RESERVATION_LOCK,
      msgid type symsgid value 'SABAP_DEMOS_CR',
      msgno type symsgno value '011',
      attr1 type scx_attrname value '',
      attr2 type scx_attrname value '',
      attr3 type scx_attrname value '',
      attr4 type scx_attrname value '',
    end of RESERVATION_LOCK .
  data:
    TEXT type C length 40 .

  methods CONSTRUCTOR
    importing
      !TEXTID like IF_T100_MESSAGE=>T100KEY optional
      !PREVIOUS like PREVIOUS optional
      !TEXT like TEXT optional .
protected section.
*"* protected components of class CX_DEMO_CR_LOCK
*"* do not include other source files here!!!
private section.
*"* private components of class CX_DEMO_CR_LOCK
*"* do not include other source files here!!!
ENDCLASS.



CLASS CX_DEMO_CR_LOCK IMPLEMENTATION.


method CONSTRUCTOR.
CALL METHOD SUPER->CONSTRUCTOR
EXPORTING
PREVIOUS = PREVIOUS
.
me->TEXT = TEXT .
clear me->textid.
if textid is initial.
  IF_T100_MESSAGE~T100KEY = CX_DEMO_CR_LOCK .
else.
  IF_T100_MESSAGE~T100KEY = TEXTID.
endif.
endmethod.
ENDCLASS.
