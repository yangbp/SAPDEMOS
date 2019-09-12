REPORT demo_asjson_other_xsd_types.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA:
      BEGIN OF examples,
        BEGIN OF boolean,
          ab_true   TYPE abap_bool
                    VALUE abap_true,
          ab_false  TYPE abap_bool
                    VALUE abap_false,
          xsd_true  TYPE xsdboolean
                    VALUE abap_true,
          xsd_false TYPE xsdboolean
                    VALUE abap_false,
        END OF boolean,
        BEGIN OF date,
          ab_date  TYPE d
                   VALUE `20121001`,
          xsd_date TYPE xsddate_d
                   VALUE `20121001`,
        END OF date,
        BEGIN OF datetime,
          ab_timestamp          TYPE timestamp
                                VALUE `20120727170334`,
          ab_timestampl         TYPE timestampl
                                VALUE `20120727170334.1234`,
          xsd_datetime_z        TYPE xsddatetime_z
                                VALUE `20120727170334`,
          xsd_datetime_long_z   TYPE xsddatetime_long_z
                                VALUE `20120727170334.1234`,
          xsd_datetime_offset   TYPE xsddatetime_offset
                                VALUE `20120727170334+140`,
          xsd_datetime_local    TYPE xsddatetime_local
                                VALUE `20120727170334`,
          xsd_datetime_local_dt TYPE xsddatetime_local_dt
                                VALUE `20120727170334`,
        END OF datetime,
        BEGIN OF language,
          ab_language  TYPE sy-langu
                       VALUE `D`,
          xsd_language TYPE xsdlanguage
                       VALUE `D`,
        END OF language,
        BEGIN OF uuid,
          ab_uuid_raw  TYPE x LENGTH 16
                       VALUE `005056A207C81ED1BFC6B69E72F50550`,
          ab_uuid_char  TYPE c LENGTH 32
                       VALUE `005056A207C81ED1BFC6B69E72F50550`,
          xsd_uuid_raw  TYPE xsduuid_raw
                       VALUE `005056A207C81ED1BFC6B69E72F50550`,
          xsd_uuid_char TYPE xsduuid_char
                       VALUE `005056A207C81ED1BFC6B69E72F50550`,
        END OF uuid,
      END OF examples.

    "Transformation to JSON
    DATA(out) = cl_demo_output=>new(
      )->begin_section( 'asJSON'  ).
    DATA(writer) = cl_sxml_string_writer=>create(
      type = if_sxml=>co_xt_json ).
    CALL TRANSFORMATION id SOURCE examples = examples
                           RESULT  XML writer.
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
    CALL TRANSFORMATION id SOURCE examples = examples
                           RESULT  XML xml.
    out->write_xml( xml )->display( ).

  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
