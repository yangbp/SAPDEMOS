REPORT demo_cds_parameters_unit.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA:
      from_distance TYPE s_distance VALUE 0000,
      to_distance   TYPE s_distance VALUE 1000.
    cl_demo_input=>new(
      )->add_field( CHANGING field = from_distance
      )->add_field( CHANGING field = to_distance
      )->request( ).

    SELECT carrid, connid, cityfrom, cityto, distance, distid
           FROM demo_cds_parameters( p_distance_l = @from_distance,
                                     p_distance_u = @to_distance,
                                     p_unit       = 'MI' )
    UNION
    SELECT carrid, connid, cityfrom, cityto, distance, distid
           FROM demo_cds_parameters( p_distance_l = @from_distance,
                                     p_distance_u = @to_distance,
                                     p_unit       = 'KM' )
    ORDER BY distid, carrid, connid
    INTO TABLE @DATA(result).
    cl_demo_output=>display( result ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
