*&---------------------------------------------------------------------*
*& Report  S_SCREEN_PAINTER_DEMO                                       *
*&---------------------------------------------------------------------*


REPORT s_screen_painter_demo.

*----------------------------------------------------------------------
* Global data declarations
*----------------------------------------------------------------------
CONTROLS: tabcon TYPE TABLEVIEW USING SCREEN 0100.
CONTROLS: ts TYPE TABSTRIP.

DATA:     g_tabcon_lines  LIKE sy-loopc.


DATA: input(22) TYPE c,
      check1(1) TYPE c,
      check2(1) TYPE c,
      radio1(1) TYPE c,
      radio2(1) TYPE c,
      radio3(1) TYPE c,
      radio4(1) TYPE c,
      ok_code   TYPE sy-ucomm,
      save_ok   TYPE sy-ucomm.

DATA: BEGIN OF tc_line,
       flag(1),
       sp1(10),
       sp2(10),
       sp3(10),
       sp4(10),
      END OF tc_line.

DATA tcon LIKE TABLE OF tc_line WITH HEADER LINE.
DATA html TYPE REF TO cl_gui_html_viewer.
DATA container TYPE REF TO cl_gui_custom_container.

* Classes

CLASS screen_100 DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS handle_push_button.
ENDCLASS.

*

CLASS screen_100 IMPLEMENTATION.
  METHOD handle_push_button.
    MESSAGE i888(sabapdemos) WITH text-010.
    SET SCREEN 100.
  ENDMETHOD.
ENDCLASS.

*----------------------------------------------------------------------
* Processing blocks
*----------------------------------------------------------------------

START-OF-SELECTION.
  CALL SCREEN 100.

* PBO modules

MODULE status_0100 OUTPUT.
  SET TITLEBAR  'TIT_100'.
  SET PF-STATUS 'SCREEN_100'.
  input = 'Eingabefeld'.
  CREATE OBJECT container
    EXPORTING
      container_name = 'CUSTOM_AREA'.
  CREATE OBJECT html
    EXPORTING
      parent = container.
  CALL METHOD html->show_url
    EXPORTING
      url = 'http://www.sap.com'.

ENDMODULE.

* PAI modules

MODULE user_command_0100 INPUT.
  save_ok = ok_code.
  CLEAR ok_code.
  CASE save_ok.
    WHEN 'BACK'.
      ...
    WHEN 'EXIT'.
      LEAVE PROGRAM.
    WHEN 'CANCEL'.
      LEAVE SCREEN.
    WHEN 'PRESS'.
      CALL METHOD screen_100=>handle_push_button.
  ENDCASE.
ENDMODULE.

* Callback routine for context menu

FORM on_ctmenu_input USING l_menu TYPE REF TO cl_ctmenu.
  CALL METHOD l_menu->add_function
    EXPORTING
      fcode = 'PRESS'
      text  = text-020.
ENDFORM.

* Dialog Modules

MODULE tabcon_change_tc_attr OUTPUT.
  DESCRIBE TABLE tcon LINES tabcon-lines.
ENDMODULE.

MODULE tabcon_get_lines OUTPUT.
  g_tabcon_lines = sy-loopc.
ENDMODULE.

MODULE tabcon_modify INPUT.
  MODIFY tcon
    INDEX tabcon-current_line.
ENDMODULE.

MODULE tabcon_mark INPUT.
  MODIFY tcon
    INDEX tabcon-current_line
    TRANSPORTING flag.
ENDMODULE.

MODULE tabcon_user_command INPUT.
  PERFORM user_ok_tc USING    'TABCON'
                              'TCON'
                              'FLAG'
                     CHANGING ok_code.
ENDMODULE.

*Table Control Forms

