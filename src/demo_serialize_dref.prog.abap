REPORT demo_serialize_dref.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA(out) = cl_demo_output=>new(
      )->begin_section( `Serialization of Data References` ).
    DATA xml  TYPE xstring.
    DATA writer TYPE REF TO cl_sxml_string_writer.

    "Data reference with named type
    out->begin_section( `Data Reference with Named Type` ).
    TYPES:
      BEGIN OF struc,
        comp1 TYPE i,
        comp2 TYPE i,
      END OF struc.
    DATA dref1 TYPE REF TO struc.
    dref1 = NEW #( comp1 = 111 comp2 = 222 ).
    out->begin_section( `asXML for Heap Reference` ).
    CALL TRANSFORMATION id SOURCE dref = dref1
                           RESULT XML xml.
    out->write_xml( xml
      )->next_section( `asJSON for Heap Reference` ).
    writer = cl_sxml_string_writer=>create(
      type = if_sxml=>co_xt_json ).
    CALL TRANSFORMATION id SOURCE dref = dref1
                           RESULT XML writer.
    out->write_json( writer->get_output( )
      )->end_section( ).

    "Data reference with technical type
    out->next_section( `Data Reference with Technical Type` ).
    DATA:
      BEGIN OF struc,
        comp1  TYPE i,
        comp2  TYPE i,
      END OF struc,
      dref2 LIKE REF TO struc.
    dref2 = NEW #( comp1 = 111 comp2 = 222 ).
    out->begin_section( `asXML for Heap Reference`
      )->begin_section( `Without Transformation Option` ).
    TRY.
        CALL TRANSFORMATION id SOURCE dref = dref2
                               RESULT XML xml.
        out->write_xml( xml ).
      CATCH cx_xslt_serialization_error INTO DATA(xml_err).
        out->write( xml_err->previous->get_text( ) ).
    ENDTRY.
    out->next_section( `With Transformation Option` ).
    CALL TRANSFORMATION id SOURCE dref = dref2
                           RESULT XML xml
                           OPTIONS technical_types = 'ignore'.
    out->write_xml( xml
      )->end_section(
      )->next_section( `asJSON for Heap Reference`
      )->begin_section( `Without Transformation Option` ).
    TRY.
        writer = cl_sxml_string_writer=>create(
          type = if_sxml=>co_xt_json ).
        CALL TRANSFORMATION id SOURCE dref = dref2
                               RESULT XML writer.
        out->write_json( writer->get_output( ) ).
      CATCH cx_xslt_serialization_error INTO DATA(json_err).
        out->write( json_err->previous->get_text( ) ).
    ENDTRY.
    out->next_section( `With Transformation Option` ).
    writer = cl_sxml_string_writer=>create(
      type = if_sxml=>co_xt_json ).
    CALL TRANSFORMATION id SOURCE dref = dref2
                           RESULT XML writer
                           OPTIONS technical_types = 'ignore'.
    out->write_json( writer->get_output( )
      )->end_section(
      )->end_section( ).

    "Stack reference
    out->next_section( `Stack Reference` ).
    DATA dref3 TYPE REF TO i.
    dref3 = REF #( 333 ).
    out->begin_section( `asXML for Stack Reference`
      )->begin_section( `Without Transformation Option` ).
    CALL TRANSFORMATION id SOURCE dref = dref3
                           RESULT XML xml.
    out->write_xml( xml
      )->next_section( `With Transformation Option` ).
    CALL TRANSFORMATION id SOURCE dref = dref3
                           RESULT XML xml
                           OPTIONS data_refs = 'heap-or-create'.
    out->write_xml( xml
      )->end_section(
      )->next_section( `asJSON for Stack Reference`
      )->begin_section( `Without Transformation Option` ).
    writer = cl_sxml_string_writer=>create(
      type = if_sxml=>co_xt_json ).
    CALL TRANSFORMATION id SOURCE dref = dref3
                           RESULT XML writer.
    out->write_json( writer->get_output( )
      )->next_section( `With Transformation Option` ).
    writer = cl_sxml_string_writer=>create(
      type = if_sxml=>co_xt_json ).
    CALL TRANSFORMATION id SOURCE dref = dref3
                           RESULT XML writer
                           OPTIONS data_refs = 'heap-or-create'.
    out->write_json( writer->get_output( )
      )->display( ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
