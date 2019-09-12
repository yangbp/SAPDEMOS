REPORT demo_cds_null_annos.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA(out) = cl_demo_output=>new( ).
    cl_dd_ddl_annotation_service=>get_annos(
      EXPORTING entityname = 'DEMO_CDS_ANNO_NULL_VALUE_1'
      IMPORTING element_annos = DATA(element_annos) ).
    SORT element_annos BY elementname annoname.
    out->next_section( 'Original Annotations'
      )->write( element_annos ).
    cl_dd_ddl_annotation_service=>get_annos(
      EXPORTING entityname = 'DEMO_CDS_ANNO_NULL_VALUE_2'
      IMPORTING element_annos = element_annos ).
    SORT element_annos BY elementname annoname.
    out->next_section( 'Filtered by Null Values'
      )->display( element_annos ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
