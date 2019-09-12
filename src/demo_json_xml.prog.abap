REPORT demo_json_xml.

CLASS json_demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
  PRIVATE SECTION.
    CLASS-METHODS parse
      IMPORTING example TYPE cl_demo_valid_json=>example.
    class-data out TYPE REF TO if_demo_output.
ENDCLASS.

CLASS json_demo IMPLEMENTATION.
  METHOD main.
    out = cl_demo_output=>new(
      )->begin_section( 'Examples for JSON-XML' ).
    LOOP AT cl_demo_valid_json=>examples
            ASSIGNING FIELD-SYMBOL(<example>).
      parse( <example> ).
    ENDLOOP.
    out->display( ).
  ENDMETHOD.
  METHOD parse.
    out->begin_section( example-text
      )->begin_section( 'JSON'
      )->write_json( example-json
      )->next_section( 'JSON-XML'  ).
    DATA(reader) = cl_sxml_string_reader=>create(
                     cl_abap_codepage=>convert_to( example-json ) ).
    DATA(writer) = cl_sxml_string_writer=>create(
                     type = if_sxml=>co_xt_xml10 ).
    TRY.
        reader->next_node( ).
        reader->skip_node( writer ).
        out->write_xml( writer->get_output( ) ).
      CATCH cx_sxml_parse_error INTO DATA(error).
        out->write_text( error->get_text( ) ).
    ENDTRY.
    out->end_section( )->end_section( ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  json_demo=>main( ).
