REPORT demo_asjson_tables.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    TYPES: BEGIN OF struct,
             day  TYPE string,
             date TYPE d,
           END OF struct.
    DATA itab TYPE STANDARD TABLE OF struct.
    itab = VALUE #( ( day = 'Yesterday' date = sy-datlo - 1 )
                    ( day = 'Today'     date = sy-datlo )
                    ( day = 'Tomorrow'  date = sy-datlo + 1 )
                    ).

    "Transformation to JSON
    DATA(out) = cl_demo_output=>new(
      )->begin_section( 'asJSON' ).
    DATA(writer) = cl_sxml_string_writer=>create(
      type = if_sxml=>co_xt_json ).
    CALL TRANSFORMATION id SOURCE itab = itab
                           RESULT XML writer.
    DATA(json) = writer->get_output( ).
    out->write_json( json ).

    "JSON-XML
     out->next_section( 'asJSON-XML' ).
    DATA(reader) = cl_sxml_string_reader=>create( json ).
    DATA(xml_writer) = cl_sxml_string_writer=>create( ).
    reader->next_node( ).
    reader->skip_node( xml_writer ).
    DATA(xml) = xml_writer->get_output( ).
    out->write_xml( xml ).

    "asXML
     out->next_section( 'asXML' ).
    CALL TRANSFORMATION id SOURCE itab = itab
                           RESULT XML xml.
    out->write_xml( xml )->display( ).

  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
