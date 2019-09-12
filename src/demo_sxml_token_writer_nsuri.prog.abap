REPORT demo_sxml_token_writer_nsuri.

CLASS sxml_demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS sxml_demo IMPLEMENTATION.
  METHOD main.
    DATA(writer) =
      CAST if_sxml_writer( cl_sxml_string_writer=>create(  ) ).

    DATA(nsuri1) = `http://www.sap.com/abapdemos`.
    DATA(nsuri2) = `http://www.sap.com/abapdemos/sub`.
    writer->open_element( name = 'texts'
                          nsuri = nsuri1
                          prefix = 'demo' ).
    writer->write_namespace_declaration( nsuri = nsuri2
                          prefix = 'sub' ).
    writer->open_element( name = 'text'
                          nsuri = nsuri2 ).
    writer->write_value( 'aaaa' ).
    writer->close_element( ).
    writer->open_element( name = 'text'
                          nsuri = nsuri2 ).
    writer->write_value( 'bbbb' ).
    writer->close_element( ).
    writer->close_element( ).

    DATA(xml) =
      CAST cl_sxml_string_writer( writer )->get_output(  ).
    cl_demo_output=>display_xml( xml ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  sxml_demo=>main( ).
