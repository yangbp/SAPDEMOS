REPORT demo_sxml_formats.

CLASS sxml_demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
  PRIVATE SECTION.
    CLASS-METHODS fill_writer
      IMPORTING writer TYPE REF TO if_sxml_writer.
    CLASS-METHODS parse_outputs
      IMPORTING xml_10 TYPE xstring
                xml_xop TYPE if_sxml_xop=>xop_package
                xml_binary TYPE xstring
                xml_json TYPE xstring
      EXPORTING xml TYPE xstring
      RETURNING VALUE(rc) TYPE i.
    CLASS-METHODS equals
      IMPORTING p1 TYPE data
                p2 TYPE data
                p3 TYPE data
                p4 TYPE data
      RETURNING VALUE(equals) TYPE abap_bool.
ENDCLASS.

CLASS sxml_demo IMPLEMENTATION.
  METHOD main.
    DATA(out) = cl_demo_output=>new( ).

    DATA writer TYPE REF TO if_sxml_writer.

    "XML 1.0
    out->begin_section( `XML 1.0` ).
    writer = CAST if_sxml_writer(
      cl_sxml_string_writer=>create( type = if_sxml=>co_xt_xml10 ) ).
    fill_writer( writer ).
    DATA(xml_10) =
      CAST cl_sxml_string_writer( writer )->get_output(  ).
    out->write_data( xml_10
      )->write_data(
      cl_abap_codepage=>convert_from( source = xml_10
                                      codepage = `UTF-8` ) ).

    "XOP
    out->next_section( `XOP` ).
    writer = CAST if_sxml_writer(
      cl_sxml_xop_writer=>create( ) ).
    fill_writer( writer ).
    DATA(xml_xop) =
      CAST cl_sxml_xop_writer( writer )->get_output(  ).
    out->write_data( xml_xop-xop_document
      )->write_data(
     cl_abap_codepage=>convert_from( source = xml_xop-xop_document
                                     codepage = `UTF-8` )
      )->write_data( xml_xop-parts ).

    "Binary XML
    out->next_section( `Binary XML` ).
    writer = CAST if_sxml_writer(
      cl_sxml_string_writer=>create( type = if_sxml=>co_xt_binary ) ).
    fill_writer( writer ).
    DATA(xml_binary) =
      CAST cl_sxml_string_writer( writer )->get_output(  ).
    out->write_data( xml_binary
      )->write_data(
      cl_abap_codepage=>convert_from( source = xml_binary
                                      codepage = `UTF-8` ) ).

    "JSON
    out->next_section( `JSON` ).
    writer = CAST if_sxml_writer(
      cl_sxml_string_writer=>create( type = if_sxml=>co_xt_json ) ).
    fill_writer( writer ).
    DATA(xml_json) =
      CAST cl_sxml_string_writer( writer )->get_output(  ).
    out->write_data( xml_json
      )->write_data(
      cl_abap_codepage=>convert_from( source = xml_json
                                      codepage = `UTF-8` ) ).

    "Parse outputs and compare results
    out->next_section( `Parsing all outputs` ).
    DATA xml TYPE xstring.
    CASE parse_outputs( EXPORTING xml_10 = xml_10
                                  xml_xop = xml_xop
                                  xml_binary = xml_binary
                                  xml_json = xml_json
                        IMPORTING xml = xml ).
      WHEN 0.
        out->write_text(
          'Result is the same for all outputs:' ).
        out->write_xml( xml ).
      WHEN 2.
        out->write_text(
          'Results differ for elements!' ).
      WHEN 4.
        out->write_text(
          'Results differ for attributes!' ).
      WHEN 8.
        out->write_text(
          'Parsing raised an exception!' ).
      WHEN 16.
        out->write_text(
          'Transformation results are different!' ).
    ENDCASE.

    out->display( ).
  ENDMETHOD.
  METHOD fill_writer.
    writer->open_element( name = 'object' ).
    writer->open_element( name = 'str' ).
    writer->write_attribute( name = 'name' value = 'text' ).
    writer->write_value( 'Hello sXML!' ).
    writer->close_element( ).
    writer->open_element( name = 'str' ).
    writer->write_attribute( name = 'name' value = 'raw' ).
    writer->write_value_raw( cl_abap_codepage=>convert_to(
                               source = 'raw'
                               codepage = `UTF-8` ) ).
    writer->close_element( ).
    writer->close_element( ).
  ENDMETHOD.
  METHOD parse_outputs.
    DATA(reader_10) = cl_sxml_string_reader=>create( xml_10 ).
    DATA(reader_xop) = cl_sxml_xop_reader=>create( xml_xop ).
    DATA(reader_binary) = cl_sxml_string_reader=>create( xml_binary ).
    DATA(reader_json) = cl_sxml_string_reader=>create( xml_json ).
    TRY.
        DO.
          reader_10->next_node( ).
          reader_xop->next_node( ).
          reader_binary->next_node( ).
          reader_json->next_node( ).
          IF equals( p1 = reader_10->node_type
                     p2 = reader_xop->node_type
                     p3 = reader_binary->node_type
                     p4 = reader_json->node_type ) = abap_false OR
             equals( p1 = reader_10->prefix
                     p2 = reader_xop->prefix
                     p3 = reader_binary->prefix
                     p4 = reader_json->prefix ) = abap_false OR
             equals( p1 = reader_10->name
                     p2 = reader_xop->name
                     p3 = reader_binary->name
                     p4 = reader_json->name ) = abap_false OR
             equals( p1 = reader_10->nsuri
                     p2 = reader_xop->nsuri
                     p3 = reader_binary->nsuri
                     p4 = reader_json->nsuri ) = abap_false OR
             equals( p1 = reader_10->value_type
                     p2 = reader_xop->value_type
                     p3 = reader_binary->value_type
                     p4 = reader_json->value_type ) = abap_false OR
             equals( p1 = reader_10->value
                     p2 = reader_xop->value
                     p3 = reader_binary->value
                     p4 = reader_json->value ) = abap_false.
            rc = 2.
            RETURN.
          ENDIF.
          IF reader_10->node_type = if_sxml_node=>co_nt_final.
            EXIT.
          ENDIF.
          IF reader_10->node_type = if_sxml_node=>co_nt_element_open.
            DO.
              reader_10->next_attribute( ).
              reader_xop->next_attribute( ).
              reader_binary->next_attribute( ).
              reader_json->next_attribute( ).
              IF equals( p1 = reader_10->prefix
                         p2 = reader_xop->prefix
                         p3 = reader_binary->prefix
                         p4 = reader_json->prefix ) = abap_false OR
                 equals( p1 = reader_10->name
                         p2 = reader_xop->name
                         p3 = reader_binary->name
                         p4 = reader_json->name ) = abap_false OR
                 equals( p1 = reader_10->nsuri
                         p2 = reader_xop->nsuri
                         p3 = reader_binary->nsuri
                         p4 = reader_json->nsuri ) = abap_false OR
                 equals( p1 = reader_10->value
                         p2 = reader_xop->value
                         p3 = reader_binary->value
                         p4 = reader_json->value ) = abap_false.
                rc = 4.
                RETURN.
              ENDIF.
              IF reader_10->node_type <> if_sxml_node=>co_nt_attribute.
                EXIT.
              ENDIF.
            ENDDO.
          ENDIF.
        ENDDO.
      CATCH cx_sxml_parse_error INTO DATA(parse_error).
        rc = 8.
        RETURN.
    ENDTRY.
    reader_10 = cl_sxml_string_reader=>create( xml_10 ).
    reader_xop = cl_sxml_xop_reader=>create( xml_xop ).
    reader_binary = cl_sxml_string_reader=>create( xml_binary ).
    reader_json = cl_sxml_string_reader=>create( xml_json ).
    CALL TRANSFORMATION id SOURCE XML reader_10
                           RESULT XML DATA(xstr_10).
    CALL TRANSFORMATION id SOURCE XML reader_xop
                           RESULT XML DATA(xstr_xop).
    CALL TRANSFORMATION id SOURCE XML reader_binary
                           RESULT XML DATA(xstr_binary).
    CALL TRANSFORMATION id SOURCE XML reader_json
                           RESULT XML DATA(xstr_json).
    IF equals( p1 = xstr_10
               p2 = xstr_xop
               p3 = xstr_binary
               p4 = xstr_json ) = abap_false.
      rc = 16.
      RETURN.
    ENDIF.
    xml = xstr_10.
  ENDMETHOD.
  METHOD equals.
    IF p1 = p2 AND
       p1 = p4 AND
       p1 = p4.
      equals = abap_true.
    ELSE.
      equals = abap_false.
    ENDIF.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  sxml_demo=>main( ).
