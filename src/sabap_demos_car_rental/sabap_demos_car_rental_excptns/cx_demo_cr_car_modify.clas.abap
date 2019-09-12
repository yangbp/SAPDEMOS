class CX_DEMO_CR_CAR_MODIFY definition
  public
  inheriting from CX_DEMO_CR_CAR
  final
  create public .

public section.
*"* public components of class CX_DEMO_CR_CAR_MODIFY
*"* do not include other source files here!!!

  constants:
    begin of CX_DEMO_CR_CAR_MODIFY,
      msgid type symsgid value 'SABAP_DEMOS_CR',
      msgno type symsgno value '020',
      attr1 type scx_attrname value 'LICENSE_PLATE',
      attr2 type scx_attrname value '',
      attr3 type scx_attrname value '',
      attr4 type scx_attrname value '',
    end of CX_DEMO_CR_CAR_MODIFY .
  constants:
    begin of CAR_CREATE,
      msgid type symsgid value 'SABAP_DEMOS_CR',
      msgno type symsgno value '021',
      attr1 type scx_attrname value 'LICENSE_PLATE',
      attr2 type scx_attrname value '',
      attr3 type scx_attrname value '',
      attr4 type scx_attrname value '',
    end of CAR_CREATE .
  constants:
    begin of CAR_DELETE,
      msgid type symsgid value 'SABAP_DEMOS_CR',
      msgno type symsgno value '022',
      attr1 type scx_attrname value 'LICENSE_PLATE',
      attr2 type scx_attrname value '',
      attr3 type scx_attrname value '',
      attr4 type scx_attrname value '',
    end of CAR_DELETE .
  data LICENSE_PLATE type DEMO_CR_SCAR-LICENSE_PLATE .

  methods CONSTRUCTOR
    importing
      !TEXTID like IF_T100_MESSAGE=>T100KEY optional
      !PREVIOUS like PREVIOUS optional
      !LICENSE_PLATE type DEMO_CR_SCAR-LICENSE_PLATE optional .
protected section.
*"* protected components of class CX_DEMO_CR_CAR_MODIFY
*"* do not include other source files here!!!
private section.
*"* private components of class CX_DEMO_CR_CAR_MODIFY
*"* do not include other source files here!!!
ENDCLASS.



CLASS CX_DEMO_CR_CAR_MODIFY IMPLEMENTATION.


method CONSTRUCTOR.
CALL METHOD SUPER->CONSTRUCTOR
EXPORTING
PREVIOUS = PREVIOUS
.
me->LICENSE_PLATE = LICENSE_PLATE .
clear me->textid.
if textid is initial.
  IF_T100_MESSAGE~T100KEY = CX_DEMO_CR_CAR_MODIFY .
else.
  IF_T100_MESSAGE~T100KEY = TEXTID.
endif.
endmethod.
ENDCLASS.
