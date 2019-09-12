REPORT demo_call_trafo_id_json.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA(out) = cl_demo_output=>new(
      )->begin_section(
      `Identity Transformation for JSON Writer` ).
    DATA json_writer TYPE REF TO cl_sxml_string_writer.

    out->begin_section(
      `Source JSON String` ).
    DATA(json) = cl_abap_codepage=>convert_to(
                   `{"TEXT":"Hello JSON!"}` ).
    json_writer = cl_sxml_string_writer=>create(
                    type = if_sxml=>co_xt_json ).
    CALL TRANSFORMATION id SOURCE XML json
                           RESULT XML json_writer.
    out->write_json( json_writer->get_output( ) ).

    out->next_section(
      `Source JSON Reader` ).
    DATA(json_reader) = cl_sxml_string_reader=>create( json ).
    json_writer = cl_sxml_string_writer=>create(
                    type = if_sxml=>co_xt_json ).
    CALL TRANSFORMATION id SOURCE XML json_reader
                           RESULT XML json_writer.
    out->write_json( json_writer->get_output( ) ).

    out->next_section(
      `Source JSON-XML` ).
    DATA(xml_json) = cl_abap_codepage=>convert_to(
     `<object><str name="TEXT">Hello JSON!</str></object>` ).
    json_writer = cl_sxml_string_writer=>create(
                    type = if_sxml=>co_xt_json ).
    CALL TRANSFORMATION id SOURCE XML xml_json
                           RESULT XML json_writer.
    out->write_json( json_writer->get_output( )
      )->display( ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