FORM user_ok_tc USING    p_tc_name TYPE dynfnam
                         p_table_name
                         p_mark_name
                CHANGING p_ok      LIKE sy-ucomm.

  DATA: l_ok              TYPE sy-ucomm,
        l_offset          TYPE i.
  SEARCH p_ok FOR p_tc_name.
  IF sy-subrc <> 0.
    EXIT.
  ENDIF.
  l_offset = STRLEN( p_tc_name ) + 1.
  l_ok = p_ok+l_offset.
  CASE l_ok.
    WHEN 'INSR'.                      "insert row
      PERFORM fcode_insert_row USING    p_tc_name
                                        p_table_name.
      CLEAR p_ok.

    WHEN 'DELE'.                      "delete row
      PERFORM fcode_delete_row USING    p_tc_name
                                        p_table_name
                                        p_mark_name.
      CLEAR p_ok.

    WHEN 'P--' OR                     "top of list
         'P-'  OR                     "previous page
         'P+'  OR                     "next page
         'P++'.                       "bottom of list
      PERFORM compute_scrolling_in_tc USING p_tc_name
                                            l_ok.
      CLEAR p_ok.
    WHEN 'MARK'.                      "mark all filled lines
      PERFORM fcode_tc_mark_lines USING p_tc_name
                                        p_table_name
                                        p_mark_name   .
      CLEAR p_ok.

    WHEN 'DMRK'.                      "demark all filled lines
      PERFORM fcode_tc_demark_lines USING p_tc_name
                                          p_table_name
                                          p_mark_name .
      CLEAR p_ok.


  ENDCASE.

ENDFORM.                              " USER_OK_TC

FORM fcode_insert_row
              USING    p_tc_name           TYPE dynfnam
                       p_table_name             .

  DATA l_lines_name       LIKE feld-name.
  DATA l_selline          LIKE sy-stepl.
  DATA l_lastline         TYPE i.
  DATA l_line             TYPE i.
  DATA l_table_name       LIKE feld-name.
  FIELD-SYMBOLS <tc>                 TYPE cxtab_control.
  FIELD-SYMBOLS <table>              TYPE STANDARD TABLE.
  FIELD-SYMBOLS <lines>              TYPE i.

  ASSIGN (p_tc_name) TO <tc>.

  l_table_name = p_table_name && '[]'. "table body
  ASSIGN (l_table_name) TO <table>.    "not headerline

  l_lines_name = 'G_' && p_tc_name && '_LINES'.
  ASSIGN (l_lines_name) TO <lines>.

  GET CURSOR LINE l_selline.
  IF sy-subrc <> 0.                   " append line to table
    l_selline = <tc>-lines + 1.
    IF l_selline > <lines>.
      <tc>-top_line = l_selline - <lines> + 1 .
      l_line = 1.
    ELSE.
      <tc>-top_line = 1.
      l_line = l_selline.
    ENDIF.
  ELSE.                               " insert line into table
    l_selline = <tc>-top_line + l_selline - 1.
    l_lastline = l_selline + <lines> - 1.
    IF l_lastline <= <tc>-lines.
      <tc>-top_line = l_selline.
      l_line = 1.
    ELSEIF <lines> > <tc>-lines.
      <tc>-top_line = 1.
      l_line = l_selline.
    ELSE.
      <tc>-top_line = <tc>-lines - <lines> + 2 .
      l_line = l_selline - <tc>-top_line + 1.
    ENDIF.
  ENDIF.
  INSERT INITIAL LINE INTO <table> INDEX l_selline.
  <tc>-lines = <tc>-lines + 1.
  SET CURSOR LINE l_line.

ENDFORM.                              " FCODE_INSERT_ROW

FORM fcode_delete_row
              USING    p_tc_name           TYPE dynfnam
                       p_table_name
                       p_mark_name   .

  DATA l_table_name       LIKE feld-name.

  FIELD-SYMBOLS <tc>         TYPE cxtab_control.
  FIELD-SYMBOLS <table>      TYPE STANDARD TABLE.
  FIELD-SYMBOLS <wa>.
  FIELD-SYMBOLS <mark_field>.

  ASSIGN (p_tc_name) TO <tc>.

  l_table_name = p_table_name && '[]'. "table body
  ASSIGN (l_table_name) TO <table>.                "not headerline

  DESCRIBE TABLE <table> LINES <tc>-lines.

  LOOP AT <table> ASSIGNING <wa>.

    ASSIGN COMPONENT p_mark_name OF STRUCTURE <wa> TO <mark_field>.

    IF <mark_field> = 'X'.
      DELETE <table> INDEX syst-tabix.
      IF sy-subrc = 0.
        <tc>-lines = <tc>-lines - 1.
      ENDIF.
    ENDIF.
  ENDLOOP.

