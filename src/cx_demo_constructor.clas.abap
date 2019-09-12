class CX_DEMO_CONSTRUCTOR definition
  public
  inheriting from CX_STATIC_CHECK
  final
  create public .

*"* public components of class CX_DEMO_CONSTRUCTOR
*"* do not include other source files here!!!
public section.

  constants CX_DEMO_CONSTRUCTOR type SOTR_CONC
 value '1CB1326C481CD511AE6E0800062AFB6D' .
  data MY_TEXT type SY-REPID .

  methods CONSTRUCTOR
    importing
      !TEXTID like TEXTID optional
      !PREVIOUS like PREVIOUS optional
      value(MY_TEXT) type SY-REPID optional .
protected section.
*"* protected components of class CX_DEMO_WITH_CONSTRUCTOR
*"* do not include other source files here!!!
private section.
*"* private components of class CX_DEMO_WITH_CONSTRUCTOR
*"* do not include other source files here!!!
ENDCLASS.



CLASS CX_DEMO_CONSTRUCTOR IMPLEMENTATION.


method CONSTRUCTOR .
CALL METHOD SUPER->CONSTRUCTOR
EXPORTING
TEXTID = TEXTID
PREVIOUS = PREVIOUS
.
 IF textid IS INITIAL.
   me->textid = CX_DEMO_CONSTRUCTOR .
 ENDIF.
me->MY_TEXT = MY_TEXT .
endmethod.
ENDCLASS.
