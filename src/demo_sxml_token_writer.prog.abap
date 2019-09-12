REPORT demo_sxml_token_writer.

CLASS sxml_demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS sxml_demo IMPLEMENTATION.
  METHOD main.
    DATA(writer) =
      CAST if_sxml_writer( cl_sxml_string_writer=>create(  ) ).
    TRY.
        writer->open_element( name = 'texts'
                              nsuri = 'http://www.sap.com/abapdemos'
                              prefix = 'demo' ).
        writer->open_element( name = 'text'
                              nsuri = 'http://www.sap.com/abapdemos' ).
        writer->write_attribute( name = 'format' value = 'bold' ).
        writer->write_attribute( name = 'level'  value = '1' ).
        writer->write_value( 'aaaa' ).
        writer->close_element( ).
        writer->open_element( name = 'text'
                              nsuri = 'http://www.sap.com/abapdemos' ).
        writer->write_attribute( name = 'format' value = 'italic' ).
        writer->write_attribute( name = 'level'  value = '2' ).
        writer->write_value( 'bbbb' ).
        writer->close_element( ).
        writer->close_element( ).
      CATCH cx_sxml_state_error INTO DATA(error).
        cl_demo_output=>display_text( error->get_text( ) ).
        RETURN.
    ENDTRY.
    DATA(xml) =
      CAST cl_sxml_string_writer( writer )->get_output(  ).
    cl_demo_output=>display_xml( xml ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  sxml_demo=>main( ).
