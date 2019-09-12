REPORT demo_usage_output_stream.

PARAMETERS: p_xml AS CHECKBOX DEFAULT abap_true,
            p_out AS CHECKBOX DEFAULT abap_false.
SELECTION-SCREEN ULINE.
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

    "Stream
    DATA oref TYPE REF TO cl_demo_output_stream.
    DATA output_stream TYPE xstring.

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

    "Open stream
    oref = cl_demo_output_stream=>open( ).
    IF p_out = abap_true.
      IF p_html = abap_true.
        SET HANDLER cl_demo_output_html=>handle_output FOR oref.
        cl_demo_output_html=>set_display( abap_true ).
      ELSEIF p_text = abap_true.
        SET HANDLER cl_demo_output_text=>handle_output FOR oref.
        cl_demo_output_text=>set_display( abap_true ).
      ENDIF.
    ENDIF.

    "Some text
    oref->write_text( iv_text = 'Text Output'
                      iv_format = if_demo_output_formats=>heading
                      iv_level  = 1 ).
    oref->write_text( iv_text = 'Title, Level 2'
                      iv_format = if_demo_output_formats=>heading
                      iv_level  = 2 ).
    oref->write_text( iv_text = 'Title, Level 3'
                      iv_format = if_demo_output_formats=>heading
                      iv_level  = 3 ).
    oref->write_text( iv_text = 'Title, Level 4'
                      iv_format = if_demo_output_formats=>heading
                      iv_level  = 4 ).
    oref->write_text( |The value of int is { int }| ).
    oref->write_text( iv_text = |Non proportional text with blanks      ...|
                      iv_format = if_demo_output_formats=>nonprop ).
    oref->write_text( iv_text = |Text with\nlinebreak,\nlinebreak,\nlinebreak ... | ).
    oref->write_text( iv_text = |Handmade table:\n| &&
                                |{ `field11` WIDTH = 20 }{ `field12` WIDTH = 20 }\n| &&
                                |{ `field21` WIDTH = 20 }{ `field22` WIDTH = 20 }\n| &&
                                |{ `field31` WIDTH = 20 }{ `field32` WIDTH = 20 }\n|
                      iv_format = if_demo_output_formats=>nonprop ).
    oref->write_text( iv_text = |Linebreaks and tabs:\n| &&
                                |First line.\r\ttab\ttab\ttab\n\ttab\ttab\ttab\rLast line.|
                      iv_format = if_demo_output_formats=>nonprop ).


    "Some data
    oref->write_text( iv_text = 'Data Output'
                      iv_format = if_demo_output_formats=>heading
                      iv_level  = 1 ).

    oref->write_text( iv_text = 'Literals'
                      iv_format = if_demo_output_formats=>heading
                      iv_level  = 4 ).
    oref->write_data( -555 ).
    oref->write_data( 'literal text' ).

    oref->write_text( iv_text = 'Elementary Fields'
                      iv_format = if_demo_output_formats=>heading
                      iv_level  = 4 ).
    oref->write_data( int ).
    oref->write_data( pack ).
    oref->write_data( decf ).
    oref->write_data( text ).
    oref->write_data( date ).
    oref->write_data( time ).
    oref->write_data( hex ).
    oref->write_data( one_struct-comp ).

    oref->write_text( iv_text = 'Structures'
                      iv_format = if_demo_output_formats=>heading
                      iv_level  = 4 ).
    oref->write_data( ia_value = one_struct ).
    oref->write_data( flat_struct ).
    oref->write_data( nested_struct-comp ).
    oref->write_data( ia_value  = table_struct-comp ).

    oref->write_text( iv_text = 'Tables'
                      iv_format = if_demo_output_formats=>heading
                      iv_level  = 4 ).
    oref->write_data( array ).
    oref->write_data( table ).
    oref->write_data( demo_spfli=>get( ) ).

    IF p_text IS INITIAL.
      oref->write_text( iv_text = 'Non-proportional Display of Table'
                        iv_format = if_demo_output_formats=>heading
                        iv_level  = 4 ).
      oref->write_data( ia_value = list
                        iv_format = if_demo_output_formats=>nonprop ).
    ENDIF.

    oref->write_text( iv_text = 'Plain XML'
                      iv_format = if_demo_output_formats=>heading
                      iv_level  = 1 ).
    oref->write_xml( xml ).

    oref->write_text( iv_text = 'JSON'
                      iv_format = if_demo_output_formats=>heading
                      iv_level  = 1 ).
    oref->write_json( iv_xjson = json ).


    oref->write_text( iv_text = 'Formatted HTML'
                      iv_format = if_demo_output_formats=>heading
                      iv_level  = 1 ).
    oref->write_html( `<hr>` ).
    oref->write_html( `<b>bold</b>, <i>italic</i>, <b><i>bold italic </i></b>` ).
    oref->write_html( `<table border> ` &&
                      `<tr><td>11</td><td>12</td></tr> ` &&
                      `<tr><td>21</td><td>22</td></tr> ` &&
                      `</table>` ).

    oref->write_text( iv_text = 'References and Complex Types'
                      iv_format = if_demo_output_formats=>heading
                      iv_level  = 1 ).
    "Those are not yet supported
    oref->write_data( dref ).
    oref->write_data( nested_struct ).
    oref->write_data( deep_struct ).
    oref->write_data( table_struct ).

    "Close stream
    output_stream = oref->close( ).

    "Show XML-file
    IF p_xml = abap_true.
      cl_abap_browser=>show_xml(
        EXPORTING
          xml_xstring  = output_stream ).
    ENDIF.

  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
