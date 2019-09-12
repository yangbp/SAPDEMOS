REPORT demo_table_comprh_locals.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    TYPES:
      array TYPE STANDARD TABLE OF i WITH EMPTY KEY,
      BEGIN OF line,
        col1 TYPE i,
        col2 TYPE i,
        col3 TYPE i,
      END OF line,
      itab TYPE STANDARD TABLE OF line WITH EMPTY KEY.

    CONSTANTS factor TYPE i VALUE 1000.

    DATA(array) = VALUE array(
      ( 3 ) ( 5 ) ( 7 ) ( 9 ) ).

    DATA(itab) = VALUE itab(
      FOR x IN array INDEX INTO idx
         LET off = factor * idx IN
        ( col1 = x col2 = x * x col3 = x + off ) ).

    cl_demo_output=>display( itab ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
