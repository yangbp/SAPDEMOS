REPORT demo_json_oo_reader.

CLASS json_demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS json_demo IMPLEMENTATION.
  METHOD main.
    DATA(out) = cl_demo_output=>new(
      )->begin_section( `JSON-Data` ).
    DATA(json) = cl_abap_codepage=>convert_to(
     `{` &&
     ` "order":"4711",` &&
     ` "head":{` &&
     `  "status":"confirmed",` &&
     `  "date":"07-19-2012"` &&
     ` },` &&
     ` "body":{` &&
     `  "item":{` &&
     `   "units":"2", "price":"17.00", "Part No.":"0110"` &&
     `  },` &&
     `  "item":{` &&
     `   "units":"1", "price":"10.50", "Part No.":"1609"` &&
     `  },` &&
     `  "item":{` &&
     `   "units":"5", "price":"12.30", "Part No.":"1710"` &&
     `  }` &&
     ` }` &&
     `}` ).
    out->write_json( json ).

    out->next_section( `Parsed Nodes of the JSON-Data` ).
    DATA: BEGIN OF node_wa,
            node_type  TYPE string,
            prefix     TYPE string,
            name       TYPE string,
            nsuri      TYPE string,
            value      TYPE string,
            value_raw  TYPE xstring,
          END OF node_wa,
          nodes LIKE TABLE OF node_wa.
    DATA(reader) = cl_sxml_string_reader=>create( json ).
    DATA(writer) =
      CAST if_sxml_writer( cl_sxml_string_writer=>create( ) ).
    TRY.
        DO.
          CLEAR node_wa.
          DATA(node) = reader->read_next_node( ).
          IF node IS INITIAL.
            EXIT.
          ENDIF.
          writer->write_node( node ).
          CASE node->type.
            WHEN if_sxml_node=>co_nt_element_open.
              DATA(open_element) = CAST if_sxml_open_element( node ).
              node_wa-node_type = `open element`.
              node_wa-prefix    = open_element->prefix.
              node_wa-name      = open_element->qname-name.
              node_wa-nsuri     = open_element->qname-namespace.
              DATA(attributes)  = open_element->get_attributes( ).
              APPEND node_wa TO nodes.
              LOOP AT attributes INTO DATA(attribute).
                node_wa-node_type = `attribute`.
                node_wa-prefix    = attribute->prefix.
                node_wa-name      = attribute->qname-name.
                node_wa-nsuri     = attribute->qname-namespace.
                IF attribute->value_type = if_sxml_value=>co_vt_text.
                  node_wa-value = attribute->get_value( ).
                ELSEIF attribute->value_type =
                                   if_sxml_value=>co_vt_raw.
                  node_wa-value_raw = attribute->get_value_raw( ).
                ENDIF.
                APPEND node_wa TO nodes.
              ENDLOOP.
              CONTINUE.
            WHEN if_sxml_node=>co_nt_element_close.
              DATA(close_element) = CAST if_sxml_close_element( node ).
              node_wa-node_type   = `close element`.
              node_wa-prefix      = close_element->prefix.
              node_wa-name        = close_element->qname-name.
              node_wa-nsuri       = close_element->qname-namespace.
              APPEND node_wa TO nodes.
              CONTINUE.
            WHEN if_sxml_node=>co_nt_value.
              DATA(value_node) = CAST if_sxml_value_node( node ).
              node_wa-node_type   = `value`.
              IF value_node->value_type = if_sxml_value=>co_vt_text.
                node_wa-value = value_node->get_value( ).
              ELSEIF value_node->value_type = if_sxml_value=>co_vt_raw.
                node_wa-value_raw = value_node->get_value_raw( ).
              ENDIF.
              APPEND node_wa TO nodes.
              CONTINUE.
            WHEN OTHERS.
              node_wa-node_type   = `Error`.
              APPEND node_wa TO nodes.
              EXIT.
          ENDCASE.
        ENDDO.
      CATCH cx_sxml_parse_error INTO DATA(parse_error).
        out->write_text( parse_error->get_text( ) ).
    ENDTRY.
    out->write_data( nodes ).

    out->next_section(
      `JSON-XML-Representation of the JSON-Data` ).
    out->write_xml(
      CAST cl_sxml_string_writer( writer )->get_output( ) ).

    out->display( ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  json_demo=>main( ).
