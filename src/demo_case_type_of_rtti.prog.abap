REPORT demo_case_type_of_rtti.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main IMPORTING param TYPE any.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA(typedescr) = cl_abap_typedescr=>describe_by_data( param ).
    CASE TYPE OF typedescr.
      WHEN TYPE cl_abap_elemdescr INTO DATA(elemdescr).
        cl_demo_output=>write( elemdescr->type_kind ).
      WHEN TYPE cl_abap_structdescr INTO DATA(structdescr).
        cl_demo_output=>write( structdescr->components ).
      WHEN TYPE cl_abap_tabledescr INTO DATA(tabledescr).
        cl_demo_output=>write( tabledescr->table_kind ).
      WHEN OTHERS.
        cl_demo_output=>write( 'Not supported' ).
    ENDCASE.
  ENDMETHOD.
ENDCLASS.

DATA: elem TYPE i,
      BEGIN OF struct,
        comp1 TYPE i,
        comp2 TYPE i,
      END OF struct,
      itab LIKE STANDARD TABLE OF struc WITH EMPTY KEY,
      dref TYPE REF TO i.

START-OF-SELECTION.
  demo=>main( elem ).
  demo=>main( struct ).
  demo=>main( itab ).
  demo=>main( dref ).

  cl_demo_output=>display( ).
