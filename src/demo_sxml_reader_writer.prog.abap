REPORT demo_sxml_reader_writer.

CLASS sxml_demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS sxml_demo IMPLEMENTATION.
  METHOD main.
    DATA(xml) =
     cl_abap_codepage=>convert_to(
       `<text>` &&
       `<line>aaaa</line>` &&
       `<line>bbbb</line>` &&
       `<line>cccc</line>` &&
       `</text>` ).

    DATA(out) = cl_demo_output=>new(
      )->begin_section( 'Original XML-Data'
      )->write_xml( xml ).

    DATA(reader) = cl_sxml_string_reader=>create( xml ).
    DATA(writer) = CAST if_sxml_writer(
                          cl_sxml_string_writer=>create( ) ).
    DO.
      DATA(node) = reader->read_next_node( ).
      IF node IS INITIAL.
        EXIT.
      ENDIF.
      IF node IS INSTANCE OF if_sxml_value_node.
        DATA(value_node) = CAST if_sxml_value_node( node ).
        IF value_node->value_type = if_sxml_value=>co_vt_text.
          value_node->set_value(
            to_upper( value_node->get_value( ) ) ).
        ENDIF.
      ENDIF.
      writer->write_node( node ).
    ENDDO.

    out->next_section( 'Modified XML-Data'
      )->write_xml(
        CAST cl_sxml_string_writer( writer )->get_output( )
      )->display( ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  sxml_demo=>main( ).
