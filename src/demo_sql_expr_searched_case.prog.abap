REPORT demo_sql_expr_searched_case.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    CONSTANTS: both_l  TYPE c LENGTH 20 VALUE 'Both < 50',
               both_gt TYPE c LENGTH 20 VALUE 'Both >= 50',
               others  TYPE c LENGTH 20 VALUE 'Others'.

    DATA(rnd) = cl_abap_random_int=>create(
      seed = CONV i( sy-uzeit ) min = 1 max = 100 ).
    DELETE FROM demo_expressions.
    INSERT demo_expressions FROM TABLE @( VALUE #(
      FOR i = 0 UNTIL i > 9
      ( id = i
        num1 = rnd->get_next( )
        num2 = rnd->get_next( ) ) ) ).

    SELECT num1, num2,
           CASE WHEN num1 <  50 AND num2 <  50 THEN @both_l
                WHEN num1 >= 50 AND num2 >= 50 THEN @both_gt
                ELSE @others
           END AS group
           FROM demo_expressions
           ORDER BY group
           INTO TABLE @DATA(results).

    cl_demo_output=>write( results ).

    LOOP AT results ASSIGNING FIELD-SYMBOL(<wa>)
                    GROUP BY ( key = <wa>-group size = GROUP SIZE )
                    INTO DATA(group).
      cl_demo_output=>write( group ).
    ENDLOOP.

    cl_demo_output=>display( ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
