REPORT demo_dynpro_modify_simple .

DATA: ok_code TYPE sy-ucomm,
      save_ok TYPE sy-ucomm.

DATA flag(1) TYPE c.

CALL SCREEN 100.

MODULE status_0100 OUTPUT.
  SET PF-STATUS 'SCREEN_100'.
  LOOP AT SCREEN INTO DATA(screen_wa).
    IF screen_wa-group1 = 'MOD'.
      IF flag = ' '.
        screen_wa-input = '0'.
      ELSEIF flag = 'X'.
        screen_wa-input = '1'.
      ENDIF.
      MODIFY SCREEN FROM screen_wa.
    ENDIF.
  ENDLOOP.
ENDMODULE.

MODULE cancel.
  LEAVE PROGRAM.
ENDMODULE.

MODULE user_command_0100 INPUT.
  save_ok = ok_code.
  CLEAR ok_code.
  CASE save_ok.
    WHEN 'TOGGLE'.
      IF flag = ' '.
        flag = 'X'.
      ELSEIF flag = 'X'.
        flag = ' '.
      ENDIF.
  ENDCASE.
ENDMODULE.
