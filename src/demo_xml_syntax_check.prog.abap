REPORT demo_xml_syntax_check.

CLASS xml_demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
  PRIVATE SECTION.
    CLASS-METHODS check_xml
      IMPORTING xml TYPE string
      RETURNING VALUE(rc) TYPE i.
ENDCLASS.

CLASS xml_demo IMPLEMENTATION.
  METHOD main.
    DATA(xml) = |<root>\n| &&
                | <element attr="...">...</element>\n| &&
                | <element attr="...">...</element>\n| &&
                |</root>|.
    DO.
      cl_demo_text=>edit_string(
        EXPORTING
          title = 'Syntax Check for xml'
        CHANGING
          text_string = xml
        EXCEPTIONS
          canceled    = 4 ).
      IF sy-subrc = 4.
       EXIT.
      ENDIF.
      IF check_xml( xml ) = 0.
        MESSAGE 'xml-Syntax OK' TYPE 'S'.
      ENDIF.
    ENDDO.
  ENDMETHOD.
  METHOD check_xml.
    DATA(reader) = cl_sxml_string_reader=>create(
                   cl_abap_codepage=>convert_to( xml ) ).
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
  xml_demo=>main( ).
