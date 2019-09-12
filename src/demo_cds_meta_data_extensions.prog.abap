REPORT demo_cds_meta_data_extensions.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA(out) = cl_demo_output=>new(
      )->begin_section( `CDS Meta Data Extensions`
      )->begin_section( `CL_DD_DDL_ANNOTATION_SERVICE` ).
    cl_dd_ddl_annotation_service=>get_annos(
      EXPORTING
        entityname         =     'DEMO_CDS_PARAMETERS'
        variant            =      ''
        metadata_extension = abap_true
      IMPORTING
        entity_annos       =     DATA(entity_annos)
        element_annos      =     DATA(element_annos)
        parameter_annos    =     DATA(parameter_annos) ).
    out->write( entity_annos
      )->write( element_annos
      )->write( parameter_annos
      )->next_section( `CL_DD_DDL_ANALYZE` ).
    cl_dd_ddl_analyze=>get_annotations(
      EXPORTING ddlnames = VALUE #( ( 'DEMO_CDS_PARAMETERS' ) )
                leaves_only = abap_false
      IMPORTING headerannos = DATA(headerannos)
                fieldannos  = DATA(fieldannos)
                parannos    = DATA(parannos) ).
    out->write( headerannos
      )->write( fieldannos
      )->write( parannos
      )->display( ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
