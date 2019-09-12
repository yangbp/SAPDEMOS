REPORT demo_ixml_access_node_list.

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

    DATA(element) = document->get_root_element( ).
    cl_demo_output=>write_text( |{ element->get_name( ) }| ).

    DATA(nodes) = element->get_children( ).
    DO nodes->get_length( ) TIMES.
      DATA(child) = nodes->get_item( sy-index - 1 ).
      cl_demo_output=>write_text( |{ child->get_name( ) } | &&
                                  |{ child->get_value( ) }| ).
    ENDDO.
    cl_demo_output=>display( ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  ixml_demo=>main( ).
