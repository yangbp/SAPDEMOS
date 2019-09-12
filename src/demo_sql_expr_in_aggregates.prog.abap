REPORT demo_sql_expr_in_aggregates.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS:
      main,
      class_constructor.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA(out) = cl_demo_output=>new( ).

    SELECT char1, char2, num1, num2, num1 + num2 AS sum,
                                     num1 * num2 AS product
           FROM demo_expressions
           ORDER BY char1, char2
           INTO TABLE @DATA(ungrouped).
    out->write( ungrouped ).

    SELECT char1 && '_' && char2 AS group,
           MAX( num1 + num2 ) AS max,
           MIN( num1 + num2 ) AS min,
           MIN( num1 * num2 ) AS min_product
           FROM demo_expressions
           GROUP BY char1, char2
           ORDER BY group
           INTO TABLE @DATA(grouped).
    out->write( grouped ).

    SELECT char1 && '_' && char2 AS group,
           MAX( num1 + num2 ) AS max,
           MIN( num1 + num2 ) AS min
           FROM demo_expressions
           GROUP BY char1, char2
           HAVING MIN( num1 * num2 ) > 25
           ORDER BY group
           INTO TABLE @DATA(grouped_having).
    out->write( grouped_having ).

    out->display(  ).
  ENDMETHOD.
  METHOD class_constructor.
    TYPES tab_type TYPE STANDARD TABLE OF
                   demo_expressions WITH EMPTY KEY.
    DELETE FROM demo_expressions.
    INSERT demo_expressions FROM TABLE @( REDUCE tab_type(
      LET r1 = cl_abap_random_int=>create(
                 seed = CONV i( sy-uzeit ) min = 1 max = 10 )
          r2 = cl_abap_random_int=>create(
                 seed = CONV i( r1->get_next( ) ) min = 0 max = 1 )
          c = `AB` IN
      INIT t TYPE tab_type
      FOR i = 0 THEN i + 1 UNTIL i > 25
      NEXT t = VALUE #(
                 BASE t ( id    = sy-abcde+i(1)
                          num1  = r1->get_next( )
                          num2  = r1->get_next( )
                          char1 = substring( val = c
                                             off = r2->get_next( )
                                             len = 1 ) &&
                                  substring( val = c
                                             off = r2->get_next( )
                                             len = 1 )
                          char2 = substring( val = c
                                             off = r2->get_next( )
                                             len = 1 ) &&
                                  substring( val = c
                                             off = r2->get_next( )
                                             len = 1 ) ) ) ) ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
