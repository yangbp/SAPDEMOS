PROGRAM demo_dynpro_at_exit_command .

DATA: ok_code TYPE sy-ucomm,
      save_ok LIKE ok_code,
      input1(20) TYPE c, input2(20) TYPE c.

CALL SCREEN 100.

MODULE init_screen_0100 OUTPUT.
  SET PF-STATUS 'STATUS_100'.
ENDMODULE.

MODULE cancel INPUT.
  MESSAGE i888(sabapdemos) WITH text-001 ok_code input1 input2.
  IF ok_code = 'CANCEL'.
    CLEAR ok_code.
    LEAVE PROGRAM.
  ENDIF.
ENDMODULE.

MODULE back INPUT.
  MESSAGE i888(sabapdemos) WITH text-002 ok_code input1 input2.
  IF ok_code = 'BACK' OR ok_code = 'EXIT'.
    CLEAR: ok_code, input1, input2.
    LEAVE TO SCREEN 100.
  ENDIF.
ENDMODULE.

MODULE execute1 INPUT.
  MESSAGE i888(sabapdemos) WITH text-003 ok_code input1 input2.
  save_ok = ok_code.
  CLEAR ok_code.
ENDMODULE.

MODULE execute2 INPUT.
  MESSAGE i888(sabapdemos) WITH text-004 ok_code input1 input2.
  IF save_ok = 'EXECUTE'.
    MESSAGE s888(sabapdemos) WITH text-005.
  ENDIF.
ENDMODULE.
