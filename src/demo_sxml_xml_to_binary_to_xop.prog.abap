REPORT demo_sxml_xml_to_binary_to_xop.

CLASS sxml_demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS sxml_demo IMPLEMENTATION.
  METHOD main.
    "XML 1.0
    DATA(xml_reader) = cl_sxml_string_reader=>create(
                         cl_abap_codepage=>convert_to(
                          `<text><!-- comment -->blah</text>` ) ).

    "XML 1.0 to Binary XML
    DATA(binary_writer) = cl_sxml_string_writer=>create(
                            type = if_sxml=>co_xt_binary  ).
    xml_reader->next_node( ).
    xml_reader->skip_node( binary_writer ).
    DATA(binary_xml) =  binary_writer->get_output( ).

    "Binary XML to XOP
    DATA(binary_reader) = cl_sxml_string_reader=>create( binary_xml ).
    DATA(xop_writer) = cl_sxml_xop_writer=>create(  ).
    binary_reader->next_node( ).
    binary_reader->skip_node( xop_writer ).
    DATA(xop_package) = xop_writer->get_output( ).

    cl_demo_output=>display_xml( xop_package-xop_document ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  sxml_demo=>main( ).
