REPORT demo_regex.

DATA: text   TYPE c LENGTH 120,
      regx   TYPE c LENGTH 120,
      first  TYPE c LENGTH 1 VALUE 'X',
      all    TYPE c LENGTH 1,
      nocase TYPE c LENGTH 1 VALUE 'X',
      case   TYPE c LENGTH 1,
      docu   TYPE REF TO cl_gui_control.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
  PRIVATE SECTION.
    CLASS-DATA: result_area TYPE REF TO cl_gui_custom_container,
                result_view TYPE REF TO cl_gui_html_viewer,
                result_wa   TYPE string.
    CONSTANTS   repl TYPE string
                     VALUE `@@tgl@@$0@@tgr@@`.
    CLASS-METHODS: display,
                   append_text IMPORTING value(text) TYPE string
                               CHANGING  html        TYPE w3_htmltab.

ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.

    text = `Cathy's cat with the hat sat on Matt's mat.`.
    regx = '(.AT)|(\<.at\>)'.

    DO.

      TRY.

          result_wa = text.

          IF first = 'X' AND nocase = 'X'.
            REPLACE FIRST OCCURRENCE OF REGEX regx IN result_wa
                    WITH repl
                    IGNORING CASE.
          ELSEIF all = 'X' AND nocase = 'X'.
            REPLACE ALL OCCURRENCES OF REGEX regx IN result_wa
                    WITH repl
                    IGNORING CASE.
          ELSEIF first = 'X' AND case = 'X'.
            REPLACE FIRST OCCURRENCE OF REGEX regx IN result_wa
                    WITH repl
                    RESPECTING CASE.
          ELSEIF all = 'X' AND case = 'X'.
            REPLACE ALL OCCURRENCES OF REGEX regx IN result_wa
                    WITH repl
                    RESPECTING CASE.
          ENDIF.

        CATCH cx_sy_regex.

          MESSAGE 'Invalid Regular Expression' TYPE 'S'
                                               DISPLAY LIKE 'E'.
          CLEAR result_wa.

        CATCH cx_sy_regex_too_complex.

          MESSAGE 'Regular Expression too Complex' TYPE 'S'
                                                   DISPLAY LIKE 'E'.
          CLEAR result_wa.

      ENDTRY.

      display( ).

    ENDDO.

  ENDMETHOD.

  METHOD display.

    DATA: result_html TYPE w3_htmltab,
          url         TYPE c LENGTH 255.

    IF result_area IS INITIAL.
      CREATE OBJECT: result_area EXPORTING container_name = 'RESULT',
                     result_view EXPORTING parent = result_area.
    ENDIF.

    "Prepare result for HTML browser
    result_wa = escape( val    = result_wa
                        format = cl_abap_format=>e_html_attr_dq ).
    REPLACE ALL OCCURRENCES OF:
      '@@tgl@@' IN result_wa WITH '<font color="#FF0000"><b>',
      '@@tgr@@' IN result_wa WITH '</b></font>'.

    CLEAR result_html.
    APPEND '<html><body>'   TO result_html.
    append_text(
      EXPORTING text = result_wa
      CHANGING  html   = result_html ).
    APPEND '</body></html>' TO result_html.

    result_view->load_data( IMPORTING assigned_url = url
                            CHANGING  data_table   = result_html ).
    result_view->show_url( url = url ).

    CALL SCREEN 100.

    IF sy-ucomm = 'DEMO'.
      SUBMIT demo_regex_toy.
    ELSEIF sy-ucomm = 'DOCU'.
      cl_abap_docu=>show(
        EXPORTING
          area           = 'ABEN'
          name           = 'REGEX_SYNTAX'
        IMPORTING
          docu_container =  docu ).
    ENDIF.

  ENDMETHOD.
  METHOD append_text.

    DATA: html_line TYPE w3html,
          length    TYPE i,
          pos       TYPE i.

    DESCRIBE FIELD html_line LENGTH length IN CHARACTER MODE.
    pos = strlen( text ).
    WHILE pos > length.
      APPEND text(length) TO html.
      SHIFT text LEFT BY length PLACES.
      SUBTRACT length FROM pos.
    ENDWHILE.
    APPEND text TO html.

  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).

MODULE status_0100 OUTPUT.
  SET TITLEBAR  'TITLE_100'.
  SET PF-STATUS 'SCREEN_100'.
  SET CURSOR FIELD 'RES'.
  IF NOT docu IS INITIAL.
    cl_gui_control=>set_focus(
      EXPORTING
        control = docu ).
    CLEAR docu.
  ENDIF.
ENDMODULE.

MODULE cancel INPUT.
  LEAVE PROGRAM.
ENDMODULE.
