class CX_DEMO_ABS_TOO_LARGE definition
  public
  inheriting from CX_STATIC_CHECK
  final
  create public .

*"* public components of class CX_DEMO_ABS_TOO_LARGE
*"* do not include other source files here!!!
public section.

  constants CX_DEMO_ABS_TOO_LARGE type SOTR_CONC
 value '90AC0706FC13D511AE6808000627C664' .

  methods CONSTRUCTOR
    importing
      !TEXTID like TEXTID optional
      !PREVIOUS like PREVIOUS optional .
protected section.
*"* protected components of class CX_DEMO_ABS_TOO_LARGE
*"* do not include other source files here!!!
private section.
*"* private components of class CX_DEMO_ABS_TOO_LARGE
*"* do not include other source files here!!!
ENDCLASS.



CLASS CX_DEMO_ABS_TOO_LARGE IMPLEMENTATION.


method CONSTRUCTOR .
CALL METHOD SUPER->CONSTRUCTOR
EXPORTING
TEXTID = TEXTID
PREVIOUS = PREVIOUS
.
 IF textid IS INITIAL.
   me->textid = CX_DEMO_ABS_TOO_LARGE .
 ENDIF.
endmethod.
ENDCLASS.
