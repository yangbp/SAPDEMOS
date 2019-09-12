*&-------------------------------------------------------------------*
*& Subroutinenpool DEMO_GENERIC_TEMPLATE
*&-------------------------------------------------------------------*

PROGRAM demo_generic_template.

CLASS demo DEFINITION FINAL.
  PUBLIC SECTION.
    CLASS-METHODS main RAISING cx_static_check cx_dynamic_check.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.

* declarations

* implementation

  ENDMETHOD.
ENDCLASS.
