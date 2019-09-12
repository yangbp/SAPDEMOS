REPORT demo_data_conversion_structure.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.

    DATA: BEGIN OF fs1,
             int   TYPE i            VALUE 5,
             pack  TYPE p DECIMALS 2 VALUE '2.26',
             text  TYPE c LENGTH 10  VALUE 'Fine Text',
             float TYPE decfloat16   VALUE '1.234e+05',
             date  TYPE d            VALUE '19950916',
          END OF fs1.

    DATA: BEGIN OF fs2,
             int  TYPE i            VALUE 3,
             pack TYPE p DECIMALS 2 VALUE '72.34',
             text TYPE c LENGTH 5   VALUE 'Hello',
          END OF fs2.

    DATA(out) = cl_demo_output=>new(
      )->begin_section( 'Source'
      )->write( |{ fs1-int   width = 10 } {
                   fs1-pack  width = 10 } {
                   fs1-text  width = 10 } {
                   fs1-float width = 10 } {
                   fs1-date  width = 10 }| ).

    out->next_section( 'Target'
      )->write( |{ fs2-int  width = 10 } {
                   fs2-pack width = 10 } {
                   fs2-text width = 10 }| ).

    fs2 = fs1.

    out->next_section( 'Result'
      )->display( |{ fs2-int  width = 10 } {
                     fs2-pack width = 10 } {
                     fs2-text width = 10 }| ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
