REPORT demo_string_template_case.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA: output  TYPE TABLE OF string,
          formats TYPE abap_attrdescr_tab,
          format  LIKE LINE OF formats.

    FIELD-SYMBOLS <case> LIKE cl_abap_format=>c_raw.

    formats =
      CAST cl_abap_classdescr(
             cl_abap_classdescr=>describe_by_name( 'CL_ABAP_FORMAT' )
             )->attributes.
    DELETE formats WHERE name NP 'C_*' OR is_constant <> 'X'.

    LOOP AT formats INTO format.
      ASSIGN cl_abap_format=>(format-name) TO <case>.

      APPEND |{ format-name WIDTH = 20 }| &
             |{ `UPPER CASE, lower case ` CASE = (<case>) }|
             TO output.
    ENDLOOP.
    cl_demo_output=>display( output ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
