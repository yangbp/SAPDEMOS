REPORT demo_sxml_parse_xml.

CLASS sxml_demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
  PRIVATE SECTION.
    CLASS-METHODS get_node_type
      IMPORTING node_type_int           TYPE if_sxml_node=>node_type
      RETURNING VALUE(node_type_string) TYPE string.
    CLASS-METHODS get_value_type
      IMPORTING value_type_int           TYPE if_sxml_value=>value_type
      RETURNING VALUE(value_type_string) TYPE string.
ENDCLASS.

CLASS sxml_demo IMPLEMENTATION.
  METHOD main.
    DATA: BEGIN OF node,
            node_type  TYPE string,
            prefix     TYPE string,
            name       TYPE string,
            nsuri      TYPE string,
            value_type TYPE string,
            value      TYPE string,
          END OF node,
          nodes LIKE TABLE OF node.

    DATA(xml_string) = `<root />`.
    DO.
      cl_demo_text=>edit_string(
        EXPORTING
          title = 'XML-Data'
        CHANGING
          text_string = xml_string
        EXCEPTIONS
          canceled    = 4 ).
      IF sy-subrc = 4.
        EXIT.
      ENDIF.
      DATA(xml) = cl_abap_codepage=>convert_to(
        replace( val = xml_string sub = |\n| with = `` occ = 0  ) ).

      DATA(out) = cl_demo_output=>new(
        )->begin_section( `XML-Data`
        )->write_xml( xml ).

      DATA(reader) = cl_sxml_string_reader=>create( xml ).
      out->next_section( `Parsed Nodes of the XML-Data` ).
      CLEAR nodes.
      TRY.
          DO.
            reader->next_node( ).
            IF reader->node_type = if_sxml_node=>co_nt_final.
              EXIT.
            ENDIF.
            APPEND VALUE #(
              node_type  = get_node_type( reader->node_type )
              prefix     = reader->prefix
              name       = reader->name
              nsuri      = reader->nsuri
              value_type = get_value_type( reader->value_type )
              value      = reader->value ) TO nodes.
            IF reader->node_type = if_sxml_node=>co_nt_element_open.
              DO.
                reader->next_attribute( ).
                IF reader->node_type <> if_sxml_node=>co_nt_attribute.
                  EXIT.
                ENDIF.
                APPEND VALUE #(
                  node_type  = `attribute`
                  prefix     = reader->prefix
                  name       = reader->name
                  nsuri      = reader->nsuri
                  value      = reader->value ) TO nodes.
              ENDDO.
            ENDIF.
          ENDDO.
        CATCH cx_sxml_parse_error INTO DATA(parse_error).
          out->write_text( parse_error->get_text( ) ).
      ENDTRY.

      out->display( nodes ).
    ENDDO.
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
  METHOD get_value_type.
    CASE value_type_int.
      WHEN 0.
        value_type_string = `Initial`.
      WHEN if_sxml_value=>co_vt_none .
        value_type_string = `CO_VT_NONE`.
      WHEN if_sxml_value=>co_vt_text.
        value_type_string = `CO_VT_TEXT`.
      WHEN if_sxml_value=>co_vt_raw.
        value_type_string = `CO_VT_RAW`.
      WHEN if_sxml_value=>co_vt_any.
        value_type_string = `CO_VT_ANY`.
      WHEN OTHERS.
        value_type_string = `Error`.
    ENDCASE.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  sxml_demo=>main( ).
