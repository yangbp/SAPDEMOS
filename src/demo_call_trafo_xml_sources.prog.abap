REPORT demo_call_trafo_xml_sources.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA xml TYPE xstring.
    DATA(out) = cl_demo_output=>new(
      )->begin_section( `XML-Sources for CALL TRANSFORMATION` ).

    "XML 1.0
    out->begin_section( `XML 1.0` ).
    "XML 1.0 in string
    out->begin_section( `XML 1.0 in Text String` ).
    DATA(xml_str) = `<text>Hello XML!</text>`.
    CALL TRANSFORMATION id SOURCE XML xml_str
                           RESULT XML xml.
    out->write_xml( xml ).
    "XML 1.0 in text table
    out->next_section( `XML 1.0 in Table of Text Fields` ).
    TYPES c10 TYPE c LENGTH 10.
    DATA xml_tab TYPE STANDARD TABLE OF c10 WITH DEFAULT KEY.
    xml_tab =
      VALUE #( LET l1 = strlen( xml_str ) l2 = l1 - 10 IN
               FOR j = 0 THEN j + 10  UNTIL j >= l1
                ( COND #( WHEN j <= l2 THEN
                            xml_str+j(10)
                          ELSE
                            xml_str+j ) ) ).
    CALL TRANSFORMATION id SOURCE XML xml_tab
                           RESULT XML xml.
    out->write_xml( xml ).
    "XML 1.0 in xstring
    out->next_section( `XML 1.0 in Byte String` ).
    DATA(xml_xstr) = cl_abap_codepage=>convert_to( xml_str ).
    CALL TRANSFORMATION id SOURCE XML xml_xstr
                           RESULT XML xml.
    out->write_xml( xml ).
    "XML 1.0 in byte table
    out->next_section( `XML 1.0 in Table of Byte Fields` ).
    TYPES x10 TYPE x LENGTH 10.
    DATA xml_xtab TYPE STANDARD TABLE OF x10 WITH DEFAULT KEY.
    xml_xtab =
      VALUE #( LET l1 = xstrlen( xml_xstr ) l2 = l1 - 10 IN
               FOR j = 0 THEN j + 10  UNTIL j >= l1
                ( COND #( WHEN j <= l2 THEN
                            xml_xstr+j(10)
                          ELSE
                            xml_xstr+j ) ) ).
    CALL TRANSFORMATION id SOURCE XML xml_xtab
                           RESULT XML xml.
    out->write_xml( xml ).
    "XML 1.0 in iXML input stream
    out->next_section( `XML 1.0 from Input Stream` ).
    DATA(ixml) = cl_ixml=>create( ).
    DATA(istream) = ixml->create_stream_factory(
                      )->create_istream_xstring( xml_xstr ).
    CALL TRANSFORMATION id SOURCE XML istream
                           RESULT XML xml.
    out->write_xml( xml ).
    "XML 1.0 in iXML DOM
    out->next_section( `XML 1.0 in DOM` ).
    DATA(dom) = ixml->create_document( ).
    DATA(parser) = ixml->create_parser(
                     document = dom
                     stream_factory = ixml->create_stream_factory( )
                     istream = ixml->create_stream_factory(
                        )->create_istream_xstring( xml_xstr ) ).
    parser->parse( ).
    CALL TRANSFORMATION id SOURCE XML dom
                           RESULT XML xml.
    out->write_xml( xml ).
    "XML 1.0 in XML-Reader
    out->next_section( `XML 1.0 from XML Reader` ).
    DATA(xml_reader) = cl_sxml_string_reader=>create( xml_xstr ).
    CALL TRANSFORMATION id SOURCE XML xml_reader
                           RESULT XML xml.
    out->write_xml( xml
      )->end_section( ).

    "Binary XML
    out->next_section( `Binary XML` ).
    xml_reader = cl_sxml_string_reader=>create(
                   cl_abap_codepage=>convert_to(
                     `<text>Hello binary XML!</text>` ) ).
    DATA(binary_xml_writer) =
      cl_sxml_string_writer=>create( type = if_sxml=>co_xt_binary ).
    xml_reader->next_node( ).
    xml_reader->skip_node( binary_xml_writer ).
    "Binary XML in xstring
    out->begin_section( `Binary XML in Byte String` ).
    DATA(binary_xml_xstr) = binary_xml_writer->get_output( ).
    CALL TRANSFORMATION id SOURCE XML binary_xml_xstr
                           RESULT XML xml.
    out->write_xml( xml ).
    "Binary XML in byte table
    out->next_section( `Binary XML in Byte Table` ).
    DATA binary_xml_xtab TYPE STANDARD TABLE OF x10 WITH DEFAULT KEY.
    binary_xml_xtab =
      VALUE #( LET l1 = xstrlen( binary_xml_xstr ) l2 = l1 - 10 IN
               FOR j = 0 THEN j + 10  UNTIL j >= l1
                ( COND #( WHEN j <= l2 THEN
                            binary_xml_xstr+j(10)
                          ELSE
                            binary_xml_xstr+j ) ) ).
    CALL TRANSFORMATION id SOURCE XML binary_xml_xtab
                           RESULT XML xml.
    out->write_xml( xml ).
    "Binary XML in XML-Reader
    out->next_section( `Binary XML from XML Reader` ).
    DATA(binary_xml_reader) = cl_sxml_string_reader=>create(
                                binary_xml_xstr ).
    CALL TRANSFORMATION id SOURCE XML binary_xml_reader
                           RESULT XML xml.
    out->write_xml( xml
      )->end_section( ).

    "XOP
    out->next_section( `XOP` ).
    xml_reader = cl_sxml_string_reader=>create(
                   cl_abap_codepage=>convert_to(
                     `<text>Hello XOP!</text>` ) ).
    DATA(xop_writer) =
      cl_sxml_xop_writer=>create( ).
    xml_reader->next_node( ).
    xml_reader->skip_node( xop_writer ).
    DATA(xop_package) = xop_writer->get_output( ).
    "XOP in XML-Reader
    out->begin_section( `XOP from XML Reader` ).
    DATA(xop_reader) = cl_sxml_xop_reader=>create( xop_package ).
    CALL TRANSFORMATION id SOURCE XML xop_reader
                           RESULT XML xml.
    out->write_xml( xml
      )->end_section( ).

    "JSON
    out->next_section( `JSON` ).
    "JSON in string
    out->begin_section( `JSON in Text String` ).
    DATA(json_str) = `{"TEXT":"Hello JSON!"}`.
    CALL TRANSFORMATION id SOURCE XML json_str
                           RESULT XML xml.
    out->write_xml( xml ).
    "JSON in text table
    out->next_section( `JSON in Table of Text Fields` ).
    DATA json_tab TYPE STANDARD TABLE OF c10 WITH DEFAULT KEY.
    json_tab =
      VALUE #( LET l1 = strlen( json_str ) l2 = l1 - 10 IN
               FOR j = 0 THEN j + 10  UNTIL j >= l1
                ( COND #( WHEN j <= l2 THEN
                            json_str+j(10)
                          ELSE
                            json_str+j ) ) ).
    CALL TRANSFORMATION id SOURCE XML json_tab
                           RESULT XML xml.
    out->write_xml( xml ).
    "JSON in xstring
    out->next_section( `JSON in Byte String` ).
    DATA(json_xstr) = cl_abap_codepage=>convert_to( json_str ).
    CALL TRANSFORMATION id SOURCE XML json_xstr
                           RESULT XML xml.
    out->write_xml( xml ).
    "JSON in byte table
    out->next_section( `JSON in Table of Byte Fields` ).
    DATA json_xtab TYPE STANDARD TABLE OF x10 WITH DEFAULT KEY.
    json_xtab =
      VALUE #( LET l1 = xstrlen( json_xstr ) l2 = l1 - 10 IN
               FOR j = 0 THEN j + 10  UNTIL j >= l1
                ( COND #( WHEN j <= l2 THEN
                            json_xstr+j(10)
                          ELSE
                            json_xstr+j ) ) ).
    CALL TRANSFORMATION id SOURCE XML json_xtab
                           RESULT XML xml.
    out->write_xml( xml ).
    "JSON in XML-Reader
    out->next_section( `JSON from XML Reader` ).
    DATA(json_reader) = cl_sxml_string_reader=>create( json_xstr ).
    CALL TRANSFORMATION id SOURCE XML json_reader
                           RESULT XML xml.
    out->write_xml( xml
      )->display( ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
