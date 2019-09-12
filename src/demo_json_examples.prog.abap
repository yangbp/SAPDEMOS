REPORT demo_json_examples.

CLASS json_demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
  PRIVATE SECTION.
    CLASS-METHODS check_json
      IMPORTING json TYPE string
      RETURNING VALUE(rc) TYPE i.
    CLASS-DATA out TYPE REF TO if_demo_output.
ENDCLASS.

CLASS json_demo IMPLEMENTATION.
  METHOD main.
    out = cl_demo_output=>new(
      )->begin_section( 'Examples for Valid JSON' ).
    LOOP AT cl_demo_valid_json=>examples
            ASSIGNING FIELD-SYMBOL(<example>).
      out->begin_section( <example>-text ).
      IF check_json( <example>-json ) = 0.
        out->write_json( <example>-json ).
      ENDIF.
      out->end_section( ).
    ENDLOOP.
    out->display( ).
  ENDMETHOD.
  METHOD check_json.
    DATA(reader) = cl_sxml_string_reader=>create(
                   cl_abap_codepage=>convert_to( json ) ).
    TRY.
        reader->next_node( ).
        reader->skip_node( ).
      CATCH cx_sxml_parse_error INTO DATA(error).
        out->write_text( error->get_text( ) ).
    ENDTRY.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  json_demo=>main( ).
