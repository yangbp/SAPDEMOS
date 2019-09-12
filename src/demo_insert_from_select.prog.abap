REPORT demo_insert_from_select.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    "INSERT FROM TABLE
    SELECT
      FROM scarr AS s
           INNER JOIN spfli AS p ON s~carrid = p~carrid
      FIELDS s~mandt,
             s~carrname,
             p~distid,
             SUM( p~distance ) AS sum_distance
      GROUP BY s~mandt, s~carrname, p~distid
      INTO TABLE @DATA(temp).
    INSERT demo_sumdist_agg FROM TABLE @temp.

    SELECT * FROM demo_sumdist_agg
      ORDER BY carrname, distid, sum_distance
      INTO TABLE @DATA(insert_from_table).

    DELETE FROM demo_sumdist_agg.

    "INSERT FROM SELECT
    INSERT demo_sumdist_agg FROM
      ( SELECT
          FROM scarr AS s
            INNER JOIN spfli AS p ON s~carrid = p~carrid
          FIELDS s~carrname,
                 p~distid,
                 SUM( p~distance ) AS sum_distance
          GROUP BY s~mandt, s~carrname, p~distid ).

    SELECT * FROM demo_sumdist_agg
      ORDER BY carrname, distid, sum_distance
      INTO TABLE @DATA(insert_from_select).

    DELETE FROM demo_sumdist_agg. "GTT

    IF insert_from_select = insert_from_table.
      cl_demo_output=>new( )->write(
        `Same data inserted by FROM TABLE and FROM SELECT:`
       )->display( insert_from_select ).
    ENDIF.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
