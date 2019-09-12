REPORT demo_append_view.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA(out) = cl_demo_output=>new( ).

    SELECT *
       FROM demo_original
       ORDER BY carrier, flight
       INTO TABLE @DATA(result).

    out->next_section( 'View fields'
      )->write( CAST cl_abap_structdescr(
                  cl_abap_typedescr=>describe_by_name(
                    'DEMO_ORIGINAL') )->components
      )->next_section( 'Appended fields'
      )->write( CAST cl_abap_structdescr(
                  cl_abap_typedescr=>describe_by_name(
                    'DEMO_APPEND_VIEW') )->components
      )->next_section( 'SELECT'
      )->write( result
      )->display( ).

  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
