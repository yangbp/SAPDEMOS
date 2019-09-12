REPORT DEMO_IXML_CREATE_ELEMENTS.

CLASS ixml_demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS ixml_demo IMPLEMENTATION.
  METHOD main.
    DATA(ixml)     = cl_ixml=>create( ).
    DATA(document) = ixml->create_document( ).

    DATA(root) = document->create_element_ns( name = 'abap'
                                              prefix = 'asx' ).
    root->set_attribute_ns( name =  'asx'
                            prefix = 'xmlns'
                            value = 'http://www.sap.com/abapxml' ).
    root->set_attribute_ns( name =  'version'
                            value = '1.0' ).
    document->append_child( root ).

    DATA(node1) = document->create_element_ns( prefix = 'asx'
                                               name = 'values' ).
    root->append_child( node1 ).

    DATA(node2) = document->create_element_ns( name = 'TEXT' ).
    node1->append_child( node2 ).

    node2->append_child( document->create_text( 'Hello XML' ) ).

    DATA xml_string TYPE string.
    ixml->create_renderer( document = document
                           ostream  = ixml->create_stream_factory(
                                        )->create_ostream_cstring(
                                             string = xml_string )
                                               )->render( ).
    cl_demo_output=>write_xml( xml_string ).

    DATA result TYPE string.
    CALL TRANSFORMATION id SOURCE XML xml_string
                           RESULT  text = result.
    cl_demo_output=>write_data( result ).

    cl_demo_output=>display( ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  ixml_demo=>main( ).
