REPORT demo_sxml_token_reader_steps.

CLASS sxml_demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
  PRIVATE SECTION.
    CLASS-DATA parser TYPE REF TO if_sxml_reader.
    CLASS-DATA: BEGIN OF wa,
                  method     TYPE string,
                  node_type  TYPE string,
                  name       TYPE string,
                  value      TYPE string,
                END OF wa,
                output LIKE TABLE OF wa.
    CLASS-METHODS parse
      IMPORTING method TYPE string.
    CLASS-METHODS get_node_type
      IMPORTING node_type_int TYPE if_sxml_node=>node_type
      RETURNING VALUE(node_type_string) TYPE string.
ENDCLASS.

CLASS sxml_demo IMPLEMENTATION.
  METHOD main.
    DATA(out) = cl_demo_output=>new(
      )->begin_section( `XML-Data` ).
    DATA(xml) = |<x a="aval" b="bval"><y c="cval">yval</y></x>|.
    out->write_xml( xml ).

    out->next_section( `Parser Methods` ).

    parser = cl_sxml_string_reader=>create(
               cl_abap_codepage=>convert_to( xml ) ).

    parse( 'NEXT_NODE' ).
    parse( 'NEXT_ATTRIBUTE' ).
    parse( 'NEXT_ATTRIBUTE' ).
    parse( 'CURRENT_NODE' ).
    parse( 'NEXT_ATTRIBUTE' ).
    parse( 'NEXT_NODE' ).
    parse( 'NEXT_ATTRIBUTE' ).
    parse( 'NEXT_NODE' ).
    parse( 'PUSH_BACK' ).
    parse( 'NEXT_ATTRIBUTE' ).
    parse( 'PUSH_BACK' ).
    parse( 'SKIP_NODE' ).
    parse( 'NEXT_NODE' ).

    out->display( output ).
  ENDMETHOD.
  METHOD parse.
    CALL METHOD parser->(method).
    APPEND VALUE #(
      method     = method
      node_type  = get_node_type( parser->node_type )
      name       = parser->name
      value      = parser->value ) TO output.
  ENDMETHOD.
  METHOD get_node_type.
    CASE node_type_int.
      WHEN if_sxml_node=>co_nt_initial.
        node_type_string = `CO_NT_INITIAL`.
*      WHEN if_sxml_node=>co_nt_comment.
*        node_type_string = `CO_NT_COMMENT`.
      WHEN if_sxml_node=>co_nt_element_open.
        node_type_string = `CO_NT_ELEMENT_OPEN`.
      WHEN if_sxml_node=>co_nt_element_close.
        node_type_string = `CO_NT_ELEMENT_CLOSE`.
      WHEN if_sxml_node=>co_nt_value.
        node_type_string = `CO_NT_VALUE`.
      WHEN if_sxml_node=>co_nt_attribute.
        node_type_string = `CO_NT_ATTRIBUTE`.
*      WHEN if_sxml_node=>co_nt_pi.
*        node_type_string = `CO_NT_FINAL`.
      WHEN OTHERS.
        node_type_string = `Error`.
    ENDCASE.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  sxml_demo=>main( ).
