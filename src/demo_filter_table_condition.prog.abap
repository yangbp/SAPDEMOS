REPORT demo_filter_table_condition.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-DATA:
      itab TYPE SORTED TABLE OF i WITH NON-UNIQUE KEY table_line,
      ftab TYPE SORTED TABLE OF i WITH NON-UNIQUE KEY table_line.
    CLASS-METHODS:
      main,
      class_constructor.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    cl_demo_output=>new(
      )->next_section( 'itab'
      )->write( itab
      )->next_section( 'ftab'
      )->write( ftab
      )->next_section(
        'FILTER #( itab IN ftab WHERE table_line = table_line )'
      )->write(
         FILTER #( itab IN ftab WHERE table_line = table_line )
      )->next_section(
        'FILTER #( itab EXCEPT IN ftab WHERE table_line = table_line )'
      )->write(
         FILTER #( itab EXCEPT IN ftab WHERE table_line = table_line )
      )->next_section(
        'FILTER #( itab IN ftab WHERE table_line > table_line )'
      )->write(
         FILTER #( itab IN ftab WHERE table_line > table_line )
      )->next_section(
        'FILTER #( itab IN ftab WHERE table_line <> table_line )'
      )->write(
         FILTER #( itab IN ftab WHERE table_line <> table_line )
      )->next_section(
        'FILTER #( itab IN ftab WHERE table_line <= table_line )'
      )->write(
         FILTER #( itab IN ftab WHERE table_line <= table_line )
    )->display( ).
  ENDMETHOD.
  METHOD class_constructor.
    DATA(rnd1) = cl_abap_random_int=>create(
     seed = CONV i( sy-uzeit ) min = 1 max = 7 ).
    DATA(rnd2) = cl_abap_random_int=>create(
     seed = CONV i( sy-uzeit ) min = 3 max = 10 ).
    itab = VALUE #( for j = 1 until j > 5 ( rnd1->get_next( ) ) ).
    ftab = VALUE #( for j = 1 until j > 5 ( rnd2->get_next( ) ) ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
