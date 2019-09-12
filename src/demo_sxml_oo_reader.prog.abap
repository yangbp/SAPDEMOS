REPORT demo_sxml_oo_reader.

CLASS sxml_demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS sxml_demo IMPLEMENTATION.
  METHOD main.
    DATA(out) = cl_demo_output=>new(
      )->begin_section( `XML-Data` ).
    DATA(xml) = cl_abap_codepage=>convert_to(
     `<?xml version="1.0"?>` &&
     `<order number="4711"` &&
     ` xmlns:demo="http://www.sap.com/abapdemos">` &&
     ` <demo:head>` &&
     ` <demo:status>confirmed</demo:status>` &&
     ` <demo:date format="mm-dd-yyyy">07-19-2012</demo:date>` &&
     ` </demo:head>` &&
     ` <demo:body>`  &&
     ` <demo:item units="2" price="17.00">Part No. 0110</demo:item>` &&
     ` <demo:item units="1" price="10.50">Part No. 1609</demo:item>` &&
     ` <demo:item units="5" price="12.30">Part No. 1710</demo:item>` &&
     ` </demo:body>` &&
     `</order>` ).
    out->write_xml( xml ).

    out->next_section( `Parsed Nodes of the XML-Data` ).
    DATA: BEGIN OF node_wa,
            node_type  TYPE string,
            prefix     TYPE string,
            name       TYPE string,
            nsuri      TYPE string,
            value      TYPE string,
            value_raw  TYPE xstring,
          END OF node_wa,
          nodes LIKE TABLE OF node_wa.
    DATA(reader) = cl_sxml_string_reader=>create( xml ).
    TRY.
        DO.
          CLEAR node_wa.
          DATA(node) = reader->read_next_node( ).
          IF node IS INITIAL.
            EXIT.
          ENDIF.

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

    out->display( nodes ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  sxml_demo=>main( ).
