REPORT kellerh_xml_to_json.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    TYPES: BEGIN OF node,
             node_type TYPE if_sxml_node=>node_type,
             name      TYPE string,
             value     TYPE string,
             array     TYPE c LENGTH 1,
           END OF node.
    DATA nodes TYPE TABLE OF node WITH EMPTY KEY.

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

      "Parsing XML into an internal table
      DATA(reader) = cl_sxml_string_reader=>create( xml ).
      CLEAR nodes.
      TRY.
          DO.
            reader->next_node( ).
            IF reader->node_type = if_sxml_node=>co_nt_final.
              EXIT.
            ENDIF.
            APPEND VALUE #(
              node_type  = reader->node_type
              name       = reader->prefix &&
                           COND string(
                             WHEN reader->prefix IS NOT INITIAL
                                  THEN `:` ) && reader->name
              value      = reader->value ) TO nodes.
            IF reader->node_type = if_sxml_node=>co_nt_element_open.
              DO.
                reader->next_attribute( ).
                IF reader->node_type <> if_sxml_node=>co_nt_attribute.
                  EXIT.
                ENDIF.
                APPEND VALUE #(
                  node_type = if_sxml_node=>co_nt_initial
                  name       = reader->prefix &&
                               COND string(
                                 WHEN reader->prefix IS NOT INITIAL
                                   THEN `:` ) && reader->name
                  value      = reader->value ) TO nodes.
              ENDDO.
            ENDIF.
          ENDDO.
        CATCH cx_sxml_parse_error INTO DATA(parse_error).
          out->write_text( parse_error->get_text( ) ).
      ENDTRY.

      "Determine the array limits in the internal table
      LOOP AT nodes ASSIGNING FIELD-SYMBOL(<node_open>)
                    WHERE
                     node_type = if_sxml_node=>co_nt_element_open
                     AND array IS INITIAL.
        DATA(idx_open) = sy-tabix.
        LOOP AT nodes ASSIGNING FIELD-SYMBOL(<node_close>)
                      FROM idx_open  + 1
                      WHERE
                        node_type = if_sxml_node=>co_nt_element_close
                        AND name = <node_open>-name.
          DATA(idx_close) = sy-tabix.
          IF idx_close < lines( nodes ).
            ASSIGN nodes[ idx_close + 1 ] TO FIELD-SYMBOL(<node>).
            IF <node>-node_type = if_sxml_node=>co_nt_element_open AND
               <node>-name = <node_open>-name.
              <node_open>-array = 'O'.
              <node>-array = '_'.
            ELSEIF
              ( <node>-node_type = if_sxml_node=>co_nt_element_open
                AND <node>-name <> <node_open>-name )
              OR <node>-node_type = if_sxml_node=>co_nt_element_close.
              <node_close>-array = COND #(
                WHEN <node_open>-array = 'O' THEN 'C' ).
              EXIT.
            ENDIF.
          ENDIF.
        ENDLOOP.
      ENDLOOP.
      "out->begin_section( `Nodes`
      ")->write( nodes ).

      "Render the internal table to JSON-XML
      DATA(writer) = CAST if_sxml_writer(
       cl_sxml_string_writer=>create( type = if_sxml=>co_xt_json ) ).
      "create( type = if_sxml=>co_xt_xml10 ) ).
      TRY.
          writer->open_element( name = 'object' ).
          LOOP AT nodes ASSIGNING <node>.
            CASE <node>-node_type.
              WHEN if_sxml_node=>co_nt_element_open.
                IF <node>-array IS INITIAL.
                  writer->open_element( name = 'object' ).
                  writer->write_attribute( name = 'name'
                                           value = <node>-name ).
                ELSEIF <node>-array = 'O'.
                  writer->open_element( name = 'array' ).
                  writer->write_attribute( name = 'name'
                                           value = <node>-name ).
                  writer->open_element( name = 'object' ).
                ELSEIF <node>-array = '_'.
                  writer->open_element( name = 'object' ).
                ENDIF.
              WHEN if_sxml_node=>co_nt_element_close.
                IF <node>-array <> 'C'.
                  writer->close_element( ).
                ELSE.
                  writer->close_element( ).
                  writer->close_element( ).
                ENDIF.
              WHEN if_sxml_node=>co_nt_initial.
                writer->open_element( name = 'str' ).
                writer->write_attribute( name = 'name'
                                         value = `a_` && <node>-name ).
                writer->write_value( <node>-value ).
                writer->close_element( ).
              WHEN if_sxml_node=>co_nt_value.
                writer->open_element( name = 'str' ).
                writer->write_attribute( name = 'name'
                                         value = `e_` && <node>-name ).
                writer->write_value( <node>-value ).
                writer->close_element( ).
              WHEN OTHERS.
                out->display( 'A node type is not yet supported' ).
                RETURN.
            ENDCASE.
          ENDLOOP.
          writer->close_element( ).

          DATA(json) =
            CAST cl_sxml_string_writer( writer )->get_output( ).

          out->next_section( 'JSON-Data' ).
          IF writer->if_sxml~type = if_sxml=>co_xt_json.
            out->write_json( json ).
          ELSEIF writer->if_sxml~type = if_sxml=>co_xt_xml10.
            out->write_xml( json ).
          ENDIF.

        CATCH cx_sxml_error INTO DATA(exc).
          out->write( exc->get_text( ) ).
      ENDTRY.
      out->display( ).
    ENDDO.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
