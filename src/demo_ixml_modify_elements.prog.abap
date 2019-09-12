REPORT demo_ixml_modify_elements.

CLASS ixml_demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS ixml_demo IMPLEMENTATION.
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

    DATA(ixml) = cl_ixml=>create( ).
    DATA(stream_factory) = ixml->create_stream_factory( ).
    DATA(document) = ixml->create_document( ).
    IF ixml->create_parser(
      document = document
      stream_factory = stream_factory
      istream = stream_factory->create_istream_xstring( string = xml )
      )->parse( ) <> 0.
      RETURN.
    ENDIF.

    DATA(iterator) = document->create_iterator( ).
    DO.
      DATA(node) = iterator->get_next( ).
      IF node IS INITIAL.
        EXIT.
      ENDIF.
      IF node->get_type( ) = if_ixml_node=>co_node_text.
        node->set_value( to_upper( node->get_value( ) ) ).
      ENDIF.
    ENDDO.

    CLEAR xml.
    document->render(
      ostream = ixml->create_stream_factory(
      )->create_ostream_xstring(
      string = xml ) ).

    out->next_section( 'Modified XML-Data'
      )->write_xml( xml
      )->display( ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  ixml_demo=>main( ).
