REPORT demo_cds_ddl_texts.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA(out) = cl_demo_output=>new( ).

    out->next_section( `Entity Text` ).
    DATA(entity_label_d) =
      cl_dd_ddl_annotation_service=>get_label_4_entity(
        EXPORTING entityname = 'DEMO_CDS_TEXT_ANNOTATIONS'
                  language   = 'D' ).
    out->write( `D: ` && entity_label_d ).
    DATA(entity_label_e) =
      cl_dd_ddl_annotation_service=>get_label_4_entity(
        EXPORTING entityname = 'DEMO_CDS_TEXT_ANNOTATIONS'
                  language   = 'E' ).
    out->write( `E: ` && COND string(
                  WHEN entity_label_e IS NOT INITIAL
                    THEN entity_label_e
                  ELSE `not translated` ) ).

    out->next_section( `Parameter Text` ).
    cl_dd_ddl_annotation_service=>get_direct_annos_4_parameter(
      EXPORTING
        entityname    = 'DEMO_CDS_TEXT_ANNOTATIONS'
        parametername = 'PARAM'
        language      =  'D'
      IMPORTING
        annos         =  DATA(param_annos_d) ).
    out->write( `D: ` &&
                param_annos_d[ annoname =
                  'ENDUSERTEXT.LABEL' ]-value ).
    cl_dd_ddl_annotation_service=>get_direct_annos_4_parameter(
      EXPORTING
        entityname    = 'DEMO_CDS_TEXT_ANNOTATIONS'
        parametername = 'PARAM'
        language      =  'E'
      IMPORTING
        annos         =  DATA(param_annos_e) ).
    out->write( `E: ` && COND string(
                  WHEN line_exists( param_annos_e[
                         annoname = 'ENDUSERTEXT.LABEL' ] )
                    THEN  param_annos_e[
                            annoname = 'ENDUSERTEXT.LABEL' ]-value
                    ELSE `not translated` ) ).

    out->next_section( `Element Text` ).
    cl_dd_ddl_annotation_service=>get_direct_annos_4_element(
      EXPORTING
        entityname    = 'DEMO_CDS_TEXT_ANNOTATIONS'
        elementname   = 'ID'
        language      =  'D'
      IMPORTING
        annos         = DATA(element_annos_d) ).
    out->write( `D: ` &&
                element_annos_d[ annoname =
                  'ENDUSERTEXT.LABEL' ]-value ).
    cl_dd_ddl_annotation_service=>get_direct_annos_4_element(
      EXPORTING
        entityname    = 'DEMO_CDS_TEXT_ANNOTATIONS'
        elementname   = 'ID'
        language      =  'E'
      IMPORTING
        annos         =  DATA(element_annos_e) ).
    out->write( `E: ` && COND string(
                  WHEN line_exists( element_annos_e[
                         annoname = 'ENDUSERTEXT.LABEL' ] )
                    THEN  element_annos_e[
                            annoname = 'ENDUSERTEXT.LABEL' ]-value
                    ELSE `not translated` ) ).

    out->next_section( `Element Quickinfo` ).
    cl_dd_ddl_annotation_service=>get_direct_annos_4_element(
      EXPORTING
        entityname    = 'DEMO_CDS_TEXT_ANNOTATIONS'
        elementname   = 'ID'
        language      =  'D'
      IMPORTING
        annos         =  element_annos_d ).
    out->write( `D: ` &&
                element_annos_d[ annoname =
                  'ENDUSERTEXT.QUICKINFO' ]-value ).
    cl_dd_ddl_annotation_service=>get_direct_annos_4_element(
      EXPORTING
        entityname    = 'DEMO_CDS_TEXT_ANNOTATIONS'
        elementname   = 'ID'
        language      =  'E'
      IMPORTING
        annos         =  element_annos_e ).
    out->write( `E: ` && COND string(
                  WHEN line_exists( element_annos_e[
                         annoname = 'ENDUSERTEXT.QUICKINFO' ] )
                    THEN  element_annos_e[
                            annoname = 'ENDUSERTEXT.QUICKINFO' ]-value
                    ELSE `not translated` ) ).

    out->display( ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
