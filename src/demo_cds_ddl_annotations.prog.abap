REPORT demo_cds_ddl_annotations.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA(out) = cl_demo_output=>new( ).

    out->next_section(
      `SELECT from Annotation Tables` ).
    SELECT *
           FROM ddheadanno
           WHERE strucobjn = 'DEMO_CDS_VIEW_ANNOTATIONS'
           ORDER BY position
           INTO TABLE @DATA(ddheadanno).
    out->write( ddheadanno ).
    SELECT *
           FROM ddfieldanno
           WHERE strucobjn = 'DEMO_CDS_VIEW_ANNOTATIONS'
           ORDER BY lfieldname, position
           INTO TABLE @DATA(ddfieldanno).
    out->write( ddfieldanno ).
    SELECT *
           FROM ddparameteranno
           WHERE strucobjn = 'DEMO_CDS_VIEW_ANNOTATIONS'
           ORDER BY parametername, parpos
           INTO TABLE @DATA(ddparameteranno).
    out->write( ddparameteranno ).

    out->next_section(
    `CL_DD_DDL_ANALYZE=>GET_ANNOTATIONS( leaves_only = abap_false )` ).
    cl_dd_ddl_analyze=>get_annotations(
      EXPORTING ddlnames = VALUE #( ( 'DEMO_CDS_VIEW_ANNOTATIONS' ) )
                leaves_only = abap_false
      IMPORTING headerannos = DATA(headerannos)
                fieldannos  = DATA(fieldannos)
                parannos    = DATA(parannos) ).
    out->write( headerannos
      )->write( fieldannos
      )->write( parannos ).

    out->next_section(
    `CL_DD_DDL_ANALYZE=>GET_ANNOTATIONS( leaves_only = abap_true )` ).
    cl_dd_ddl_analyze=>get_annotations(
      EXPORTING ddlnames = VALUE #( ( 'DEMO_CDS_VIEW_ANNOTATIONS' ) )
                leaves_only = abap_true
      IMPORTING headerannos = headerannos
                fieldannos  = fieldannos
                parannos    = parannos ).
    out->write( headerannos
      )->write( fieldannos
      )->write( parannos ).

    out->next_section(
      `CL_DD_DDL_ANNOTATION_SERVICE=>GET_DIRECT_ANNOS_4_ENTITY` ).
    cl_dd_ddl_annotation_service=>get_direct_annos_4_entity(
        EXPORTING entityname = 'DEMO_CDS_VIEW_ANNOTATIONS'
        IMPORTING annos      =     DATA(annos) ).
    out->write( annos ).

    out->next_section(
      `CL_DD_DDL_ANNOTATION_SERVICE=>GET_ANNOS_4_ELEMENT`).

    DATA(elements) = CAST cl_abap_structdescr(
      cl_abap_typedescr=>describe_by_name( 'DEMO_CDS_VIEW_ANNOTATIONS'
        ) )->components.

    LOOP AT elements INTO DATA(element) .
      cl_dd_ddl_annotation_service=>get_annos_4_element(
        EXPORTING entityname = 'DEMO_CDS_VIEW_ANNOTATIONS'
                  elementname = CONV #( element-name )
        IMPORTING annos       = DATA(element_annos) ).
      out->write( element_annos ).
    ENDLOOP.

    out->next_section(
      `CL_DD_DDL_ANNOTATION_SERVICE=>GET_DRCT_ANNOS_4_ENTITY_PARAS`).
    cl_dd_ddl_annotation_service=>GET_DRCT_ANNOS_4_ENTITY_PARAS(
        EXPORTING entityname = 'DEMO_CDS_VIEW_ANNOTATIONS'
        IMPORTING annos      =  DATA(parameter_annos) ).
    out->write( parameter_annos ).

    out->display( ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
