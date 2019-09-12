REPORT demo_sql_avg.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DELETE FROM demo_expressions.
    INSERT demo_expressions
           FROM TABLE @(
                VALUE #( LET r = cl_abap_random_int=>create(
                                 seed = CONV i( sy-uzeit )
                                 min = 1 max = 10 ) IN
                         FOR i = 1 UNTIL i > 10
                           ( id   = CONV #( i )
                             num1 = r->get_next( ) ) ) ).

    SELECT
      FROM demo_expressions
      FIELDS
        AVG(          num1                ) AS avg_no_type,
        AVG( DISTINCT num1                ) AS avg_no_type_distinct,
        AVG(          num1 AS DEC( 10,0 ) ) AS avg_dec0,
        AVG( DISTINCT num1 AS DEC( 10,0 ) ) AS avg_dec0_distinct,
        AVG(          num1 AS DEC( 14,4 ) ) AS avg_dec4,
        AVG( DISTINCT num1 AS DEC( 14,4 ) ) AS avg_dec4_distinct
      INTO @DATA(result).

    cl_demo_output=>display( result ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
