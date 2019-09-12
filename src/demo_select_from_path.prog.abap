REPORT demo_select_from_path.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA:
      tz    TYPE s_tzone    VALUE 'UTC+1',
      currc TYPE s_currcode VALUE 'EUR'.

    cl_demo_input=>new(
      )->add_field( CHANGING field = tz
      )->add_field( CHANGING field = currc )->request( ).

    "Path expression in Open SQL
    SELECT DISTINCT carrname
           FROM demo_cds_assoc_sairport_tz( tz = @( to_upper( tz ) ) )
                \_spfli
                \_scarr[ currcode = @( CONV s_currcode(
                                              to_upper( currc ) ) ) ]
                AS scarr
           ORDER BY carrname
           INTO TABLE @DATA(result_path).

    "Joins in Open SQL
    SELECT DISTINCT scarr~carrname
           FROM sairport INNER JOIN spfli
                           ON  spfli~airpfrom = sairport~id
                         INNER JOIN scarr
                           ON  scarr~carrid   = spfli~carrid AND
                               scarr~currcode = @( to_upper( currc ) )
           WHERE sairport~time_zone = @( to_upper( tz ) )
           ORDER BY scarr~carrname
           INTO TABLE @DATA(result_join).

    ASSERT result_path = result_join.
    cl_demo_output=>display( result_path ).

  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
