class CX_DEMO_CR_NO_CAR_AVAILABLE definition
  public
  inheriting from CX_DEMO_CR_CAR
  final
  create public .

public section.
*"* public components of class CX_DEMO_CR_NO_CAR_AVAILABLE
*"* do not include other source files here!!!

  constants:
    begin of CX_DEMO_CR_NO_CAR_AVAILABLE,
      msgid type symsgid value 'SABAP_DEMOS_CR',
      msgno type symsgno value '025',
      attr1 type scx_attrname value '',
      attr2 type scx_attrname value '',
      attr3 type scx_attrname value '',
      attr4 type scx_attrname value '',
    end of CX_DEMO_CR_NO_CAR_AVAILABLE .

  methods CONSTRUCTOR
    importing
      !TEXTID like IF_T100_MESSAGE=>T100KEY optional
      !PREVIOUS like PREVIOUS optional .
protected section.
*"* protected components of class CX_DEMO_CR_NO_CAR_AVAILABLE
*"* do not include other source files here!!!
private section.
*"* private components of class ZCX_NO_CAR_AVAILABLE
*"* do not include other source files here!!!
ENDCLASS.



CLASS CX_DEMO_CR_NO_CAR_AVAILABLE IMPLEMENTATION.


method CONSTRUCTOR.
CALL METHOD SUPER->CONSTRUCTOR
EXPORTING
PREVIOUS = PREVIOUS
.
clear me->textid.
if textid is initial.
  IF_T100_MESSAGE~T100KEY = CX_DEMO_CR_NO_CAR_AVAILABLE .
else.
  IF_T100_MESSAGE~T100KEY = TEXTID.
endif.
endmethod.
ENDCLASS.
