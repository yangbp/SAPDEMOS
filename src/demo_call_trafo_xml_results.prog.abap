REPORT demo_call_trafo_xml_results.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA(out) = CL_DEMO_OUTPUT=>NEW(
      )->begin_section(
      `XML Results for CALL TRANSFORMATION` ).

    DATA(xml) = cl_abap_codepage=>convert_to(
                 `<object>` &&
                 ` <str name="TEXT">Hello Writers!</str>` &&
                 `</object>` ).

    "Strings
    out->begin_section( `Strings` ).

    "string
    out->begin_section( `Text String` ).
    DATA(xml_str) = VALUE string( ).
    CALL TRANSFORMATION id SOURCE XML xml
                           RESULT XML xml_str.
    out->write_xml( xml_str ).

    "xstring
    out->next_section( `Byte String` ).
    DATA(xml_xstr) = VALUE xstring( ).
    CALL TRANSFORMATION id SOURCE XML xml
                           RESULT XML xml_xstr.
    out->write_xml( xml_xstr
      )->end_section( ).

    "Internal tables
    out->next_section( `Internal Tables` ).

    "Text table
    out->begin_section( `Table of Text Fields` ).
    TYPES c10 TYPE c LENGTH 10.
    DATA xml_tab TYPE STANDARD TABLE OF c10 WITH DEFAULT KEY.
    CALL TRANSFORMATION id SOURCE XML xml
                        RESULT XML xml_tab.
    out->write_xml( concat_lines_of( xml_tab ) ).

    "Byte table
    out->next_section( `Table of Byte Fields` ).
    TYPES x10 TYPE x LENGTH 10.
    DATA xml_xtab TYPE STANDARD TABLE OF x10 WITH DEFAULT KEY.
    CALL TRANSFORMATION id SOURCE XML xml
                        RESULT XML xml_xtab.
    CONCATENATE LINES OF xml_xtab INTO xml_xstr IN BYTE MODE.
    out->write_xml( xml_xstr
      )->end_section( ).

    "iXML
    out->next_section( `iXML Library` ).

    "Output stream
    out->begin_section( `Output Stream` ).
    DATA(ixml) = cl_ixml=>create( ).
    CLEAR xml_xstr.
    DATA(ostream) = ixml->create_stream_factory(
                      )->create_ostream_xstring( xml_xstr ).
    CALL TRANSFORMATION id SOURCE XML xml
                           RESULT XML ostream.
    out->write_xml( xml_xstr ).

    "DOM
    out->next_section( `DOM` ).
    DATA(dom) = ixml->create_document( ).
    CALL TRANSFORMATION id SOURCE XML xml
                           RESULT XML dom.
    CLEAR xml_xstr.
    dom->render( ixml->create_stream_factory(
                         )->create_ostream_xstring( xml_xstr ) ).
    out->write_xml( xml_xstr
      )->end_section( ).

    "sXML
    out->next_section( `sXML Library` ).

    "XML 1.0 writer
    out->begin_section( `XML 1.0 Writer` ).
    DATA(xml_writer) = cl_sxml_string_writer=>create(
                         type = if_sxml=>co_xt_xml10 ).
    CALL TRANSFORMATION id SOURCE XML xml
                           RESULT XML xml_writer.
    out->write_xml( xml_writer->get_output( ) ).

    "Binary XML writer
    out->next_section( `Binary XML Writer` ).
    DATA(binary_xml_writer) = cl_sxml_string_writer=>create(
                                type = if_sxml=>co_xt_binary ).
    CALL TRANSFORMATION id SOURCE XML xml
                           RESULT XML binary_xml_writer.
    out->write_xml( binary_xml_writer->get_output( ) ).

    "XOP writer
    out->next_section( `XOP Writer` ).
    DATA(xop_writer) = cl_sxml_xop_writer=>create( ).
    CALL TRANSFORMATION id SOURCE XML xml
                           RESULT XML xop_writer.
    DATA(xop_package) = xop_writer->get_output( ).
    out->write_xml( xop_package-xop_document ).

    "JSON writer
    out->next_section( `JSON Writer` ).
    DATA(json_writer) = cl_sxml_string_writer=>create(
                                type = if_sxml=>co_xt_json ).
    CALL TRANSFORMATION id SOURCE XML xml
                           RESULT XML json_writer.
    out->write_json( json_writer->get_output( )
      )->display( ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
