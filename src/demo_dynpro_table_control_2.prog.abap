REPORT  demo_dynpro_table_control_2  MESSAGE-ID sabapdemos  .

TYPES: BEGIN OF itab,
         mark,
         col1 TYPE i,
         col2 TYPE i,
       END OF itab.

DATA itab TYPE STANDARD TABLE OF itab WITH HEADER LINE.

DATA  ok_code TYPE sy-ucomm.
DATA  ok_save TYPE sy-ucomm.
DATA tab_lines TYPE i.
DATA step_lines TYPE i.
DATA  offset TYPE i.
DATA c TYPE i.

CONTROLS table TYPE TABLEVIEW USING SCREEN 100.

CALL SCREEN 100.

MODULE init OUTPUT.
  SET PF-STATUS 'BASIC'.
ENDMODULE.

MODULE fill_itab OUTPUT.
  DESCRIBE TABLE itab LINES tab_lines.
  IF tab_lines = 0.
    DO 40 TIMES.
      itab-col1 = sy-index.
      itab-col2 = sy-index ** 2.
      APPEND itab.
    ENDDO.
  ENDIF.
ENDMODULE.

MODULE lines OUTPUT.
  step_lines = sy-loopc.
ENDMODULE.

MODULE exit INPUT.
  LEAVE PROGRAM.
ENDMODULE.

MODULE check_pai INPUT.
  ok_save = ok_code. CLEAR ok_code.
  MESSAGE s888 WITH 'TOP_LINE: ' table-top_line
                    ', LINES: '  step_lines.
ENDMODULE.

MODULE check_table INPUT.
  CASE ok_save.
    WHEN 'MARK'.
      IF itab-mark = 'X'.
        MESSAGE i888 WITH 'Zeile' table-current_line 'markiert'.
      ENDIF.
    WHEN 'SETM'.
      MODIFY itab INDEX table-current_line.
  ENDCASE.
ENDMODULE.

MODULE check_all INPUT.
  CASE ok_save.
    WHEN 'ALLM'.
      LOOP AT itab INTO itab.
        IF itab-mark = 'X'.
          MESSAGE i888 WITH 'Zeile' sy-tabix 'markiert'.
        ENDIF.
      ENDLOOP.
    WHEN 'DELE'.
      LOOP AT itab INTO itab.
        IF itab-mark = 'X'.
          itab-mark = ' '.
          MODIFY itab.
        ENDIF.
      ENDLOOP.
  ENDCASE.

ENDMODULE.

MODULE scroll INPUT.
  CASE ok_save.
    WHEN 'PGDO'.
      offset = table-lines - step_lines.
      IF table-top_line LT offset.
        table-top_line = table-top_line + step_lines.
      ENDIF.
    WHEN 'PGUP'.
      offset = step_lines.
      IF table-top_line GT offset.
        table-top_line = table-top_line - step_lines.
      ELSE.
        table-top_line = 1.
      ENDIF.
    WHEN 'PGLA'.
      table-top_line = table-lines - step_lines + 1.
    WHEN 'PGTO'.
      table-top_line = 1.
  ENDCASE.
ENDMODULE.
