REPORT demo_leave_to_list_processing .

TABLES demo_conn.

DATA: wa_spfli TYPE spfli,
      flightdate TYPE sflight-fldate.

CALL SCREEN 100.

MODULE status_0100 OUTPUT.
  SET PF-STATUS 'SCREEN_100'.
ENDMODULE.

MODULE cancel INPUT.
  LEAVE PROGRAM.
ENDMODULE.

MODULE user_command_0100.
  CALL SCREEN 500.
  SET SCREEN 100.
ENDMODULE.

MODULE call_list_500 OUTPUT.
  LEAVE TO LIST-PROCESSING AND RETURN TO SCREEN 0.
  SET PF-STATUS space.
  SUPPRESS DIALOG.
  SELECT  carrid, connid, cityfrom, cityto
    FROM  spfli
    WHERE carrid = @demo_conn-carrid
    INTO  CORRESPONDING FIELDS OF @wa_spfli.
    WRITE: / wa_spfli-carrid, wa_spfli-connid,
             wa_spfli-cityfrom, wa_spfli-cityto.
    HIDE: wa_spfli-carrid, wa_spfli-connid.
  ENDSELECT.
  CLEAR wa_spfli-carrid.
ENDMODULE.

TOP-OF-PAGE.
  WRITE text-001 COLOR COL_HEADING.
  ULINE.

TOP-OF-PAGE DURING LINE-SELECTION.
  WRITE sy-lisel COLOR COL_HEADING.
  ULINE.

AT LINE-SELECTION.
  CHECK NOT wa_spfli-carrid IS INITIAL.
  SELECT  fldate
    FROM  sflight
    WHERE carrid = @wa_spfli-carrid AND
          connid = @wa_spfli-connid
    INTO  @flightdate.
    WRITE / flightdate.
  ENDSELECT.
  CLEAR wa_spfli-carrid.
