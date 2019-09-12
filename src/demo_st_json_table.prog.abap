REPORT demo_st_json_table.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    "Internal table as source of transformation
    DATA(out) = cl_demo_output=>new(
      )->begin_section( 'Internal Table' ).
    DATA: BEGIN OF carrier_wa,
            carrid   TYPE scarr-carrid,
            carrname TYPE scarr-carrname,
            url      TYPE scarr-url,
          END OF carrier_wa,
          carrier_tab LIKE TABLE OF carrier_wa.
    SELECT *
           FROM scarr
           INTO CORRESPONDING FIELDS OF TABLE @carrier_tab.
    out->write_data( carrier_tab ).

    "Simple Transformation to JSON
    out->next_section( 'JSON' ).
    DATA(json_writer) = cl_sxml_string_writer=>create(
                          type = if_sxml=>co_xt_json ).
    CALL TRANSFORMATION demo_st_json_table
                        SOURCE carriers = carrier_tab
                        RESULT XML json_writer.
    DATA(json) = json_writer->get_output( ).
    out->write_json( json ).

    "Simple Transformation to JSON-XML
    out->next_section( 'JSON-XML' ).
    CALL TRANSFORMATION demo_st_json_table
                        SOURCE carriers = carrier_tab
                        RESULT XML DATA(xml).
    out->write_xml( xml ).

    "Assert symmetry of transformation
    DATA result_tab LIKE carrier_tab.
    CALL TRANSFORMATION demo_st_json_table
                        SOURCE XML json
                        RESULT carriers = result_tab.
    ASSERT result_tab = carrier_tab.

    "Assert that results of transformation and JSON-Writer are the same
    DATA(xml_reader) = cl_sxml_string_reader=>create( xml ).
    json_writer = cl_sxml_string_writer=>create(
                    type = if_sxml=>co_xt_json ).
    xml_reader->next_node( ).
    xml_reader->skip_node( json_writer ).
    ASSERT json_writer->get_output( ) = json.

    out->display( ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
