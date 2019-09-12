class CX_DEMO_CR_CUSTOMER definition
  public
  inheriting from CX_DEMO_CR_CAR_RENTAL
  abstract
  create public .

public section.
*"* public components of class CX_DEMO_CR_CUSTOMER
*"* do not include other source files here!!!

  methods CONSTRUCTOR
    importing
      !TEXTID like IF_T100_MESSAGE=>T100KEY optional
      !PREVIOUS like PREVIOUS optional .
protected section.
*"* protected components of class CX_DEMO_CR_CUSTOMER
*"* do not include other source files here!!!
private section.
*"* private components of class ZCX_MA_CUSTOMER
*"* do not include other source files here!!!
ENDCLASS.



CLASS CX_DEMO_CR_CUSTOMER IMPLEMENTATION.


method CONSTRUCTOR.
CALL METHOD SUPER->CONSTRUCTOR
EXPORTING
PREVIOUS = PREVIOUS
.
clear me->textid.
if textid is initial.
  IF_T100_MESSAGE~T100KEY = IF_T100_MESSAGE=>DEFAULT_TEXTID.
else.
  IF_T100_MESSAGE~T100KEY = TEXTID.
endif.
endmethod.
ENDCLASS.
