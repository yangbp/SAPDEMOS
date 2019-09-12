REPORT demo_st_json_table_attributes.

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
    CALL TRANSFORMATION demo_st_json_table_attributes
                        SOURCE carriers = carrier_tab
                        RESULT XML json_writer.
    DATA(json) = json_writer->get_output( ).
    out->write_json( json ).

    "Simple Transformation to JSON-XML
    out->next_section( 'JSON-XML' ).
    CALL TRANSFORMATION demo_st_json_table_attributes
                        SOURCE carriers = carrier_tab
                        RESULT XML DATA(xml).
    out->write_xml( xml ).


    out->display( ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
