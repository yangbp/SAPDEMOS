REPORT demo_cds_association_path.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA carrid TYPE scarr-carrid VALUE 'AA'.
    cl_demo_input=>request( CHANGING field = carrid ).

    "Path expressions in Open SQL
    SELECT scarr~carrname,
           \_spfli-connid AS connid,
           \_spfli\_sflight-fldate AS fldate,
           \_spfli\_sairport-name AS name
           FROM demo_cds_assoc_scarr AS scarr
           WHERE scarr~carrid = @carrid
           ORDER BY carrname, connid, fldate
           INTO TABLE @DATA(result1).

    "Joins in Open SQL
    SELECT scarr~carrname AS carrname,
           spfli~connid   AS connid,
           sflight~fldate AS fldate,
           sairport~name  AS name
           FROM scarr  LEFT OUTER JOIN spfli
                         ON spfli~carrid = scarr~carrid
                       LEFT OUTER JOIN sflight
                         ON sflight~carrid = spfli~carrid AND
                            sflight~connid = spfli~connid
                       LEFT OUTER JOIN sairport
                         ON sairport~id = spfli~airpfrom
           WHERE scarr~carrid = @carrid
           ORDER BY carrname, connid, fldate
           INTO TABLE @DATA(result2).
    ASSERT result1 = result2.

    "Path expressions in CDS
    SELECT *
       FROM demo_cds_use_assocs( p_carrid = @carrid )
       ORDER BY carrname, connid, fldate
       INTO TABLE @DATA(result3).
    ASSERT result1 = result3.

    "Joins in CDS
    SELECT *
       FROM demo_cds_outer_joins( p_carrid = @carrid )
       ORDER BY carrname, connid, fldate
       INTO TABLE @DATA(result4).
    ASSERT result1 = result4.

    cl_demo_output=>display( result1 ).

  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
