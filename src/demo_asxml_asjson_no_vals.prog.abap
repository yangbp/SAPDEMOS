REPORT demo_asxml_asjson_no_vals.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA(out) = cl_demo_output=>new(
      )->begin_section( `asXML` ).
    DATA elem TYPE i VALUE 111.
    DATA: BEGIN OF struc,
           col TYPE i VALUE 111,
          END OF struc.
    DATA itab TYPE TABLE OF i.
    itab = VALUE #( ( 111 ) ).
    out->begin_section( `ABAP Data Objects`
      )->write_data( elem
      )->write_data( struc
      )->write_data( itab ).

    out->next_section(
      `ABAP Data Objects serialized to asXML` ).
    DATA xml TYPE string.
    CALL TRANSFORMATION id SOURCE elem = elem
                                  struc = struc
                                  itab = itab
                           RESULT XML xml.
    out->write_xml( xml ).

    out->next_section( `Modified asXML` ).
    REPLACE `<ELEM>111</ELEM>` IN xml WITH ``.
    REPLACE `<STRUC><COL>111</COL></STRUC>` IN xml WITH ``.
    REPLACE `<ITAB><item>111</item></ITAB>` IN xml WITH ``.
    out->write_xml( xml ).

    out->next_section(
      `ABAP Data Objects after Deserialization of asXML` ).
    CALL TRANSFORMATION id SOURCE XML xml
                           RESULT elem = elem
                                  struc = struc
                                  itab = itab.
    out->write_data( elem
      )->write_data( struc
      )->write_data( itab
      )->end_section( ).

    out->next_section(
      `ABAP Data Objects after Deserialization with Clearing` ).
    CALL TRANSFORMATION id SOURCE XML xml
                           RESULT elem = elem
                                  struc = struc
                                  itab = itab
                          OPTIONS clear = 'all'.
    out->write_data( elem
      )->write_data( struc
      )->write_data( itab
      )->end_section( ).

    out->next_section( `asJSON` ).
    elem = 111.
    struc-col = 111.
    itab = VALUE #( ( 111 ) ).
    out->begin_section( `ABAP Data Objects`
       )->write_data( elem
       )->write_data( struc
       )->write_data( itab ).

    out->next_section(
      `ABAP Data Objects serialized to asJSON` ).
    DATA(writer) = cl_sxml_string_writer=>create(
                     type = if_sxml=>co_xt_json ).
    CALL TRANSFORMATION id SOURCE elem = elem
                                  struc = struc
                                  itab = itab
                           RESULT XML writer.
    DATA(json) = cl_abap_codepage=>convert_from(
                   writer->get_output( ) ).
    out->write_json( json ).

    out->next_section( `Modified asJSON` ).
    json = `{ }`.
    out->write_json( json ).

    out->next_section(
      `ABAP Data Objects after Deserialization of asJSON` ).
    CALL TRANSFORMATION id SOURCE XML json
                           RESULT elem = elem
                                  struc = struc
                                  itab = itab.
    out->write_data( elem
      )->write_data( struc
      )->write_data( itab ).

    out->next_section(
      `ABAP Data Objects after Deserialization with Clearing` ).
    CALL TRANSFORMATION id SOURCE XML json
                           RESULT elem = elem
                                  struc = struc
                                  itab = itab
                          OPTIONS clear = 'all'.
    out->write_data( elem
      )->write_data( struc
      )->write_data( itab
      )->display( ).

  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
