REPORT demo_amdp_abap_types.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA itab TYPE cl_demo_amdp_abap_types=>itab.

    cl_demo_amdp_abap_types=>demo_abap_types( IMPORTING itab = itab ).

    cl_demo_output=>display( itab ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
