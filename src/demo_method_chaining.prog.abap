REPORT demo_method_chaining.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
  PRIVATE SECTION.
    METHODS meth  IMPORTING str        TYPE string
                  RETURNING value(ref) TYPE REF TO demo.
    DATA text TYPE string.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA oref TYPE REF TO demo.
    CREATE OBJECT oref.
    cl_demo_output=>display(
      oref->meth( `Hello ` )->meth( `world` )->meth( `!` )->text ).
  ENDMETHOD.
  METHOD meth.
    text = text && str.
    ref = me.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
