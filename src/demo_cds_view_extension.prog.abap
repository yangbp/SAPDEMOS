REPORT demo_cds_view_extension.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA(out) = cl_demo_output=>new( ).

    SELECT *
       FROM demo_cds_original_view
       ORDER BY carrier, flight
       INTO TABLE @DATA(result).

    out->next_section( 'Entity fields'
      )->write( CAST cl_abap_structdescr(
                  cl_abap_typedescr=>describe_by_name(
                    'DEMO_CDS_ORIGINAL_VIEW' ) )->components
      )->next_section( 'Database view fields'
      )->write( CAST cl_abap_structdescr(
                  cl_abap_typedescr=>describe_by_name(
                    'DEMO_CDS_ORIG' ) )->components
      )->next_section( 'Appended fields'
      )->write( CAST cl_abap_structdescr(
                  cl_abap_typedescr=>describe_by_name(
                    'DEMO_CDS_EXTENS' ) )->components
      )->next_section( 'SELECT'
      )->write( result
      )->display( ).

  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
