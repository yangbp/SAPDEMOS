class CX_DEMO_EXCEPTION definition
  public
  inheriting from CX_STATIC_CHECK
  final
  create public .

public section.
*"* public components of class CX_DEMO_EXCEPTION
*"* do not include other source files here!!!

  interfaces IF_T100_MESSAGE .

  data EXCEPTION_TEXT type CHAR255 .

  methods CONSTRUCTOR
    importing
      !TEXTID like IF_T100_MESSAGE=>T100KEY optional
      !PREVIOUS like PREVIOUS optional
      !EXCEPTION_TEXT type CHAR255 optional .
protected section.
*"* protected components of class CX_DEMO_EXCEPTION
*"* do not include other source files here!!!
private section.
*"* private components of class CX_DEMO_EXCEPTION
*"* do not include other source files here!!!
ENDCLASS.



CLASS CX_DEMO_EXCEPTION IMPLEMENTATION.


method CONSTRUCTOR.
CALL METHOD SUPER->CONSTRUCTOR
EXPORTING
PREVIOUS = PREVIOUS
.
me->EXCEPTION_TEXT = EXCEPTION_TEXT .
clear me->textid.
if textid is initial.
  IF_T100_MESSAGE~T100KEY = IF_T100_MESSAGE=>DEFAULT_TEXTID.
else.
  IF_T100_MESSAGE~T100KEY = TEXTID.
endif.
endmethod.
ENDCLASS.
