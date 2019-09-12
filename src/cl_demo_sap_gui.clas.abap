class CL_DEMO_SAP_GUI definition
  public
  final
  create public .

public section.

  class-methods CHECK
    returning
      value(FLAG) type ABAP_BOOL .
protected section.
private section.
ENDCLASS.



CLASS CL_DEMO_SAP_GUI IMPLEMENTATION.


  METHOD check.
    CALL FUNCTION 'GUI_IS_AVAILABLE'
      IMPORTING
        return = flag.
  ENDMETHOD.
ENDCLASS.
