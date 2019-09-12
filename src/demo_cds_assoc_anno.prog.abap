REPORT demo_cds_assoc_anno.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA annos TYPE cl_dd_ddl_annotation_service=>ty_t_elmnt_anno_val_src_dtel.

    cl_dd_ddl_annotation_service=>get_annos(
          EXPORTING
            entityname    = 'DEMO_CDS_ASSOC_ANNO1_INH'
          IMPORTING
            element_annos         =  annos ).
    cl_demo_output=>write( annos ).

    cl_dd_ddl_annotation_service=>get_annos(
          EXPORTING
            entityname    = 'DEMO_CDS_ASSOC_ANNO1_LOC'
          IMPORTING
            element_annos         =  annos ).
    cl_demo_output=>write( annos ).

    cl_demo_output=>display(  ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
