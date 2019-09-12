REPORT demo_ixml_node_iterator.

CLASS ixml_demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
  PRIVATE SECTION.
    CLASS-DATA out TYPE REF TO if_demo_output.
    CLASS-METHODS iterate
      IMPORTING iterator TYPE REF TO if_ixml_node_iterator.
ENDCLASS.

CLASS ixml_demo IMPLEMENTATION.
  METHOD main.
    out = cl_demo_output=>new( ).

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

    DATA(iterator) = document->create_iterator( ).
    iterate( iterator ).
    out->line( ).

    DATA(element) = document->get_root_element( ).
    iterator = element->create_iterator( ).
    iterate( iterator ).
    out->line( ).

    DATA(child) = element->get_first_child( ).
    iterator = child->create_iterator( ).
    iterate( iterator ).

    out->display( ).
  ENDMETHOD.
  METHOD iterate.
    DO.
      DATA(node) = iterator->get_next( ).
      IF node IS INITIAL.
        EXIT.
      ENDIF.
      IF node->get_type( ) <> if_ixml_node=>co_node_element.
        CONTINUE.
      ENDIF.
      out->write( |{ node->get_name( ) } | &&
                  |{ node->get_value( ) }| ).
    ENDDO.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  ixml_demo=>main( ).
