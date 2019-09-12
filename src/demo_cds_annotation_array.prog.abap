REPORT demo_cds_annotation_array.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    cl_dd_ddl_analyze=>get_annotations(
      EXPORTING ddlnames = VALUE #( ( 'DEMO_CDS_ANNOTATION_ARRAY' ) )
                leaves_only = abap_true
      IMPORTING
                fieldannos  = DATA(annos) ).
    cl_demo_output=>display( annos ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
