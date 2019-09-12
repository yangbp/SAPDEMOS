REPORT demo_ixml_parse_render_tk_iter.

CLASS ixml_demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS ixml_demo IMPLEMENTATION.
  METHOD main.
    DATA(out) = cl_demo_output=>new(
      )->begin_section( 'XML-Data' ).
    DATA(xml) =
      `<texts>`                            &&
      `<!-- texts -->`                     &&
      `<text1 format="bold">aaa</text1>`   &&
      `<text2 format="italic">bbb</text2>` &&
      `</texts>`.
    out->write_xml( xml ).

    out->next_section( 'Node Table' ).
    DATA(ixml)   = cl_ixml=>create( ).
    DATA(token_parser) = ixml->create_token_parser(
      stream_factory = ixml->create_stream_factory( )
      istream        = ixml->create_stream_factory(
        )->create_istream_string( xml )
      document       = ixml->create_document( ) ).
    DATA(tk_mask) =
      if_ixml_token_parser=>co_tk_any_token.
    DATA(in_mask) =
      if_ixml_token_parser=>co_ni_all_info.
    DATA token TYPE i.
    DATA node_info TYPE sixmlnode.
    DATA node_infos TYPE sixmldom.
    DO.
      token = token_parser->get_next_token( tk_mask ).
      IF token IS INITIAL.
        EXIT.
      ENDIF.
      token_parser->get_node_info( info_mask = in_mask
                                   node_info = node_info ).
      IF node_info-type <> if_ixml_token_parser=>co_tk_attribute.
        APPEND node_info TO node_infos.
      ENDIF.
    ENDDO.
    out->write_data( node_infos ).

    out->next_section( 'New XML-Data' ).
    CLEAR xml.
    DATA(token_renderer) = ixml->create_token_renderer(
      ostream = ixml->create_stream_factory(
        )->create_ostream_cstring( xml ) ).

    token_renderer->render( node_infos ).
    out->write_xml( xml ).

    out->display( ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  ixml_demo=>main( ).
