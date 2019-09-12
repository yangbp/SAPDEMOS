REPORT demo_asxml_asjson_strct_comps.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA(out) = cl_demo_output=>new(
      )->begin_section( `ABAP Structure` ).
    CONSTANTS:
      BEGIN OF struct,
        text0 TYPE string VALUE ``,
        text1 TYPE string VALUE `Text1`,
        text2 TYPE string VALUE `Text2`,
        text3 TYPE string VALUE `Text3`,
        number0 TYPE i VALUE 0,
        number1 TYPE i VALUE 111,
        number2 TYPE i VALUE 222,
        number3 TYPE i VALUE 333,
     END OF struct.
    DATA(examples) = struct.
    out->write_data( examples ).

    out->next_section( `Structure serialized to asXML` ).
    DATA xml TYPE string.

    CALL TRANSFORMATION id SOURCE examples = examples
                           RESULT XML xml.
    out->write_xml( xml ).

    out->next_section( `Structure serialized to asJSON` ).
    DATA(writer) = cl_sxml_string_writer=>create(
                     type = if_sxml=>co_xt_json ).
    CALL TRANSFORMATION id SOURCE examples = examples
                           RESULT XML writer.
    DATA(json) = cl_abap_codepage=>convert_from(
                   writer->get_output( ) ).
    out->write_json( json ).

    out->next_section( `Modified asXML` ).
    REPLACE `<TEXT2>Text2</TEXT2>` IN xml WITH `<TEXT2 />`.
    REPLACE `<TEXT3>Text3</TEXT3>` IN xml WITH ``.
    REPLACE `<NUMBER2>222</NUMBER2>` IN xml WITH `<NUMBER2 />`.
    REPLACE `<NUMBER3>333</NUMBER3>` IN xml WITH ``.
    out->write_xml( xml ).

    out->next_section(
      `ABAP Structure after Deserialization of asXML` ).
    examples = struct.
    CALL TRANSFORMATION id SOURCE XML xml
                           RESULT examples = examples.
    out->write_data( examples ).

    out->next_section( `Modified asJSON` ).
    REPLACE `"TEXT2":"Text2",` IN json WITH `"TEXT2":""`.
    REPLACE `"TEXT3":"Text3"` IN json WITH ``.
    REPLACE `"NUMBER2":222,` IN json WITH `"NUMBER2":0`.
    REPLACE `"NUMBER3":333` IN json WITH ``.
    out->write_json( json ).

    out->next_section(
      `ABAP Structure after Deserialization of asJSON` ).
    examples = struct.
    CALL TRANSFORMATION id SOURCE XML json
                           RESULT examples = examples.
    out->write_data( examples
      )->display( ).

  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
