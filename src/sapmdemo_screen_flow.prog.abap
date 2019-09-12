PROGRAM sapmdemo_screen_flow MESSAGE-ID demo_flight.

TABLES: spfli,
        sairport,
        scarr.

DATA: ok_code   TYPE c LENGTH 4,
      rcode     TYPE c LENGTH 5,
      old_spfli TYPE spfli.

* PBO

MODULE status_0100 OUTPUT.
  SET PF-STATUS 'TD0100'.
  SET TITLEBAR '100'.
ENDMODULE.

MODULE status_0200 OUTPUT.
  SET PF-STATUS 'TD0200'.
  SET TITLEBAR '100'.
ENDMODULE.

MODULE status_0210 OUTPUT.
  SET PF-STATUS 'POPUP'.
  SET TITLEBAR 'POP'.
ENDMODULE.

* PAI

MODULE user_command_0100 INPUT.
  CASE ok_code.
    WHEN space.
      SELECT SINGLE *
             FROM  spfli
             WHERE carrid      = @spfli-carrid
             AND   connid      = @spfli-connid
             INTO  @spfli.
      IF sy-subrc NE 0.
        MESSAGE e005 WITH spfli-carrid spfli-connid.
      ENDIF.
      old_spfli = spfli.
      CLEAR ok_code.
    WHEN 'CANC'.
      CLEAR ok_code.
      SET SCREEN 0. LEAVE SCREEN.
    WHEN 'EXIT'.
      CLEAR ok_code.
      SET SCREEN 0. LEAVE SCREEN.
    WHEN 'BACK'.
      CLEAR ok_code.
      SET SCREEN 0. LEAVE SCREEN.
  ENDCASE.
ENDMODULE.

MODULE user_command_0200 INPUT.
  CASE ok_code.
    WHEN 'SAVE'.
      UPDATE spfli.
      IF sy-subrc = 0.
        MESSAGE s001 WITH spfli-carrid spfli-connid.
      ELSE.
        MESSAGE a002 WITH spfli-carrid spfli-connid.
      ENDIF.
      CLEAR ok_code.
    WHEN 'EXIT'.
      CLEAR ok_code.
      PERFORM safety_check USING rcode.
      IF rcode = 'EXIT'. SET SCREEN 0. LEAVE SCREEN. ENDIF.
    WHEN 'BACK'.
      CLEAR ok_code.
      PERFORM safety_check USING rcode.
      IF rcode = 'EXIT'. SET SCREEN 100. LEAVE SCREEN. ENDIF.
    WHEN 'DELE'.
      MESSAGE w011.
      DELETE FROM spfli
        WHERE carrid = @spfli-carrid
        AND connid = @spfli-connid.
  ENDCASE.
ENDMODULE.

MODULE check_fr_airport INPUT.
  SELECT SINGLE *
         FROM  sairport
         WHERE id = @spfli-airpfrom
         INTO  @sairport.
  IF sy-subrc <> 0.
    MESSAGE e003 WITH spfli-airpfrom.
  ENDIF.
ENDMODULE.

MODULE check_to_airport INPUT.
  SELECT SINGLE *
         FROM  sairport
         WHERE id = @spfli-airpto
         INTO  @sairport.
  IF sy-subrc <> 0.
    MESSAGE e004 WITH spfli-airpto.
  ENDIF.
ENDMODULE.

MODULE exit_0100 INPUT.
  CASE ok_code.
    WHEN 'CANC'.
      CLEAR ok_code.
      SET SCREEN 0. LEAVE SCREEN.
    WHEN 'EXIT'.
      CLEAR ok_code.
      SET SCREEN 0. LEAVE SCREEN.
    WHEN 'BACK'.
      CLEAR ok_code.
      SET SCREEN 0. LEAVE SCREEN.
  ENDCASE.
ENDMODULE.

MODULE exit_0200 INPUT.
  CASE ok_code.
    WHEN 'CANC'.
      CLEAR ok_code.
      SET SCREEN 100. LEAVE SCREEN.
  ENDCASE.
ENDMODULE.

MODULE user_command_0210 INPUT.
  CASE ok_code.
    WHEN 'SAVE'. SET SCREEN 0. LEAVE SCREEN.
    WHEN 'EXIT'. SET SCREEN 0. LEAVE SCREEN.
    WHEN 'CANC'. SET SCREEN 0. LEAVE SCREEN.
  ENDCASE.
ENDMODULE.

MODULE read_text_0100 INPUT.
  SELECT SINGLE *
         FROM scarr
         WHERE carrid = @spfli-carrid
         INTO @scarr.
ENDMODULE.

* Subroutine

FORM safety_check USING rcode.
  LOCAL ok_code.
  rcode = 'EXIT'.
  CHECK spfli NE old_spfli.
  CLEAR ok_code.
  CALL SCREEN 210 STARTING AT 10 5.
  CASE ok_code.
    WHEN 'SAVE'. UPDATE spfli.
    WHEN 'EXIT'.
    WHEN 'CANC'. CLEAR spfli.
  ENDCASE.
ENDFORM.
