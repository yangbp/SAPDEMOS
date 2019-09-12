REPORT demo_json_xml_object_members.

CLASS json_demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS json_demo IMPLEMENTATION.
  METHOD main.
    DATA(out) = cl_demo_output=>new(
      )->begin_section( 'Render' ).
    "JSON-XML without and with members
    DATA(json_xml) =
      `<object>` &&
      `<str name="text">abcd</str>` &&
      `<bool name="flag">true</bool>` &&
      `<member name="number">` &&
      `<num>111</num>` &&
      `</member>` &&
      `<member name="content">` &&
      `<null />` &&
      `</member>` &&
      `</object>`.

    out->begin_section(
        'JSON-XML without and with member elements'
      )->write_xml( json_xml ).
    "Render JSON data
    out->next_section( 'JSON' ).
    DATA(reader) = cl_sxml_string_reader=>create(
      input = cl_abap_codepage=>convert_to( json_xml ) ).
    DATA(json_writer) = cl_sxml_string_writer=>create(
                          type = if_sxml=>co_xt_json ) .
    TRY.
        reader->next_node( ).
        reader->skip_node( json_writer ).
      CATCH cx_sxml_parse_error INTO DATA(error).
        out->write_text( error->get_text( ) ).
    ENDTRY.
    DATA(json) = json_writer->get_output( ).
    out->write_json( json
      )->end_section(
      )->next_section( 'Parse' ).

    "Parse JSON data without setting the member option
    out->begin_section( 'JSON-XML without member elements' ).
    DATA(reader1) = cl_sxml_string_reader=>create( input = json ).
    DATA(xml_writer1) = cl_sxml_string_writer=>create( ).
    TRY.
        reader1->next_node( ).
        reader1->skip_node( xml_writer1 ).
      CATCH cx_sxml_parse_error INTO DATA(error1).
        out->write_text( error1->get_text( ) ).
    ENDTRY.
    out->write_xml( xml_writer1->get_output( ) ).

    "Parse JSON data with setting the member option
    out->next_section( 'JSON-XML with member elements' ).
    DATA(reader2) = cl_sxml_string_reader=>create( input = json ).
    reader2->set_option( if_sxml_reader=>co_opt_sep_member ).
    DATA(xml_writer2) = cl_sxml_string_writer=>create( ).
    TRY.
        reader2->next_node( ).
        reader2->skip_node( xml_writer2 ).
      CATCH cx_sxml_parse_error INTO DATA(error2).
        out->write_text( error2->get_text( ) ).
    ENDTRY.
    out->write_xml( xml_writer2->get_output( )
      )->display( ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  json_demo=>main( ).
