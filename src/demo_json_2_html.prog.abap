REPORT demo_json_2_html.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    SELECT *
           FROM scarr
           INTO TABLE @DATA(result)
           UP TO 3 ROWS.
    DATA(json_writer) = cl_sxml_string_writer=>create(
                          type = if_sxml=>co_xt_json ).
    CALL TRANSFORMATION id SOURCE result = result
                           RESULT XML json_writer.
    DATA(json) = json_writer->get_output( ).

    CALL TRANSFORMATION sjson2html SOURCE XML json
                                   RESULT XML DATA(html).

    cl_demo_output=>display_html(
      cl_abap_codepage=>convert_from( html ) ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
