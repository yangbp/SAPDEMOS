REPORT demo_ixml_access_attributes.

CLASS ixml_demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS ixml_demo IMPLEMENTATION.
  METHOD main.
    DATA(out) = cl_demo_output=>new( ).
    DATA(ixml)           = cl_ixml=>create( ).
    DATA(stream_factory) = ixml->create_stream_factory( ).

    DATA(istream)        = stream_factory->create_istream_string(
      `<texts>`                                        &&
      `  <text1 format="bold"   level="1">aaa</text1>` &&
      `  <text2 format="italic" level="2">bbb</text2>` &&
      `  <text3 format="arial"  level="3">ccc</text3>` &&
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
    DATA(child) = element->get_first_child( ).

    DATA(attributes) = child->get_attributes( ).
    DO attributes->get_length( ) TIMES.
      DATA(attribute) = attributes->get_item( sy-index - 1 ).
      out->write( |{ attribute->get_name( ) } | &&
                  |{ attribute->get_value( ) }| ).
    ENDDO.

    out->line( ).
    child = child->get_next( ).

    attributes = child->get_attributes( ).
    attribute = attributes->get_named_item_ns( name = 'format' ).
    out->write( |{ attribute->get_name( ) } | &&
                |{ attribute->get_value( ) }| ).
    attribute = attributes->get_named_item_ns( name = 'level' ).
    out->write( |{ attribute->get_name( ) } | &&
                |{ attribute->get_value( ) }| ).

    out->line( ).
    child = child->get_next( ).

    attribute = CAST if_ixml_element( child
                       )->get_attribute_node_ns( name = 'format' ).
    out->write( |{ attribute->get_name( ) } | &&
                |{ attribute->get_value( ) }| ).
    out->write( |level { CAST if_ixml_element(
                   child )->get_attribute_ns( name = 'level' ) }| ).

    out->display( ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  ixml_demo=>main( ).
