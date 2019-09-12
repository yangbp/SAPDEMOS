PROGRAM demo_dynpro_gui_status.

DATA: ok_code TYPE sy-ucomm,
      save_ok LIKE ok_code,
      output  LIKE ok_code.

CALL SCREEN 100.

MODULE init_screen_0100 OUTPUT.
  SET PF-STATUS 'STATUS_100'.
  SET TITLEBAR '100'.
ENDMODULE.

MODULE user_command_0100 INPUT.
  save_ok = ok_code.
  CLEAR ok_code.
  CASE save_ok.
    WHEN 'BACK' OR 'EXIT' OR 'CANCEL'.
      LEAVE PROGRAM.
    WHEN OTHERS.
      output = save_ok.
  ENDCASE.
ENDMODULE.
