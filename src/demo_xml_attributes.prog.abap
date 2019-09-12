REPORT demo_xml_attributes.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.

    "Original XML
    DATA(xml) = cl_abap_codepage=>convert_to(
                 `<element x='x1' a='a' x='x2'>text</element>` ).

    "XML parsed and rendered with iXML-Library
    DATA(ixml) = cl_ixml=>create( ).
    DATA(stream_factory) = ixml->create_stream_factory( ).
    DATA(document) = ixml->create_document( ).
    ixml->create_parser(
      document = document
      stream_factory = stream_factory
      istream = stream_factory->create_istream_xstring( string = xml )
      )->parse( ).
    DATA dom_xml TYPE xstring.
    document->render( ostream = ixml->create_stream_factory(
                                 )->create_ostream_xstring(
                                      string = dom_xml ) ).

    "XML parsed and rendered with sXML-Library
    "Token based
    DATA(toreader) = cl_sxml_string_reader=>create( xml ).
    DATA(towriter) =
      CAST if_sxml_writer( cl_sxml_string_writer=>create(  ) ).
    DO.
      toreader->next_node( ).
      CASE toreader->node_type.
        WHEN if_sxml_node=>co_nt_element_open.
          towriter->open_element( name   = toreader->name
                                  nsuri  = toreader->nsuri
                                  prefix = toreader->prefix ).
          DO.
            toreader->next_attribute( ).
            IF toreader->node_type = if_sxml_node=>co_nt_attribute.
              towriter->write_attribute( name  = toreader->name
                                         value = toreader->value ).
            ELSE.
              EXIT.
            ENDIF.
          ENDDO.
        WHEN if_sxml_node=>co_nt_value.
          towriter->write_value( toreader->value ).
        WHEN if_sxml_node=>co_nt_element_close.
          towriter->close_element( ).
        WHEN if_sxml_node=>co_nt_final.
          EXIT.
      ENDCASE.
    ENDDO.
    DATA(toserial_xml) =
      CAST cl_sxml_string_writer( towriter )->get_output( ).
    "Object oriented
    DATA(ooreader) = cl_sxml_string_reader=>create( xml ).
    DATA(oowriter) = CAST if_sxml_writer(
                            cl_sxml_string_writer=>create( ) ).
    DO.
      DATA(node) = ooreader->read_next_node( ).
      IF node IS INITIAL.
        EXIT.
      ENDIF.
      oowriter->write_node( node ).
    ENDDO.
    DATA(ooserial_xml) =
      CAST cl_sxml_string_writer( oowriter )->get_output( ).

    "XML transformed with ID
    CALL TRANSFORMATION id SOURCE XML xml
                           RESULT XML DATA(id_xml).

    cl_demo_output=>new(
      )->begin_section( `Handling of XML-Attributes`
      )->begin_section( `Original XML`
      )->write_xml( xml
      )->end_section(
      )->begin_section( `XML parsed to DOM of iXML-Library`
      )->write_xml( dom_xml
      )->end_section(
      )->begin_section( `XML parsed with sXML-Library`
      )->begin_section( `Token based`
      )->write_xml( toserial_xml
      )->next_section( `Object oriented`
      )->write_xml( ooserial_xml
      )->end_section( )->end_section(
      )->begin_section( `XML transformed with ID`
      )->write_xml( id_xml
      )->end_section(
      )->display( ).

  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
