REPORT demo_json_names_to_upper.

CLASS json_demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
  PRIVATE SECTION.
    CLASS-METHODS:
      json_names_to_upper_pr
        IMPORTING in         TYPE xstring
        RETURNING VALUE(out) TYPE xstring,
      json_names_to_upper_tr
        IMPORTING in         TYPE xstring
        RETURNING VALUE(out) TYPE xstring.
ENDCLASS.

CLASS json_demo IMPLEMENTATION.
  METHOD main.
    DATA(out) = cl_demo_output=>new( ).

    DATA: BEGIN OF struc,
            col1 TYPE i,
            col2 TYPE i,
          END OF struc.

    DATA(json) = cl_abap_codepage=>convert_to(
                   `{"struc":{"col1":1,"col2":2}}` ).

    out->begin_section( 'Original JSON'
      )->write_json( json ).

    CALL TRANSFORMATION id SOURCE XML json RESULT struc = struc.

    out->next_section( 'Deserialized JSON'
      )->write( struc ).

    DATA(asjson) = json_names_to_upper_pr( json ).

    ASSERT asjson = json_names_to_upper_tr( json ).

    out->begin_section( 'Modified JSON'
      )->write_json( asjson ).

    CALL TRANSFORMATION id SOURCE XML asjson RESULT struc = struc.

    out->next_section( 'Deserialized JSON'
      )->write( struc ).

    out->display( ).
  ENDMETHOD.

  METHOD json_names_to_upper_pr.
    DATA(reader) = cl_sxml_string_reader=>create( in ).
    DATA(writer) = CAST if_sxml_writer(
      cl_sxml_string_writer=>create( type = if_sxml=>co_xt_json ) ).
    DO.
      DATA(node) = reader->read_next_node( ).
      IF node IS INITIAL.
        EXIT.
      ENDIF.
      IF node->type = if_sxml_node=>co_nt_element_open.
        DATA(attributes)  = CAST if_sxml_open_element(
                                   node )->get_attributes( ).
        LOOP AT attributes ASSIGNING FIELD-SYMBOL(<attribute>).
          IF <attribute>->qname-name = 'name'.
            <attribute>->set_value(
              to_upper( <attribute>->get_value( ) ) ).
          ENDIF.
        ENDLOOP.
      ENDIF.
      writer->write_node( node ).
    ENDDO.
    out = CAST cl_sxml_string_writer( writer )->get_output( ) .
  ENDMETHOD.

  METHOD json_names_to_upper_tr.
    DATA(writer) =
      cl_sxml_string_writer=>create( type = if_sxml=>co_xt_json ).
    CALL TRANSFORMATION demo_json_xml_to_upper
                        SOURCE XML in
                        RESULT XML writer.
    out = writer->get_output( ) .
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  json_demo=>main( ).
