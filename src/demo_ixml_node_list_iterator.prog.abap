REPORT demo_ixml_node_list_iterator.

CLASS ixml_demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS ixml_demo IMPLEMENTATION.
  METHOD main.
    DATA(ixml)           = cl_ixml=>create( ).
    DATA(stream_factory) = ixml->create_stream_factory( ).

    DATA(istream)        = stream_factory->create_istream_string(
      `<texts>`                              &&
      `  <text1 format="bold">aaa</text1>`   &&
      `  <text2 format="italic">bbb</text2>` &&
      `</texts>` ).

    DATA(document)       = ixml->create_document( ).
    DATA(parser)         = ixml->create_parser(
                             stream_factory = stream_factory
                             istream        = istream
                             document       = document ).

    DATA(rc) = parser->parse( ).

    IF rc <> ixml_mr_parser_ok.
      ... "Error handling
      RETURN.
    ENDIF.

    DATA(nodes) = document->get_root_element( )->get_children( ).
    DATA(iterator) = nodes->create_iterator( ).

    DO.
      DATA(node) = iterator->get_next( ).
      IF node IS INITIAL.
        EXIT.
      ENDIF.
      cl_demo_output=>write_text( |{ node->get_name( ) } | &&
                                  |{ node->get_value( ) }| ).
    ENDDO.

    cl_demo_output=>display( ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  ixml_demo=>main( ).
