REPORT demo_cds_derived_inherit_annos.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA(out) = cl_demo_output=>new( ).
    cl_dd_ddl_annotation_service=>get_annos(
      EXPORTING entityname = 'DEMO_CDS_ANNO_INHERITANCE_1'
      IMPORTING element_annos = DATA(element_annos) ).
    SORT element_annos BY elementname annoname.
    out->next_section( 'Without @Metadata.ignorePropagatedAnnotations'
      )->write( element_annos ).
    cl_dd_ddl_annotation_service=>get_annos(
      EXPORTING entityname = 'DEMO_CDS_ANNO_INHERITANCE_1A'
      IMPORTING element_annos = element_annos ).
    SORT element_annos BY elementname annoname.
    out->next_section( 'With @Metadata.ignorePropagatedAnnotations'
      )->display( element_annos ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
