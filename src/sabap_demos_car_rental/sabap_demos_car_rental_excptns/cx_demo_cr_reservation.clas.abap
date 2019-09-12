class CX_DEMO_CR_RESERVATION definition
  public
  inheriting from CX_DEMO_CR_CAR_RENTAL
  final
  create public .

public section.
*"* public components of class CX_DEMO_CR_RESERVATION
*"* do not include other source files here!!!

  constants:
    begin of CX_DEMO_CR_RESERVATION,
      msgid type symsgid value 'SABAP_DEMOS_CR',
      msgno type symsgno value '040',
      attr1 type scx_attrname value '',
      attr2 type scx_attrname value '',
      attr3 type scx_attrname value '',
      attr4 type scx_attrname value '',
    end of CX_DEMO_CR_RESERVATION .
  constants:
    begin of INTERNAL_ERROR,
      msgid type symsgid value 'SABAP_DEMOS_CR',
      msgno type symsgno value '045',
      attr1 type scx_attrname value '',
      attr2 type scx_attrname value '',
      attr3 type scx_attrname value '',
      attr4 type scx_attrname value '',
    end of INTERNAL_ERROR .
  constants:
    begin of RESERVATION_DELETE,
      msgid type symsgid value 'SABAP_DEMOS_CR',
      msgno type symsgno value '042',
      attr1 type scx_attrname value '',
      attr2 type scx_attrname value '',
      attr3 type scx_attrname value '',
      attr4 type scx_attrname value '',
    end of RESERVATION_DELETE .
  constants:
    begin of RESERVATION_CREATE,
      msgid type symsgid value 'SABAP_DEMOS_CR',
      msgno type symsgno value '041',
      attr1 type scx_attrname value '',
      attr2 type scx_attrname value '',
      attr3 type scx_attrname value '',
      attr4 type scx_attrname value '',
    end of RESERVATION_CREATE .
  data:
    TEXT type c length 40 .

  methods CONSTRUCTOR
    importing
      !TEXTID like IF_T100_MESSAGE=>T100KEY optional
      !PREVIOUS like PREVIOUS optional
      !TEXT like TEXT optional .
protected section.
*"* protected components of class CX_DEMO_CR_RESERVATION
*"* do not include other source files here!!!
private section.
*"* private components of class CX_DEMO_CR_RESERVATION
*"* do not include other source files here!!!
ENDCLASS.



CLASS CX_DEMO_CR_RESERVATION IMPLEMENTATION.


method CONSTRUCTOR.
CALL METHOD SUPER->CONSTRUCTOR
EXPORTING
PREVIOUS = PREVIOUS
.
me->TEXT = TEXT .
clear me->textid.
if textid is initial.
  IF_T100_MESSAGE~T100KEY = CX_DEMO_CR_RESERVATION .
else.
  IF_T100_MESSAGE~T100KEY = TEXTID.
endif.
endmethod.
ENDCLASS.
