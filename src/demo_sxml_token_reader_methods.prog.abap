REPORT demo_sxml_token_reader_methods.

CLASS sxml_demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
  PRIVATE SECTION.
    CLASS-METHODS get_node_type
      IMPORTING node_type_int TYPE if_sxml_node=>node_type
      RETURNING value(node_type_string) TYPE string.
ENDCLASS.

CLASS sxml_demo IMPLEMENTATION.
  METHOD main.
    DATA(out) = cl_demo_output=>new( )->begin_section( `XML-Data` ).
    DATA(xml) = cl_abap_codepage=>convert_to(
     `<?xml version="1.0"?>` &&
     `<items>` &&
     `<item1 a1="11" b1="12" c1="13">1</item1>`  &&
     `<item2 a2="21" b2="22" c2="23">2</item2>`  &&
     `<item3 a3="31" b3="32" c3="33"><subItems>` &&
     `<subItem1>31</subItem1>` &&
     `<subItem2>32</subItem2>` &&
     `<subItem3>33</subItem3>` &&
     `</subItems></item3>` &&
     `<item4 a4="AA==" b4="AQ==" c4="Ag==">4</item4>` &&
     `</items>` ).
    out->write_xml( xml ).

    "Parsing all nodes
    out->next_section(
      `Parsing all Nodes of the XML-Data` ).
    DATA: BEGIN OF node,
            node_type  TYPE string,
            name       TYPE string,
            value      TYPE string,
          END OF node,
          nodes LIKE TABLE OF node.
    DATA(reader) = cl_sxml_string_reader=>create( xml ).
    TRY.
        DO.
          reader->next_node( ).
          IF reader->node_type = if_sxml_node=>co_nt_final.
            EXIT.
          ENDIF.
          APPEND VALUE #(
            node_type  = get_node_type( reader->node_type )
            name       = reader->name
            value      = reader->value ) TO nodes.
          IF reader->node_type = if_sxml_node=>co_nt_element_open.
            DO.
              reader->next_attribute( ).
              IF reader->node_type <> if_sxml_node=>co_nt_attribute.
                EXIT.
              ENDIF.
              APPEND VALUE #(
                node_type  = `attribute`
                name       = reader->name
                value      = reader->value ) TO nodes.
            ENDDO.
          ENDIF.
        ENDDO.
      CATCH cx_sxml_parse_error INTO DATA(parse_error).
        out->write_text( parse_error->get_text( ) ).
    ENDTRY.
    out->write_data( nodes ).

    "Push back node
    out->next_section( `Push Back one Node` ).
    reader = cl_sxml_string_reader=>create( xml ).
    TRY.
        DO.
          reader->next_node( ).
          IF reader->node_type = if_sxml_node=>co_nt_final.
            EXIT.
          ENDIF.
          IF reader->node_type = if_sxml_node=>co_nt_value AND
             reader->value = 2.
            reader->push_back( ).
            DO.
              reader->next_attribute( ).
              IF reader->node_type <> if_sxml_node=>co_nt_attribute.
                EXIT.
              ENDIF.
              out->write(
                       |{ reader->name } { reader->value }| ).
            ENDDO.
            reader->next_node( ).
          ENDIF.
        ENDDO.
      CATCH cx_sxml_parse_error INTO parse_error.
        out->write_text( parse_error->get_text( ) ).
    ENDTRY.

    "Handling attributes
    out->next_section( `Handling Attributes` ).
    reader = cl_sxml_string_reader=>create( xml ).
    TRY.
        DO.
          reader->next_node( ).
          IF reader->node_type = if_sxml_node=>co_nt_final.
            EXIT.
          ENDIF.
          IF reader->node_type = if_sxml_node=>co_nt_element_open.
            IF reader->name = 'item2'.
              reader->get_attribute_value( 'b2' ).
              out->begin_section( `Query one Attribute`
                )->write( |{ reader->name } { reader->value }|
                )->end_section( ).
            ENDIF.
            DO.
              reader->next_attribute( ).
              IF reader->node_type <> if_sxml_node=>co_nt_attribute.
                EXIT.
              ENDIF.
              IF reader->value = '33'.
                out->begin_section( `Reset Node` ).
                reader->current_node( ).
                DO.
                  reader->next_attribute( ).
                  IF reader->node_type <> if_sxml_node=>co_nt_attribute.
                    EXIT.
                  ENDIF.
                  out->write( |{ reader->name } { reader->value }| ).
                ENDDO.
                out->end_section( ).
                EXIT.
              ENDIF.
              IF reader->name = 'a4'.
                out->begin_section( `Reading Raw Values` ).
              ENDIF.
              TRY.
                  reader->next_attribute_value(
                    if_sxml_value=>co_vt_raw ).
                  out->write( |{ reader->name
                             } { reader->value
                             } { reader->value_raw }| ).
                CATCH cx_sxml_parse_error INTO parse_error.
                  CONTINUE.
              ENDTRY.
            ENDDO.
          ENDIF.
        ENDDO.
      CATCH cx_sxml_parse_error INTO parse_error.
        out->write_text( parse_error->get_text( ) ).
    ENDTRY.

    "Skip node
    out->next_section( `Skipping a Node and Getting the Subtree` ).
    reader = cl_sxml_string_reader=>create( xml ).
    DATA(writer) = CAST if_sxml_writer(
      cl_sxml_string_writer=>create(  ) ).
    DATA level TYPE i.
    TRY.
        DO.
          reader->next_node( ).
          IF reader->node_type = if_sxml_node=>co_nt_final.
            EXIT.
          ENDIF.
          IF reader->node_type = if_sxml_node=>co_nt_element_open.
            level = level + 1.
          ELSEIF reader->node_type = if_sxml_node=>co_nt_element_close.
            level = level - 1.
          ENDIF.
          IF reader->node_type = if_sxml_node=>co_nt_element_open AND
             level > 2.
            reader->skip_node( writer ).
            level = level - 1.
          ENDIF.
        ENDDO.
      CATCH cx_sxml_parse_error INTO parse_error.
        out->write_text( parse_error->get_text( ) ).
    ENDTRY.
    DATA(xml_sub) =
       CAST cl_sxml_string_writer( writer )->get_output(  ).
    out->write_xml( xml_sub ).

    "Skip node
    out->next_section( `Skipping a Node and Getting the Subelements` ).
    reader = cl_sxml_string_reader=>create( xml ).
    writer = CAST if_sxml_writer(
      cl_sxml_string_writer=>create(  ) ).
    writer->open_element( name = 'subElements' ).
    CLEAR level.
    TRY.
        DO.
          reader->next_node( ).
          IF reader->node_type = if_sxml_node=>co_nt_final.
            EXIT.
          ENDIF.
          IF reader->node_type = if_sxml_node=>co_nt_element_open.
            level = level + 1.
          ELSEIF reader->node_type = if_sxml_node=>co_nt_element_close.
            level = level - 1.
          ENDIF.
          IF reader->node_type = if_sxml_node=>co_nt_element_open AND
             level > 3.
            reader->skip_node( writer ).
            level = level - 1.
          ENDIF.
        ENDDO.
      CATCH cx_sxml_parse_error INTO parse_error.
        out->write_text( parse_error->get_text( ) ).
    ENDTRY.
    writer->close_element( ).
    xml_sub =
       CAST cl_sxml_string_writer( writer )->get_output(  ).
    out->write_xml( xml_sub ).

    out->display( ).
  ENDMETHOD.
  METHOD get_node_type.
    CASE node_type_int.
      WHEN if_sxml_node=>co_nt_initial.
        node_type_string = `CO_NT_INITIAL`.
*      WHEN if_sxml_node=>co_nt_comment.
*        node_type_string = `CO_NT_COMMENT`.
      WHEN if_sxml_node=>co_nt_element_open.
        node_type_string = `CO_NT_ELEMENT_OPEN`.
      WHEN if_sxml_node=>co_nt_element_close.
        node_type_string = `CO_NT_ELEMENT_CLOSE`.
      WHEN if_sxml_node=>co_nt_value.
        node_type_string = `CO_NT_VALUE`.
      WHEN if_sxml_node=>co_nt_attribute.
        node_type_string = `CO_NT_ATTRIBUTE`.
*      WHEN if_sxml_node=>co_nt_pi.
*        node_type_string = `CO_NT_FINAL`.
      WHEN OTHERS.
        node_type_string = `Error`.
    ENDCASE.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  sxml_demo=>main( ).
