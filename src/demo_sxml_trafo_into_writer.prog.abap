REPORT demo_sxml_trafo_into_writer.

CLASS sxml_demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS sxml_demo IMPLEMENTATION.
  METHOD main.
    DATA(writer) =
      CAST if_sxml_writer( cl_sxml_string_writer=>create(  ) ).
    writer->open_element( name = 'document' ).
    writer->open_element( name = 'head' ).
    writer->open_element( name = 'author' ).
    writer->write_value( conv string( sy-uname ) ).
    writer->close_element( ).
    writer->open_element( name = 'date' ).
    writer->write_value( conv string( sy-datlo ) ).
    writer->close_element( ).
    writer->close_element( ).
    writer->open_element( name = 'body' ).
    DO 10 TIMES.
      CALL TRANSFORMATION id SOURCE number  = sy-index
                             RESULT XML writer.
    ENDDO.
    writer->close_element( ).
    writer->close_element( ).
    DATA(xml) =
      CAST cl_sxml_string_writer( writer )->get_output(  ).
    cl_demo_output=>display_xml( xml ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  sxml_demo=>main( ).
