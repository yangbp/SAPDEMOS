REPORT demo_reduce_cond_iteration.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA(out) = cl_demo_output=>new(
      )->next_section( 'Summation'
      )->write( REDUCE i( INIT sum = 0
                          FOR n = 1 UNTIL n > 10
                          NEXT sum = sum + n )
      )->next_section( 'Concatenation without THEN'
      )->write( REDUCE string( INIT text = `Count up:`
                               FOR n = 1 UNTIL n > 10
                               NEXT text = text && | { n }| )
      )->next_section( 'Concatenation with THEN'
      )->write( REDUCE string( INIT text = `Count down:`
                               FOR n = 10 THEN n - 1 WHILE n > 0
                               NEXT text = text && | { n }| )
      )->next_section( 'Non arithmetic expression'
      )->write( REDUCE string( INIT text = ``
                               FOR t = `x` THEN t && `y`
                                           UNTIL strlen( t ) > 10
                               NEXT text = text && |{ t } | )
      )->display( ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
