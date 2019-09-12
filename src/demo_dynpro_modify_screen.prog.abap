REPORT demo_dynpro_modify_screen .

INCLUDE demo_dynpro_modify_screen_sel.

DATA: field1(10) TYPE c, field2(10) TYPE c, field3(10) TYPE c,
      field4(10) TYPE c, field5(10) TYPE c, field6(10) TYPE c.

DATA: ok_code TYPE sy-ucomm,
      save_ok TYPE sy-ucomm.

DATA itab LIKE TABLE OF screen WITH HEADER LINE.

DATA length(2) TYPE c.

DATA screen_wa TYPE screen.

field1 = field2 = field3 = '0123456789'.

CALL SCREEN 100.

MODULE status_0100 OUTPUT.
  CLEAR: itab, itab[].
  SET PF-STATUS 'SCREEN_100'.
  IF save_ok = 'MODIFY'.
    itab-name = text-001.
    APPEND itab.
    LOOP AT SCREEN INTO screen_wa.
      IF screen_wa-group1 = 'MOD'.
        MOVE-CORRESPONDING screen_wa TO itab.
        APPEND itab.
      ENDIF.
    ENDLOOP.
    PERFORM change_input CHANGING:
            act, inp, out, inv, req, int, d3d, hlp, rqs.
    CALL SELECTION-SCREEN 1100 STARTING AT 37 5.
    PERFORM change_input CHANGING:
            act, inp, out, inv, req, int, d3d, hlp, rqs.
    MESSAGE s888(sabapdemos) WITH act inp out inv.
    CLEAR itab.
    APPEND itab.
    LOOP AT SCREEN INTO screen_wa.
      IF screen_wa-group1      = 'MOD'.
        screen_wa-active      = act.
        screen_wa-input       = inp.
        screen_wa-output      = out.
        screen_wa-invisible   = inv.
        screen_wa-required    = req.
        screen_wa-intensified = int.
        screen_wa-display_3d  = d3d.
        screen_wa-value_help  = hlp.
        screen_wa-request     = rqs.
        screen_wa-length      = len.
        MODIFY SCREEN FROM screen_wa.
      ENDIF.
    ENDLOOP.
    CLEAR itab.
    itab-name        = text-002.
    itab-active      = act.
    itab-input       = inp.
    itab-output      = out.
    itab-invisible   = inv.
    itab-required    = req.
    itab-intensified = int.
    itab-display_3d  = d3d.
    itab-value_help  = hlp.
    itab-request     = rqs.
    itab-length      = len.
    APPEND itab.
    CLEAR  itab.
    APPEND itab.
  ENDIF.
ENDMODULE.

MODULE cancel INPUT.
  LEAVE PROGRAM.
ENDMODULE.

MODULE user_command_0100 INPUT.
  save_ok = ok_code.
  CLEAR ok_code.
  CASE save_ok.
    WHEN 'MODIFY'.
      LEAVE TO SCREEN 100.
    WHEN 'LIST'.
      CLEAR itab.
      itab-name = text-003.
      APPEND itab.
      LOOP AT SCREEN INTO screen_wa.
        IF screen_wa-group1 = 'MOD'.
          MOVE-CORRESPONDING screen_wa TO itab.
          APPEND itab.
        ENDIF.
      ENDLOOP.
      CALL SCREEN 200 STARTING AT 37 5
                      ENDING   AT 87 22.
  ENDCASE.
ENDMODULE.

MODULE requested INPUT.
  MESSAGE s888(sabapdemos) WITH text-004.
ENDMODULE.

MODULE status_0200 OUTPUT.
  SET PF-STATUS 'SCREEN_200'.
  SUPPRESS DIALOG.
  LEAVE TO LIST-PROCESSING AND RETURN TO SCREEN 0.
  FORMAT COLOR COL_HEADING ON.
  WRITE: 10 'ACT', 14 'INP', 18 'OUT', 22 'INV', 26 'REQ',
         30 'INT', 34 'D3D', 38 'HLP', 42 'RQS', 46 'LEN'.
  FORMAT COLOR OFF.
  ULINE.
  LOOP AT itab.
    IF itab-name = ' '.
      ULINE.
    ELSEIF itab-name = text-001 OR itab-name = text-003.
      FORMAT COLOR COL_NORMAL ON.
    ELSE.
      FORMAT COLOR OFF.
    ENDIF.
    len = itab-length.
    length = ' '.
    IF len NE 0.
      length = len.
    ENDIF.
    WRITE: /(8) itab-name,
             11 itab-active,
             15 itab-input,
             19 itab-output,
             23 itab-invisible,
             27 itab-required,
             31 itab-intensified,
             35 itab-display_3d,
             39 itab-value_help,
             43 itab-request,
             47 length.
  ENDLOOP.
ENDMODULE.

FORM change_input CHANGING val TYPE any.
  IF val = 'X'.
    val = '1'.
  ELSEIF val = ' '.
    val = '0'.
  ELSEIF val = '1'.
    val = 'X'.
  ELSEIF val = '0'.
    val = ' '.
  ENDIF.
ENDFORM.
