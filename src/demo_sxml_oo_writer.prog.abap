REPORT demo_sxml_oo_writer.

CLASS sxml_demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS sxml_demo IMPLEMENTATION.
  METHOD main.
    DATA(writer) =
      CAST if_sxml_writer( cl_sxml_string_writer=>create(  ) ).

    DATA open_element TYPE REF TO if_sxml_open_element.
    DATA value TYPE REF TO if_sxml_value_node.
    TRY.
        open_element = writer->new_open_element(
                         name = 'texts'
                         nsuri = 'http://www.sap.com/abapdemos'
                         prefix = 'demo' ).
        writer->write_node( open_element ).
        open_element = writer->new_open_element(
                         name = 'text'
                         nsuri = 'http://www.sap.com/abapdemos' ).
        open_element->set_attribute( name = 'format'
                                     value = 'bold' ).
        open_element->set_attribute( name = 'level'
                                     value = '1' ).
        writer->write_node( open_element ).
        value = writer->new_value( ).
        value->set_value( 'aaaa' ).
        writer->write_node( value ).
        writer->write_node( writer->new_close_element( ) ).
        open_element = writer->new_open_element(
                         name = 'text'
                         nsuri = 'http://www.sap.com/abapdemos' ).
        open_element->set_attribute( name = 'format'
                                     value = 'italic' ).
        open_element->set_attribute( name = 'level'
                                     value = '2' ).
        writer->write_node( open_element ).
        value = writer->new_value( ).
        value->set_value( 'bbbb' ).
        writer->write_node( value ).
        writer->write_node( writer->new_close_element( ) ).
        writer->write_node( writer->new_close_element( ) ).
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