ENDFORM.                              " FCODE_DELETE_ROW

FORM compute_scrolling_in_tc USING    p_tc_name
                                      p_ok.
  DATA l_tc_new_top_line     TYPE i.
  DATA l_tc_name             LIKE feld-name.
  DATA l_tc_lines_name       LIKE feld-name.
  DATA l_tc_field_name       LIKE feld-name.

  FIELD-SYMBOLS <tc>         TYPE cxtab_control.
  FIELD-SYMBOLS <lines>      TYPE i.

  ASSIGN (p_tc_name) TO <tc>.
  l_tc_lines_name = 'G_' && p_tc_name && '_LINES'.
  ASSIGN (l_tc_lines_name) TO <lines>.


  IF <tc>-lines = 0.
    l_tc_new_top_line = 1.
  ELSE.
    CALL FUNCTION 'SCROLLING_IN_TABLE'
      EXPORTING
        entry_act             = <tc>-top_line
        entry_from            = 1
        entry_to              = <tc>-lines
        last_page_full        = 'X'
        loops                 = <lines>
        ok_code               = p_ok
        overlapping           = 'X'
      IMPORTING
        entry_new             = l_tc_new_top_line
      EXCEPTIONS
        no_entry_or_page_act  = 01
        no_entry_to           = 02
        no_ok_code_or_page_go = 03
        OTHERS                = 99.
  ENDIF.

  GET CURSOR FIELD l_tc_field_name
             AREA  l_tc_name.

  IF syst-subrc = 0.
    IF l_tc_name = p_tc_name.
      SET CURSOR FIELD l_tc_field_name LINE 1.
    ENDIF.
  ENDIF.

  <tc>-top_line = l_tc_new_top_line.


ENDFORM.                              " COMPUTE_SCROLLING_IN_TC

FORM fcode_tc_mark_lines USING p_tc_name
                               p_table_name
                               p_mark_name.
  DATA l_table_name       LIKE feld-name.

  FIELD-SYMBOLS <tc>         TYPE cxtab_control.
  FIELD-SYMBOLS <table>      TYPE STANDARD TABLE.
  FIELD-SYMBOLS <wa>.
  FIELD-SYMBOLS <mark_field>.

  ASSIGN (p_tc_name) TO <tc>.

  l_table_name = p_table_name && '[]'. "table body
  ASSIGN (l_table_name) TO <table>.    "not headerline

  LOOP AT <table> ASSIGNING <wa>.

    ASSIGN COMPONENT p_mark_name OF STRUCTURE <wa> TO <mark_field>.

    <mark_field> = 'X'.
  ENDLOOP.
ENDFORM.                                          "fcode_tc_mark_lines

FORM fcode_tc_demark_lines USING p_tc_name
                                 p_table_name
                                 p_mark_name .
  DATA l_table_name       LIKE feld-name.

  FIELD-SYMBOLS <tc>         TYPE cxtab_control.
  FIELD-SYMBOLS <table>      TYPE STANDARD TABLE.
  FIELD-SYMBOLS <wa>.
  FIELD-SYMBOLS <mark_field>.

  ASSIGN (p_tc_name) TO <tc>.

  l_table_name = p_table_name && '[]'. "table body
  ASSIGN (l_table_name) TO <table>.    "not headerline

  LOOP AT <table> ASSIGNING <wa>.

    ASSIGN COMPONENT p_mark_name OF STRUCTURE <wa> TO <mark_field>.

    <mark_field> = space.
  ENDLOOP.
ENDFORM.                                          "fcode_tc_mark_lines
