REPORT demo_select_union_sum_gtt.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA carrid TYPE sflight-carrid VALUE 'AA'.
    cl_demo_input=>request( CHANGING field = carrid ).

    INSERT demo_sflight_agg FROM (
    SELECT carrid,
           connid,
           CAST( '00000000' AS DATS ) AS fldate,
           SUM( seatsocc ) AS seatsocc
           FROM sflight
           WHERE carrid = @( to_upper( carrid ) )
           GROUP BY carrid, connid ).

    SELECT ' ' AS mark, carrid, connid, fldate, seatsocc
           FROM sflight
           WHERE carrid = @( to_upper( carrid ) )
           UNION SELECT 'X' AS mark,
                        carrid, connid, fldate, seatsocc
                        FROM demo_sflight_agg
           ORDER BY carrid, connid, mark, fldate, seatsocc
           INTO TABLE @DATA(result).

    DELETE FROM demo_sflight_agg.
    cl_demo_output=>display( result ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
