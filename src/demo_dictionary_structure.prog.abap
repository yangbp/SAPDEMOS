REPORT demo_dictionary_structure.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.
CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA carrier TYPE scarr.
    carrier-carrid = 'UA'.
    cl_demo_input=>request( CHANGING field = carrier-carrid ).
    SELECT SINGLE *
           FROM scarr
           INTO carrier
           WHERE carrid = carrier-carrid.
    cl_demo_output=>display( carrier ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
