REPORT demo_dynpro_tabcont_loop_at.

CONTROLS flights TYPE TABLEVIEW USING SCREEN 100.
DATA: cols LIKE LINE OF flights-cols,
      lines TYPE i.

DATA: ok_code TYPE sy-ucomm,
      save_ok TYPE sy-ucomm.

DATA: itab TYPE TABLE OF demo_conn.
TABLES demo_conn.

SELECT *
       FROM spfli
       INTO CORRESPONDING FIELDS OF TABLE @itab
       ##TOO_MANY_ITAB_FIELDS.

LOOP AT flights-cols INTO cols WHERE index GT 2.
  cols-screen-input = '0'.
  MODIFY flights-cols FROM cols INDEX sy-tabix.
ENDLOOP.

CALL SCREEN 100.

MODULE status_0100 OUTPUT.
  SET PF-STATUS 'SCREEN_100'.
  DESCRIBE TABLE itab LINES lines.
  flights-lines = lines.
ENDMODULE.

MODULE cancel INPUT.
  LEAVE PROGRAM.
ENDMODULE.

MODULE read_table_control INPUT.
  MODIFY itab FROM demo_conn INDEX flights-current_line.
ENDMODULE.

MODULE user_command_0100 INPUT.
  save_ok = ok_code.
  CLEAR ok_code.
  CASE save_ok.
    WHEN 'TOGGLE'.
      LOOP AT flights-cols INTO cols WHERE index GT 2.
        IF  cols-screen-input = '0'.
          cols-screen-input = '1'.
        ELSEIF  cols-screen-input = '1'.
          cols-screen-input = '0'.
        ENDIF.
        MODIFY flights-cols FROM cols INDEX sy-tabix.
      ENDLOOP.
    WHEN 'SORT_UP'.
      READ TABLE flights-cols INTO cols WITH KEY selected = 'X'.
      IF sy-subrc = 0.
        SORT itab STABLE BY (cols-screen-name+10) ASCENDING.
        cols-selected = ' '.
        MODIFY flights-cols FROM cols INDEX sy-tabix.
      ENDIF.
    WHEN 'SORT_DOWN'.
      READ TABLE flights-cols INTO cols WITH KEY selected = 'X'.
      IF sy-subrc = 0.
        SORT itab STABLE BY (cols-screen-name+10) DESCENDING.
        cols-selected = ' '.
        MODIFY flights-cols FROM cols INDEX sy-tabix.
      ENDIF.
    WHEN 'DELETE'.
      READ TABLE flights-cols INTO cols WITH KEY screen-input = '1'.
      IF sy-subrc = 0.
        LOOP AT itab INTO demo_conn WHERE mark = 'X'.
          DELETE itab.
        ENDLOOP.
      ENDIF.
  ENDCASE.
ENDMODULE.
