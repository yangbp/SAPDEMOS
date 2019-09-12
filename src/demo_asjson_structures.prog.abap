REPORT demo_asjson_structures.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA: BEGIN OF struct,
            i          TYPE i            VALUE -123,
            int8       TYPE int8         VALUE -123,
            p          TYPE p DECIMALS 2 VALUE `-1.23`,
            decfloat16 TYPE decfloat16   VALUE `123E+1`,
            decfloat34 TYPE decfloat34   VALUE `-3.140000E+02`,
            f          TYPE f            VALUE `-3.140000E+02`,
            c          TYPE c LENGTH 3   VALUE ` Hi`,
            string     TYPE string       VALUE ` Hello `,
            n          TYPE n LENGTH 6   VALUE `001234`,
            d          TYPE d            VALUE `20020204`,
            t          TYPE t            VALUE `201501`,
            x          TYPE x LENGTH 3   VALUE `ABCDEF`,
            xstring    TYPE xstring      VALUE `456789AB`,
          END OF struct.

    "Transformation to JSON
    DATA(out) = cl_demo_output=>new(
      )->begin_section( 'asJSON' ).
    DATA(writer) = cl_sxml_string_writer=>create(
      type = if_sxml=>co_xt_json ).
    CALL TRANSFORMATION id SOURCE struct = struct
                           RESULT XML writer.
    DATA(json) = writer->get_output( ).
    out->write_json( json ).

    "JSON-XML
    out->next_section( 'asJSON-XML' ).
    DATA(reader) = cl_sxml_string_reader=>create( json ).
    DATA(xml_writer) = cl_sxml_string_writer=>create( ).
    reader->next_node( ).
    reader->skip_node( xml_writer ).
    DATA(xml) = xml_writer->get_output( ).
    out->write_xml( xml ).

    "asXML
    out->next_section( 'asXML' ).
    CALL TRANSFORMATION id SOURCE struct = struct
                           RESULT XML xml.
    out->write_xml( xml )->display( ).

  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
