REPORT demo_from_join_to_association.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.

    "Open SQL Join
    SELECT FROM spfli
              INNER JOIN scarr ON
                 spfli~carrid = scarr~carrid
           FIELDS scarr~carrname  AS carrier,
                  spfli~connid    AS flight,
                  spfli~cityfrom  AS departure,
                  spfli~cityto    AS arrival
           ORDER BY carrier, flight
           INTO TABLE @DATA(result_open_sql_join).

    "ABAP CDS Join
    SELECT FROM demo_cds_join1
           FIELDS *
           ORDER BY carrier, flight
           INTO TABLE @DATA(result_cds_join).

    "ABAP CDS Association
    SELECT FROM demo_cds_join2
           FIELDS *
           ORDER BY carrier, flight
           INTO TABLE @DATA(result_cds_assoc).

    ASSERT result_cds_join  = result_open_sql_join.
    ASSERT result_cds_assoc = result_cds_join.

    cl_demo_output=>display( result_cds_assoc ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
