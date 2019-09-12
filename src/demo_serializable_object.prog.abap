REPORT demo_serializable_object.

INTERFACE intf.
  METHODS get_attr RETURNING VALUE(attr) TYPE string.
ENDINTERFACE.

CLASS cls_unsafe DEFINITION.
  PUBLIC SECTION.
    INTERFACES: if_serializable_object,
                intf.
  PRIVATE SECTION.
    DATA attr TYPE string VALUE 'Private'.
ENDCLASS.

CLASS cls_unsafe IMPLEMENTATION.
  METHOD intf~get_attr.
    attr = me->attr.
  ENDMETHOD.
ENDCLASS.

CLASS cls_safe DEFINITION.
  PUBLIC SECTION.
    INTERFACES: if_serializable_object,
                intf.
  PRIVATE SECTION.
    DATA attr TYPE string VALUE 'Private'.
    METHODS: serialize_helper   EXPORTING attr TYPE string,
             deserialize_helper IMPORTING attr TYPE string.
ENDCLASS.

CLASS cls_safe IMPLEMENTATION.
  METHOD serialize_helper.
    attr = me->attr.
  ENDMETHOD.
  METHOD deserialize_helper.
  ENDMETHOD.
  METHOD intf~get_attr.
    attr = me->attr.
  ENDMETHOD.
ENDCLASS.

CLASS trafo_demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
  PRIVATE SECTION.
    class-data    out TYPE REF TO if_demo_output.
    CLASS-METHODS serialize_deserialize CHANGING iref TYPE REF TO intf.
ENDCLASS.

CLASS trafo_demo IMPLEMENTATION.
  METHOD main.
    out = cl_demo_output=>new(
      )->begin_section( 'Unsafe Class' ).
    DATA(iref_unsafe) = CAST intf( NEW cls_unsafe( ) ).
    serialize_deserialize( CHANGING iref = iref_unsafe ).

    out->next_section( 'Safe Class' ).
    DATA(iref_safe) = CAST intf( NEW cls_safe( ) ).
    serialize_deserialize( CHANGING iref = iref_safe ).

    out->display( ).
  ENDMETHOD.
  METHOD serialize_deserialize.
    DATA xml_string TYPE string.
    DATA json_string TYPE string.
    out->write_data( iref->get_attr( )
      )->begin_section( 'asXML' ).
    CALL TRANSFORMATION id SOURCE oref = iref
                           RESULT XML xml_string.
    out->write_xml( xml_string ).
    REPLACE REGEX '(<ATTR>)([^<]+)(</ATTR>)' IN xml_string
                                             WITH '$1Public$3'.
    IF sy-subrc = 0.
      CALL TRANSFORMATION id SOURCE XML xml_string
                             RESULT oref = iref.
      out->write_data( iref->get_attr( ) ).
    ENDIF.
    out->next_section( 'asJSON' ).
    DATA(writer) = cl_sxml_string_writer=>create(
                     type = if_sxml=>co_xt_json ).
    CALL TRANSFORMATION id SOURCE oref = iref
                           RESULT XML writer.
    json_string = cl_abap_codepage=>convert_from(
                                      writer->get_output( ) ).
    out->write_json( json_string ).
    REPLACE REGEX '("ATTR":")([^"]+)(")' IN json_string
                                         WITH '$1Nonsense$3'.
    IF sy-subrc = 0.
      CALL TRANSFORMATION id SOURCE XML json_string
                             RESULT oref = iref.
      out->write_data( iref->get_attr( ) ).
    ENDIF.
    out->end_section( ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  trafo_demo=>main( ).
