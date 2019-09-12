REPORT demo_sql_date_functions.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DELETE FROM demo_expressions.
    INSERT demo_expressions FROM @(
      VALUE #( id = 'X' dats1 = sy-datum dats2 = sy-datum + 100 ) ).

    SELECT SINGLE dats1, dats2,
                  dats_is_valid( dats1 ) AS valid,
                  dats_days_between( dats1, dats2 ) AS days_between,
                  dats_add_days( dats1,100 ) AS add_days,
                  dats_add_months( dats1,-1 ) AS add_month
           FROM demo_expressions
           INTO @DATA(result).

    cl_demo_output=>display( result ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
