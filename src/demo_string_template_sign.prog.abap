REPORT demo_string_template_sign.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA:  num1    TYPE i VALUE -10,
           num2    TYPE i VALUE +10,
           results TYPE TABLE OF string,
           formats TYPE abap_attrdescr_tab,
           format  LIKE LINE OF formats.

    FIELD-SYMBOLS <sign> LIKE cl_abap_format=>s_left.

    formats =
      CAST cl_abap_classdescr(
             cl_abap_classdescr=>describe_by_name( 'CL_ABAP_FORMAT' )
             )->attributes.
    DELETE formats WHERE name NP 'S_*' OR is_constant <> 'X'.

    LOOP AT formats INTO format.
      ASSIGN cl_abap_format=>(format-name) TO <sign>.
      APPEND |{ format-name WIDTH = 16 }  | &
             |"{ num1 SIGN = (<sign>) }"  | &
             |"{ num2 SIGN = (<sign>) }"  | TO results.
    ENDLOOP.
    cl_demo_output=>display( results ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
