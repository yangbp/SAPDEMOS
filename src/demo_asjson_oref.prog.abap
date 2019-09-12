REPORT demo_asjson_oref.

INTERFACE intf.
  DATA attr TYPE string.
ENDINTERFACE.

CLASS serializable DEFINITION.
  PUBLIC SECTION.
    INTERFACES if_serializable_object.
    INTERFACES intf DATA VALUES attr = 'Interface Attribute'.
    DATA attr1 TYPE string VALUE `Attribute 1`.
    DATA attr2 TYPE string VALUE `Attribute 2`.
  PRIVATE SECTION.
    CONSTANTS serializable_class_version TYPE i VALUE 1.
ENDCLASS.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA(oref) = NEW serializable( ).

    "Transformation to JSON
    DATA(out) = cl_demo_output=>new(
      )->begin_section( 'asJSON'  ).
    DATA(writer) = cl_sxml_string_writer=>create(
      type = if_sxml=>co_xt_json ).
    CALL TRANSFORMATION id SOURCE oref = oref
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
    CALL TRANSFORMATION id SOURCE oref = oref
                           RESULT XML xml.
    out->write_xml( xml )->display( ).

  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
