REPORT demo_ixml_parsing_sequential.

CLASS ixml_demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
  PRIVATE SECTION.
    CLASS-METHODS handle_errors
          IMPORTING parser TYPE REF TO if_ixml_parser.
ENDCLASS.

CLASS ixml_demo IMPLEMENTATION.
  METHOD main.
    DATA(out)            = cl_demo_output=>new( ).
    DATA(ixml)           = cl_ixml=>create( ).
    DATA(stream_factory) = ixml->create_stream_factory( ).

    DATA(istream)        = stream_factory->create_istream_string(
      `<texts>`              &&
      `  <text1>aaa</text1>` &&
      `  <text2>bbb</text2>` &&
      `</texts>`  ).

    DATA(document)       = ixml->create_document( ).
    DATA(parser)         = ixml->create_parser(
                             stream_factory = stream_factory
                             istream        = istream
                             document       = document ).

    parser->set_event_subscription(
      events = if_ixml_event=>co_event_element_pre +
               if_ixml_event=>co_event_element_post ).

    DO.
      DATA(event) = parser->parse_event( ).
      IF event IS INITIAL.
        EXIT.
      ENDIF.
      DATA(name)  = event->get_name( ).
      DATA(value) = event->get_value( ).
      out->write( |{ name } { value }| ).
      DATA(xml_string) = ``.
      ixml->create_renderer(
        document = document
        ostream  = ixml->create_stream_factory(
                      )->create_ostream_cstring( string = xml_string )
         )->render( ).
      out->write_xml( xml_string )->line( ).
    ENDDO.

    IF parser->num_errors( ) > 0.
      handle_errors( parser ).
      RETURN.
    ENDIF.

    out->display( ).
  ENDMETHOD.
  METHOD handle_errors.
    DO parser->num_errors( ) TIMES.
      DATA(error)  = parser->get_error( index = sy-index - 1 ).
      DATA(reason) = error->get_reason( ).
      ...
    ENDDO.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  ixml_demo=>main( ).
