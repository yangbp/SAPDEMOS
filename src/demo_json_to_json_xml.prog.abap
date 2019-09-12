REPORT demo_json_to_json_xml.

CLASS json_demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
  PRIVATE SECTION.
    CLASS-METHODS check_json
      IMPORTING json      TYPE string
      RETURNING VALUE(rc) TYPE i.
ENDCLASS.

CLASS json_demo IMPLEMENTATION.
  METHOD main.
    DATA(json) = `{ }`.
    DO.
      cl_demo_text=>edit_string(
        EXPORTING
          title = 'Show JSON-XML for JSON'
        CHANGING
          text_string = json
        EXCEPTIONS
          canceled    = 4 ).
      IF sy-subrc = 4.
        EXIT.
      ENDIF.
      IF check_json( json ) = 0.
        CALL TRANSFORMATION id SOURCE XML json
                               RESULT XML DATA(xml).
        cl_demo_output=>display_xml( xml ).
      ENDIF.
    ENDDO.
  ENDMETHOD.
  METHOD check_json.
    DATA(reader) = cl_sxml_string_reader=>create(
                   cl_abap_codepage=>convert_to( json ) ).
    TRY.
        reader->next_node( ).
        reader->skip_node( ).
      CATCH cx_sxml_parse_error INTO DATA(error).
        cl_demo_output=>begin_section( 'Error in JSON' ).
        cl_demo_output=>display( error->get_text( ) ).
        rc = 4.
    ENDTRY.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  json_demo=>main( ).
