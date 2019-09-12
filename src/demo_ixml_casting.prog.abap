REPORT demo_ixml_casting.

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

    DATA(iterator) = document->create_iterator( ).
    DO.
      DATA(node) = iterator->get_next( ).
      IF node IS INITIAL.
        EXIT.
      ENDIF.
      DATA element TYPE REF TO if_ixml_element.
      "Normal down cast
      IF node is not INSTANCE OF if_ixml_element.
          cl_demo_output=>write_text(
            |{ node->get_name( ) } is not an element| ).
      ENDIF.
      "Special down cast
      element ?=  node->query_interface( ixml_iid_element ).
      IF element IS INITIAL.
        cl_demo_output=>write_text(
          |{ node->get_name( ) } is not an element| ).
      ENDIF.
    ENDDO.

    cl_demo_output=>display( ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  ixml_demo=>main( ).
