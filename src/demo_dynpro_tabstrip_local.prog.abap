REPORT demo_dynpro_tabstrip_local.

CONTROLS mytabstrip TYPE TABSTRIP.

DATA: ok_code TYPE sy-ucomm,
      save_ok TYPE sy-ucomm.

mytabstrip-activetab = 'PUSH2'.

CALL SCREEN 100.

MODULE status_0100 OUTPUT.
  SET PF-STATUS 'SCREEN_100'.
ENDMODULE.

MODULE cancel INPUT.
  LEAVE PROGRAM.
ENDMODULE.

MODULE user_command INPUT.
  save_ok = ok_code.
  CLEAR ok_code.
  IF save_ok = 'OK'.
    MESSAGE i888(sabapdemos) WITH 'MYTABSTRIP-ACTIVETAB ='
                                  mytabstrip-activetab.
  ENDIF.
ENDMODULE.
