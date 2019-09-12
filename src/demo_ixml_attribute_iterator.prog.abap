REPORT demo_ixml_attribute_iterator.

CLASS ixml_demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS ixml_demo IMPLEMENTATION.
  METHOD main.
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
    DATA(iterator) = attributes->create_iterator( ).

    DO.
      DATA(attribute) = iterator->get_next( ).
      IF attribute IS INITIAL.
        EXIT.
      ENDIF.
      cl_demo_output=>write_text( |{ attribute->get_name( ) } | &&
                                  |{ attribute->get_value( ) }| ).
    ENDDO.

    cl_demo_output=>display( ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  ixml_demo=>main( ).
