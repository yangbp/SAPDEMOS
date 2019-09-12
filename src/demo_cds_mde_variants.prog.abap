REPORT demo_cds_mde_variants.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA(out) = cl_demo_output=>new(
      )->next_section( 'No Meta Data Extension' ).
    cl_dd_ddl_annotation_service=>get_annos(
      EXPORTING
        entityname         =     'DEMO_CDS_MDE'
        metadata_extension =     abap_false
      IMPORTING
        element_annos      =     DATA(element_annos) ).
    DELETE element_annos WHERE elementname <> 'ELEMENT'.
    out->write( element_annos
      )->next_section( 'With Meta Data Extension'
      )->begin_section( 'No Variant' ).
    cl_dd_ddl_annotation_service=>get_annos(
      EXPORTING
        entityname         =     'DEMO_CDS_MDE'
        metadata_extension =     abap_true
      IMPORTING
        element_annos      =     element_annos ).
    DELETE element_annos WHERE elementname <> 'ELEMENT'.
    out->write( element_annos
      )->next_section( 'DemoVariant1' ).
    cl_dd_ddl_annotation_service=>get_annos(
      EXPORTING
        entityname         =     'DEMO_CDS_MDE'
        variant            =     'DEMOVARIANT1'
        metadata_extension =     abap_true
      IMPORTING
        element_annos      =     element_annos ).
    DELETE element_annos WHERE elementname <> 'ELEMENT'.
    out->write( element_annos
      )->next_section( 'DemoVariant2' ).
    cl_dd_ddl_annotation_service=>get_annos(
      EXPORTING
        entityname         =     'DEMO_CDS_MDE'
        variant            =     'DEMOVARIANT2'
        metadata_extension =     abap_true
      IMPORTING
        element_annos      =     element_annos ).
    DELETE element_annos WHERE elementname <> 'ELEMENT'.
    out->write( element_annos
      )->next_section( 'Wrong Variant' ).
    cl_dd_ddl_annotation_service=>get_annos(
      EXPORTING
        entityname         =     'DEMO_CDS_MDE'
        variant            =     '§wrxlbrxlkrk'
        metadata_extension =     abap_true
      IMPORTING
        element_annos      =     element_annos ).
    DELETE element_annos WHERE elementname <> 'ELEMENT'.
    out->write( element_annos
      )->display( ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
