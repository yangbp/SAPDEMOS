REPORT demo_sql_expr_with_group_by.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DELETE FROM demo_expressions.
    INSERT demo_expressions FROM TABLE @( VALUE #(
      ( id = 1 num1 = 1 num2 = 1 )
      ( id = 2 num1 = 2 num2 = 4 )
      ( id = 3 num1 = 3 num2 = 2 )
      ( id = 4 num1 = 3 num2 = 2 )
      ( id = 5 num1 = 5 num2 = 1 )
      ( id = 6 num1 = 1 num2 = 1 )
      ( id = 7 num1 = 1 num2 = 1 ) ) ).

    data(out) = cl_demo_output=>new( ).

    out->begin_section( `GROUP BY num1, num2` ).
    SELECT num1 + num2 AS sum, COUNT( * ) AS count
           FROM demo_expressions
           GROUP BY num1, num2
           ORDER BY sum
           INTO TABLE @DATA(result1).
    out->write( result1 ).

    out->next_section( `GROUP BY num1 + num2` ).
    SELECT num1 + num2 AS sum, COUNT( * ) AS count
           FROM demo_expressions
           GROUP BY num1 + num2
           ORDER BY sum
           INTO TABLE @DATA(result2).
    out->write( result2 ).

    out->display( ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
