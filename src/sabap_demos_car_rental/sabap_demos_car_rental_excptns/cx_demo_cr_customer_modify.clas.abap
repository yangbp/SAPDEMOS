class CX_DEMO_CR_CUSTOMER_MODIFY definition
  public
  inheriting from CX_DEMO_CR_CUSTOMER
  final
  create public .

public section.
*"* public components of class CX_DEMO_CR_CUSTOMER_MODIFY
*"* do not include other source files here!!!

  constants:
    begin of CX_DEMO_CR_CUSTOMER_MODIFY,
      msgid type symsgid value 'SABAP_DEMOS_CR',
      msgno type symsgno value '030',
      attr1 type scx_attrname value 'NAME',
      attr2 type scx_attrname value '',
      attr3 type scx_attrname value '',
      attr4 type scx_attrname value '',
    end of CX_DEMO_CR_CUSTOMER_MODIFY .
  constants:
    begin of CUSTOMER_CREATE,
      msgid type symsgid value 'SABAP_DEMOS_CR',
      msgno type symsgno value '031',
      attr1 type scx_attrname value 'NAME',
      attr2 type scx_attrname value '',
      attr3 type scx_attrname value '',
      attr4 type scx_attrname value '',
    end of CUSTOMER_CREATE .
  constants:
    begin of CUSTOMER_DELETE,
      msgid type symsgid value 'SABAP_DEMOS_CR',
      msgno type symsgno value '032',
      attr1 type scx_attrname value 'NAME',
      attr2 type scx_attrname value '',
      attr3 type scx_attrname value '',
      attr4 type scx_attrname value '',
    end of CUSTOMER_DELETE .
  data NAME type DEMO_CR_SCUSTOMER-NAME .

  methods CONSTRUCTOR
    importing
      !TEXTID like IF_T100_MESSAGE=>T100KEY optional
      !PREVIOUS like PREVIOUS optional
      !NAME type DEMO_CR_SCUSTOMER-NAME optional .
protected section.
*"* protected components of class CX_DEMO_CR_CUSTOMER_MODIFY
*"* do not include other source files here!!!
private section.
*"* private components of class CX_DEMO_CR_CUSTOMER_MODIFY
*"* do not include other source files here!!!
ENDCLASS.



CLASS CX_DEMO_CR_CUSTOMER_MODIFY IMPLEMENTATION.


method CONSTRUCTOR.
CALL METHOD SUPER->CONSTRUCTOR
EXPORTING
PREVIOUS = PREVIOUS
.
me->NAME = NAME .
clear me->textid.
if textid is initial.
  IF_T100_MESSAGE~T100KEY = CX_DEMO_CR_CUSTOMER_MODIFY .
else.
  IF_T100_MESSAGE~T100KEY = TEXTID.
endif.
endmethod.
ENDCLASS.
