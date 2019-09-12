REPORT demo_sql_upper.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA:
      query TYPE string VALUE `ERROR`,
      rows  TYPE i      VALUE 100.
    cl_demo_input=>add_field( CHANGING field = query ).
    cl_demo_input=>request(   CHANGING field = rows ).
    query = `%` && to_upper( query ) && `%`.
    rows  = COND #( WHEN rows <= 0 THEN 100 ELSE rows ).

    "UPPER in CDS view
    SELECT arbgb, msgnr, text
           FROM demo_cds_upper
           WHERE sprsl = 'E' AND
                 upper_text LIKE @query
           ORDER BY arbgb, msgnr, text
           INTO TABLE @DATA(result1)
           UP TO @rows ROWS.

    "UPPER in Open SQL
    SELECT arbgb, msgnr, text
           FROM t100
           WHERE sprsl = 'E' AND
                 upper( text ) LIKE @query
           ORDER BY arbgb, msgnr, text
           INTO TABLE @DATA(result2)
           UP TO @rows ROWS.

    ASSERT result1 = result2.

    cl_demo_output=>display( result1 ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
