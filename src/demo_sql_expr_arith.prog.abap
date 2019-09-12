REPORT demo_sql_expr_arith.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA(rnd) = cl_abap_random_int=>create(
      seed = CONV i( sy-uzeit ) min = 1 max = 100 ).
    DELETE FROM demo_expressions.
    INSERT demo_expressions FROM TABLE @( VALUE #(
      FOR i = 0 UNTIL i > 9
      ( id = |{ i }|
        num1 = rnd->get_next( )
        num2 = rnd->get_next( ) ) ) ).

    DATA(offset) = 10000.
    SELECT id, num1, num2,
           CAST( num1 AS FLTP ) / CAST( num2 AS FLTP ) AS ratio,
           DIV( num1, num2 ) AS div,
           DIVISION( num1, num2, 2 ) AS division,
           MOD( num1, num2 ) AS mod,
           @offset + ABS( num1 - num2 ) AS sum
           FROM demo_expressions
           ORDER BY sum DESCENDING
           INTO TABLE @DATA(results).

    cl_demo_output=>display( results ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
