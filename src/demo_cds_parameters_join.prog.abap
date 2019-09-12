REPORT demo_cds_parameters_join.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA:
      from_distance TYPE s_distance VALUE 2000,
      to_distance   TYPE s_distance VALUE 6000,
      unit          TYPE s_distid   VALUE 'MI'.
    cl_demo_input=>new(
      )->add_field( CHANGING field = from_distance
      )->add_field( CHANGING field = to_distance
      )->add_field( CHANGING field = unit
      )->request( ).

      SELECT *
             FROM demo_cds_parameters_join(
                    in_distance_l = @from_distance,
                    in_distance_u = @to_distance,
                    in_unit       = @unit )
             ORDER BY carrname, connid
             INTO TABLE @DATA(result).
      cl_demo_output=>display( result ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
