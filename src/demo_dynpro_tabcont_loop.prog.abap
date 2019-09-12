REPORT demo_dynpro_tabcont_loop.

CONTROLS flights TYPE TABLEVIEW USING SCREEN 100.

DATA: ok_code TYPE sy-ucomm,
      save_ok TYPE sy-ucomm.

DATA: itab TYPE TABLE OF demo_conn,
      fill TYPE i.
TABLES demo_conn.

DATA: lines TYPE i,
      limit TYPE i.

SELECT *
       FROM spfli
       INTO CORRESPONDING FIELDS OF TABLE @itab
       ##too_many_itab_fields.

CALL SCREEN 100.

MODULE status_0100 OUTPUT.
  SET PF-STATUS 'SCREEN_100'.
  DESCRIBE TABLE itab LINES fill.
  flights-lines = fill.
ENDMODULE.

MODULE fill_table_control OUTPUT.
  TRY.
      demo_conn = itab[ flights-current_line ].
    CATCH cx_sy_itab_line_not_found.
      RETURN.
  ENDTRY.
ENDMODULE.

MODULE cancel INPUT.
  LEAVE PROGRAM.
ENDMODULE.

MODULE read_table_control INPUT.
  lines = sy-loopc.
  MODIFY itab FROM demo_conn INDEX flights-current_line.
ENDMODULE.

MODULE user_command_0100 INPUT.
  save_ok = ok_code.
  CLEAR ok_code.
  CASE save_ok.
    WHEN 'NEXT_LINE'.
      flights-top_line = flights-top_line + 1.
      limit = fill - lines + 1.
      IF flights-top_line > limit.
        flights-top_line = limit.
      ENDIF.
    WHEN 'PREV_LINE'.
      flights-top_line = flights-top_line - 1.
      IF flights-top_line < 0.
        flights-top_line = 0.
      ENDIF.
    WHEN 'NEXT_PAGE'.
      flights-top_line = flights-top_line + lines.
      limit = fill - lines + 1.
      IF flights-top_line > limit.
        flights-top_line = limit.
      ENDIF.
    WHEN 'PREV_PAGE'.
      flights-top_line = flights-top_line - lines.
      IF flights-top_line < 0.
        flights-top_line = 0.
      ENDIF.
    WHEN 'LAST_PAGE'.
      flights-top_line =  fill - lines + 1.
    WHEN 'FIRST_PAGE'.
      flights-top_line = 0.
  ENDCASE.
ENDMODULE.
