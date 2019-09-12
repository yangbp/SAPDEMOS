REPORT demo_usage_output_static.

PARAMETERS: p_html RADIOBUTTON GROUP grp,
            p_text RADIOBUTTON GROUP grp.

CLASS demo_spfli DEFINITION.
  PUBLIC SECTION.
    TYPES spfli_tab TYPE STANDARD TABLE OF spfli WITH EMPTY KEY.
    CLASS-METHODS get RETURNING  VALUE(spfli_tab) TYPE spfli_tab.
ENDCLASS.
CLASS demo_spfli IMPLEMENTATION.
  METHOD get.
    CALL METHOD ('CL_DEMO_SPFLI')=>('GET_SPFLI') RECEIVING spfli = spfli_tab.
  ENDMETHOD.
ENDCLASS.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    "Example data
    DATA int  TYPE i VALUE 444.
    DATA pack TYPE p LENGTH 8 DECIMALS 2 VALUE '12345.67'.
    DATA decf TYPE decfloat34 VALUE '123.456E789'.
    DATA text TYPE string VALUE `string`.
    DATA date TYPE d VALUE '20120504'.
    DATA time TYPE t VALUE '111833'.
    DATA hex  TYPE xstring VALUE 'FF00'.
    DATA xml  TYPE string.
    DATA json TYPE xstring.

    DATA dref TYPE REF TO i.

    DATA: BEGIN OF flat_struct,
           col1 TYPE string VALUE `first component`,
           col2 TYPE string VALUE `second component`,
          END OF flat_struct.
    DATA: BEGIN OF one_struct,
           comp TYPE string VALUE `single component of a structure`,
          END OF one_struct.
    DATA: BEGIN OF deep_struct,
           comp TYPE REF TO i,
          END OF deep_struct.
    DATA: BEGIN OF nested_struct,
            comp LIKE flat_struct,
          END OF nested_struct.
    DATA: BEGIN OF table_struct,
            comp TYPE TABLE OF string,
          END OF table_struct.
    DATA: BEGIN OF line_struct,
           col1 TYPE i,
           col2 TYPE i,
          END OF line_struct.

    DATA array TYPE TABLE OF i.
    DATA table LIKE TABLE OF line_struct.

    DATA:
      BEGIN OF npstruc,
        col1 TYPE string,
        col2 TYPE string,
      END OF npstruc,
      list LIKE TABLE OF npstruc.

    "Init example data
    DO 10 TIMES.
      APPEND sy-index TO array.
    ENDDO.

    CREATE DATA dref.

    nested_struct-comp-col1 = `first nested component`.
    nested_struct-comp-col2 = `second nested component`.

    APPEND `First line of nested table` TO table_struct-comp.
    APPEND `Second line of nested table` TO table_struct-comp.

    DO 10 TIMES.
      line_struct-col1 = sy-index.
      line_struct-col2 = sy-index ** 2.
      APPEND line_struct TO table.
    ENDDO.

    npstruc-col1 = |Text|.
    npstruc-col2 = |Text\nText\nText|.
    APPEND npstruc TO list.
    npstruc-col1 = |Text\tText\tText|.
    npstruc-col2 = |Text\tText\nText\tText|.
    APPEND npstruc TO list.

    CALL TRANSFORMATION id SOURCE flat_struct = flat_struct
                           RESULT XML xml.

    DATA(writer) = cl_sxml_string_writer=>create( type = if_sxml=>co_xt_json ).
    CALL TRANSFORMATION id SOURCE flat_struct = flat_struct
                           RESULT XML writer.
    json = writer->get_output( ).

    "Output mode
    IF p_text = abap_true.
      cl_demo_output=>set_mode( cl_demo_output=>text_mode ).
    ENDIF.

    "Some text
    cl_demo_output=>begin_section( 'Title, Level 1' ).
    cl_demo_output=>begin_section( 'Title, Level 2' ).
    cl_demo_output=>begin_section( 'Title, Level 3' ).
    cl_demo_output=>begin_section( 'Title, Level 4' ).
    cl_demo_output=>write_text( |The value of int is { int }| ).
    cl_demo_output=>write( |Non proportional text with blanks      ...| ).
    cl_demo_output=>write_text( |Text with\nlinebreak,\nlinebreak,\nlinebreak ... | ).
    cl_demo_output=>write( |Handmade table:\n| &&
                                   |{ `field11` WIDTH = 20 }{ `field12` WIDTH = 20 }\n| &&
                                   |{ `field21` WIDTH = 20 }{ `field22` WIDTH = 20 }\n| &&
                                   |{ `field31` WIDTH = 20 }{ `field32` WIDTH = 20 }\n| ).
    cl_demo_output=>display( |Linebreaks and tabs:\n| &&
                             |First line.\r\ttab\ttab\ttab\n\ttab\ttab\ttab\rLast line.| ).

    "Some data
    cl_demo_output=>begin_section( 'Literals' ).
    cl_demo_output=>write_data( -555 ).
    cl_demo_output=>display_data( 'literal text' ).

    cl_demo_output=>begin_section( 'Elementary Fields' ).
    cl_demo_output=>write_data( int ).
    cl_demo_output=>write_data( pack ).
    cl_demo_output=>write_data( decf ).
    cl_demo_output=>write_data( text ).
    cl_demo_output=>write_data( date ).
    cl_demo_output=>write_data( time ).
    cl_demo_output=>write_data( hex ).
    cl_demo_output=>write_data( one_struct-comp ).
    cl_demo_output=>display( ).

    cl_demo_output=>begin_section( 'Structures' ).
    cl_demo_output=>write_data( one_struct ).
    cl_demo_output=>write_data( flat_struct ).
    cl_demo_output=>write_data( nested_struct-comp ).
    cl_demo_output=>write_data( table_struct-comp ).
    cl_demo_output=>display( ).

    cl_demo_output=>begin_section( 'Tables' ).
    cl_demo_output=>write_data( array ).
    cl_demo_output=>display_data( table ).

    cl_demo_output=>begin_section( 'Database Table' ).
    cl_demo_output=>display_data( demo_spfli=>get( ) ).

    IF p_text IS INITIAL.
      cl_demo_output=>begin_section( 'Non-proportional Display of Table' ).
      cl_demo_output=>write( list ).
      cl_demo_output=>display( ).
    ENDIF.

    "Plain XML
    cl_demo_output=>begin_section( 'Plain XML' ).
    cl_demo_output=>display_xml( xml ).

    "JSON
    cl_demo_output=>begin_section( 'JSON' ).
    cl_demo_output=>display_json( json ).

    "Plain HTML
    cl_demo_output=>begin_section( 'Formatted HTML' ).
    cl_demo_output=>line( ).
    cl_demo_output=>write_html( `<b>bold</b>, <i>italic</i>, <b><i>bold italic </i></b>` ).
    cl_demo_output=>display_html( `<table border> ` &&
                                  `<tr><td>11</td><td>12</td></tr> ` &&
                                  `<tr><td>21</td><td>22</td></tr> ` &&
                                  `</table>` ).

    "Those are not yet supported
    cl_demo_output=>begin_section( 'References and Complex Types' ).
    cl_demo_output=>write_data( dref ).
    cl_demo_output=>write_data( nested_struct ).
    cl_demo_output=>write_data( deep_struct ).
    cl_demo_output=>display_data( table_struct ).

  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
