REPORT demo_json_syntax_check.

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
          title = 'Syntax Check for JSON'
        CHANGING
          text_string = json
        EXCEPTIONS
          canceled    = 4 ).
      IF sy-subrc = 4.
        EXIT.
      ENDIF.
      IF check_json( json ) = 0.
        MESSAGE 'JSON-Syntax OK' TYPE 'S'.
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
        cl_demo_output=>display( error->get_text( ) ).
        rc = 4.
    ENDTRY.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  json_demo=>main( ).
