REPORT regex_toy.

CONSTANTS: line_len TYPE i VALUE 80,
           marker   TYPE string VALUE `@@tgl@@$0@@tgr@@`.

TYPES: textline TYPE c LENGTH line_len.

DATA: regex    TYPE c LENGTH 255,
      new      TYPE c LENGTH 255,
      opfind   TYPE c LENGTH 1 VALUE 'X',
      in_table TYPE c LENGTH 1 VALUE ' ',
      oprepl   TYPE c LENGTH 1,
      opmatch  TYPE c LENGTH 1,
      first    TYPE c LENGTH 1 VALUE 'X',
      all      TYPE c LENGTH 1,
      nocase   TYPE c LENGTH 1 VALUE 'X',
      case     TYPE c LENGTH 1,
      sub1     TYPE c LENGTH 80,
      sub2     TYPE c LENGTH 80,
      sub3     TYPE c LENGTH 80,
      sub4     TYPE c LENGTH 80,
      sub5     TYPE c LENGTH 80,
      sub6     TYPE c LENGTH 80,
      docu     TYPE REF TO cl_gui_control.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS: main, init.
  PRIVATE SECTION.
    CLASS-DATA: result_area TYPE REF TO cl_gui_custom_container,
                result_view TYPE REF TO cl_gui_html_viewer,
                result_it   TYPE TABLE OF string,
                text_area   TYPE REF TO cl_gui_custom_container,
                text_view   TYPE REF TO cl_gui_textedit,
                text_wa     TYPE string,
                crlf        TYPE string.
    CLASS-METHODS display.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD init.
    crlf = |\r\n|.
    CONCATENATE
      `Cathy's black cat, fast asleep on the mat,`
      `dreamt that a bat was stuck in Matt's hat.`
      `And being a fat but cute little cat`
      `she smacked the poor bat quite thoroughly flat.`
      INTO text_wa SEPARATED BY crlf.
    regex = '.'.
    CLEAR new.

    CREATE OBJECT: result_area EXPORTING container_name = 'RESULT',
                   result_view EXPORTING parent = result_area,
                   text_area   EXPORTING container_name = 'TEXT',
                   text_view   EXPORTING parent = text_area
                                         wordwrap_mode = cl_gui_textedit=>wordwrap_at_fixed_position
                                         wordwrap_position = line_len
                                         wordwrap_to_linebreak_mode = cl_gui_textedit=>true.
    text_view->set_textstream( text = text_wa ).
    text_view->set_statusbar_mode( statusbar_mode = cl_gui_textedit=>false ).
    text_view->set_toolbar_mode( toolbar_mode = cl_gui_textedit=>false ).
  ENDMETHOD.

  METHOD main.
    DATA: new_marked TYPE string,
          pattern    TYPE string.
    DO.
      text_view->get_textstream( IMPORTING text = text_wa ).
      cl_gui_cfw=>flush( ).  " update text_wa from control
      SPLIT text_wa AT crlf INTO TABLE result_it.
      new_marked = marker.
      IF oprepl = 'X'.
        REPLACE '$0' IN new_marked WITH new.
      ENDIF.
      IF opmatch = 'X'.
        CONCATENATE '^' regex '$' INTO pattern.
      ELSE.
        pattern = regex.
      ENDIF.
      CLEAR: sub1, sub2, sub3, sub4, sub5, sub6.

      TRY.
          IF in_table = 'X'.
            IF nocase = 'X'.
              FIND REGEX pattern IN TABLE result_it IGNORING CASE
                   SUBMATCHES sub1 sub2 sub3 sub4 sub5 sub6.
              IF first = 'X'.
                REPLACE REGEX pattern IN TABLE result_it
                        WITH new_marked IGNORING CASE.
              ELSE. " all = 'X'
                REPLACE ALL OCCURRENCES OF REGEX pattern IN TABLE result_it
                        WITH new_marked IGNORING CASE.
              ENDIF.
            ELSE. " case = 'X'
              FIND REGEX pattern IN TABLE result_it
                   SUBMATCHES sub1 sub2 sub3 sub4 sub5 sub6.
              IF first = 'X'.
                REPLACE REGEX pattern IN TABLE result_it
                        WITH new_marked.
              ELSE. " all = 'X'
                REPLACE ALL OCCURRENCES OF REGEX pattern IN TABLE result_it
                        WITH new_marked.
              ENDIF.
            ENDIF.
          ELSE.
            DATA(result_string) = concat_lines_of( table = result_it sep = |\n| ).
            REPLACE ALL OCCURRENCES OF | \n| in result_string with |\n|.
            REPLACE ALL OCCURRENCES OF |\n| in result_string with | |.
            IF nocase = 'X'.
              FIND REGEX pattern IN result_string IGNORING CASE
                   SUBMATCHES sub1 sub2 sub3 sub4 sub5 sub6.
              IF first = 'X'.
                REPLACE REGEX pattern IN result_string
                        WITH new_marked IGNORING CASE.
              ELSE. " all = 'X'
                REPLACE ALL OCCURRENCES OF REGEX pattern IN result_string
                        WITH new_marked IGNORING CASE.
              ENDIF.
            ELSE. " case = 'X'
              FIND REGEX pattern IN result_string
                   SUBMATCHES sub1 sub2 sub3 sub4 sub5 sub6.
              IF first = 'X'.
                REPLACE REGEX pattern IN result_string
                        WITH new_marked.
              ELSE. " all = 'X'
                REPLACE ALL OCCURRENCES OF REGEX pattern IN result_string
                        WITH new_marked.
              ENDIF.
            ENDIF.
            result_it = VALUE #( ( result_string ) ).
          ENDIF.
          IF sy-subrc = 0.
            MESSAGE 'Match(es) found' TYPE 'S' DISPLAY LIKE 'S'.
          ELSE.
            MESSAGE 'No match(es) found' TYPE 'S' DISPLAY LIKE 'W'.
          ENDIF.
        CATCH cx_sy_regex.
          MESSAGE 'Invalid regular expression' TYPE 'S' DISPLAY LIKE 'E'.
          CLEAR result_it.
        CATCH cx_sy_regex_too_complex.
          MESSAGE 'Regular expression too complex' TYPE 'S' DISPLAY LIKE 'E'.
          CLEAR result_it.
        CATCH cx_sy_invalid_regex_format.
          MESSAGE 'Invalid replacement pattern' TYPE 'S' DISPLAY LIKE 'E'.
          CLEAR result_it.
      ENDTRY.
      display( ).
    ENDDO.
  ENDMETHOD.

  METHOD display.
    CONSTANTS linesize TYPE i VALUE 255.
    DATA: result_html TYPE TABLE OF w3_html,
          result_wa   LIKE LINE OF result_it,
          url         TYPE c LENGTH 255,
          n           TYPE i.

    REPLACE ALL OCCURRENCES OF:    "Prepare result for HTML browser
      '&'       IN TABLE result_it WITH '&amp;',
      '"'       IN TABLE result_it WITH '&quot;',
      '<'       IN TABLE result_it WITH '&lt;',
      '>'       IN TABLE result_it WITH '&gt;',
      ` `       IN TABLE result_it WITH COND string( WHEN in_table IS NOT INITIAL  THEN `&nbsp;` ELSE ` ` ),
      '@@tgl@@' IN TABLE result_it WITH '<font color="#FF0000"><b>',
      '@@tgr@@' IN TABLE result_it WITH '</b></font>'.

    CLEAR result_html.
    APPEND '<html><body><font face="Arial monospaced for SAP, Courier New" size="-1">' TO result_html.
    CONCATENATE LINES OF result_it INTO result_wa SEPARATED BY '<br/>'.
    n = strlen( result_wa ).
    WHILE n > linesize.
      APPEND result_wa(linesize) TO result_html.
      SHIFT result_wa LEFT BY linesize PLACES.
      SUBTRACT linesize FROM n.
    ENDWHILE.
    APPEND result_wa TO result_html.
    APPEND '</font></body></html>' TO result_html.
    result_view->load_data( IMPORTING assigned_url = url
                            CHANGING  data_table   = result_html ).
    result_view->show_url( url = url ).


    CALL SCREEN 100.

    IF sy-ucomm = 'DOCU'.
      cl_abap_docu=>show(
        EXPORTING
          area           = 'ABEN'
          name           = 'REGEX_SYNTAX'
        IMPORTING
          docu_container =  docu ).
    ENDIF.

  ENDMETHOD.
ENDCLASS.

*----------------------------------------------------------------------*

START-OF-SELECTION.
  demo=>init( ).
  demo=>main( ).

*----------------------------------------------------------------------*

MODULE status_0100 OUTPUT.
  SET TITLEBAR  'TITLE_100'.
  SET PF-STATUS 'SCREEN_100'.
  IF NOT docu IS INITIAL.
    CALL METHOD cl_gui_control=>set_focus
      EXPORTING
        control = docu.
    CLEAR docu.
  ENDIF.
ENDMODULE.
*
MODULE cancel INPUT.
  LEAVE PROGRAM.
ENDMODULE.
