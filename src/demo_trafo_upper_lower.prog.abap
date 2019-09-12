REPORT demo_trafo_upper_lower.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA(out) = cl_demo_output=>new( ).

    DATA: BEGIN OF simple_struc,
            int_col1 TYPE i VALUE 111,
            int_col2 TYPE i VALUE 222,
          END OF simple_struc.

    out->begin_section( `Serialization` ).

    CALL TRANSFORMATION id
                        SOURCE simple_struc = simple_struc
                        RESULT XML DATA(asxml).
    out->begin_section( `ID`
      )->write_xml( asxml ).

    CALL TRANSFORMATION demo_id_upper_lower
                        PARAMETERS mode = 'LO'
                        SOURCE simple_struc = simple_struc
                        RESULT XML DATA(xml_lower).
    out->next_section( `DEMO_ID_UPPER_LOWER`
      )->write_xml( xml_lower ).

    CALL TRANSFORMATION demo_id_from_to_mixed
                        PARAMETERS mode = 'TO'
                        SOURCE simple_struc = simple_struc
                        RESULT XML DATA(xml_camel).
    out->next_section( `DEMO_ID_FROM_TO_MIXED`
      )->write_xml( xml_camel ).


    out->end_section(
      )->next_section( `Deserialization` ).

    CLEAR simple_struc.
    CALL TRANSFORMATION id
                        SOURCE XML xml_lower
                        RESULT simple_struc = simple_struc.
    out->begin_section( `ID for XML_LOWER`
      )->write( simple_struc ).

    CLEAR simple_struc.
    CALL TRANSFORMATION id
                        SOURCE XML xml_camel
                        RESULT simple_struc = simple_struc.
    out->next_section( `ID for XML_CAMEL`
      )->write( simple_struc ).

    CLEAR simple_struc.
    CALL TRANSFORMATION demo_id_upper_lower
                        SOURCE XML xml_lower
                        RESULT simple_struc = simple_struc.
    out->next_section( `DEMO_ID_UPPER_LOWER for XML_LOWER`
      )->write( simple_struc ).

    CLEAR simple_struc.
    CALL TRANSFORMATION demo_id_from_to_mixed
                        SOURCE XML xml_camel
                        RESULT simple_struc = simple_struc.
    out->next_section( `DEMO_ID_FROM_TO_MIXED for XML_CAMEL`
      )->write( simple_struc ).


    out->display( ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
