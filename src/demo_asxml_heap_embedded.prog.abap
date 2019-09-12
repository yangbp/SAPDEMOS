REPORT demo_asxml_heap_embedded.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA(out) = cl_demo_output=>new(
      )->begin_section( `Serialization of Data Reference Variable` ).

    DATA dref TYPE REF TO string.
    dref = NEW #( `contents` ).

    out->begin_section( `Contents in Heap`
      )->begin_section( `asXML` ).
    CALL TRANSFORMATION id SOURCE dref = dref
                           RESULT XML DATA(xml_heap).
    out->write_xml( xml_heap
      )->next_section( `asJSON` ).
    DATA(writer_heap) = cl_sxml_string_writer=>create(
                          type = if_sxml=>co_xt_json ).
    CALL TRANSFORMATION id SOURCE dref = dref
                           RESULT XML writer_heap.
    out->write_json( writer_heap->get_output( )
      )->end_section( ).

    out->next_section( `Contents Embedded`
      )->begin_section( `asXML` ).
    CALL TRANSFORMATION id SOURCE dref = dref
                           RESULT XML DATA(xml_embedded)
                           OPTIONS data_refs = `embedded`.
    out->write_xml( xml_embedded
      )->next_section(`asJSON` ).
    DATA(writer_embedded) = cl_sxml_string_writer=>create(
                          type = if_sxml=>co_xt_json ).
    CALL TRANSFORMATION id SOURCE dref = dref
                           RESULT XML writer_embedded
                           OPTIONS data_refs = `embedded`.
    out->write_json( writer_embedded->get_output( )
      )->display( ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
