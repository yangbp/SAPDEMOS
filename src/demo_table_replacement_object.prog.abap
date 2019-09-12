REPORT demo_table_replacement_object.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS:
      class_constructor,
      main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA(out) = cl_demo_output=>new( ).

    "Aggregate table (GTT)
    SELECT FROM demo_sumdist_agg
           FIELDS *
           ORDER BY PRIMARY KEY
           INTO TABLE @DATA(result_agg).
    DELETE FROM demo_sumdist_agg.

    "Table with replacement object
    SELECT FROM demo_sumdist
           FIELDS *
           ORDER BY PRIMARY KEY
           INTO TABLE @DATA(result).

    ASSERT result = result_agg.

    "Direct access to CDS view
    SELECT FROM demo_cds_sumdist
           FIELDS @sy-mandt AS mandt, demo_cds_sumdist~*
           ORDER BY PRIMARY KEY
           INTO TABLE @DATA(result_cds).

    ASSERT result_cds = result.

    out->write( result ).

    "Classic view on demo_sumdist without replacement object
    SELECT FROM demo_sumdist_obs
           FIELDS *
           ORDER BY PRIMARY KEY
           INTO TABLE @DATA(result_view_obs).
    IF result <> result_view_obs.
      out->write(
        'Classic view without replacement object differs.' ).
    ENDIF.

    "Classic view on demo_sumdist with replacement object
    SELECT FROM demo_sumdistview
           FIELDS *
           ORDER BY PRIMARY KEY
           INTO TABLE @DATA(result_view).
    IF result =  result_view.
      out->write(
        'Classic view with replacement object is the same.' ).
    ENDIF.

    out->display( ).
  ENDMETHOD.
  METHOD class_constructor.
    DELETE FROM demo_sumdist_agg.
    INSERT demo_sumdist_agg FROM
      ( SELECT
          FROM scarr AS s
            INNER JOIN spfli AS p ON s~carrid = p~carrid
          FIELDS s~carrname,
                 p~distid,
                 SUM( p~distance ) AS sum_distance
          GROUP BY s~mandt, s~carrname, p~distid ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
