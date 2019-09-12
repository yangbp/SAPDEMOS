REPORT demo_style LINE-SIZE 100 NO STANDARD PAGE HEADING.

CLASS cl_abap_format DEFINITION LOAD.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
  PRIVATE SECTION.
    CLASS-DATA: BEGIN OF format,
                  value LIKE cl_abap_format=>e_xml_text,
                  name  TYPE abap_attrdescr-name,
                END OF format,
                formats LIKE SORTED TABLE OF format
                        WITH UNIQUE KEY value.
    CLASS-METHODS get_formats.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA: number  TYPE decfloat34 VALUE '-12345.67890',
          BEGIN OF result,
            style         TYPE string,
            write_to      TYPE c length 20,
            template_raw  TYPE c length 20,
            template_user TYPE c length 20,
          END OF result,
          results LIKE TABLE OF result,
          off     TYPE i,
          exc     TYPE REF TO cx_sy_unknown_currency.
    get_formats( ).
    LOOP AT demo=>formats INTO demo=>format.
      result-style = demo=>format-name+2.
      WRITE number TO result-write_to
        STYLE demo=>format-value LEFT-JUSTIFIED.
      result-template_raw =
        |{ number STYLE  = (demo=>format-value) }|.
      result-template_user =
        |{ number STYLE  = (demo=>format-value)
                  NUMBER = USER }|.
      APPEND result TO results.
    ENDLOOP.
    cl_demo_output=>display( results ).
  ENDMETHOD.
  METHOD get_formats.
    DATA: formats  TYPE abap_attrdescr_tab,
          format   LIKE LINE OF formats.
    FIELD-SYMBOLS <format> LIKE cl_abap_format=>o_scientific.
    formats =
      CAST cl_abap_classdescr(
             cl_abap_classdescr=>describe_by_name( 'CL_ABAP_FORMAT' )
             )->attributes.
    DELETE formats WHERE name NP 'O_*' OR is_constant <> 'X'.
    LOOP AT formats INTO format.
      ASSIGN cl_abap_format=>(format-name) TO <format>.
      demo=>format-value = <format>.
      demo=>format-name = format-name.
      INSERT demo=>format INTO TABLE demo=>formats.
    ENDLOOP.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
