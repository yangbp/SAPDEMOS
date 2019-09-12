REPORT demo_dynpro_tabstrip_server.

CONTROLS mytabstrip TYPE TABSTRIP.

DATA: ok_code TYPE sy-ucomm,
      save_ok TYPE sy-ucomm.

DATA  number TYPE sy-dynnr.

mytabstrip-activetab = 'PUSH2'.
number = '0120'.

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
  ELSE.
    mytabstrip-activetab = save_ok.
    CASE save_ok.
      WHEN 'PUSH1'.
        number = '0110'.
      WHEN 'PUSH2'.
        number = '0120'.
      WHEN 'PUSH3'.
        number = '0130'.
    ENDCASE.
  ENDIF.
ENDMODULE.
