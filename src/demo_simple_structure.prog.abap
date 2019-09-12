REPORT demo_simple_structure.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA:
      BEGIN OF address,
        name   TYPE string VALUE `Mr. Duncan Pea`,
        street TYPE string VALUE `Vegetable Lane 11`,
        city   TYPE string VALUE `349875 Botanica`,
      END OF address.
    cl_demo_output=>display( address ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
