PROGRAM demo_dynpro_module.

TABLES demo_conn.

DATA: ok_code TYPE sy-ucomm,
      save_ok LIKE ok_code,
      wa_spfli TYPE spfli.

CALL SCREEN 100.

MODULE init_screen_100 OUTPUT.
  MOVE-CORRESPONDING wa_spfli TO demo_conn.
ENDMODULE.

MODULE status_0100 OUTPUT.
  SET PF-STATUS 'STATUS_100'.
  SET TITLEBAR '100'.
ENDMODULE.

MODULE clear_ok_code INPUT.
  save_ok = ok_code.
  CLEAR ok_code.
ENDMODULE.

MODULE get_data INPUT.
  MOVE-CORRESPONDING demo_conn TO wa_spfli.
  CLEAR demo_conn.
ENDMODULE.

MODULE user_command_0100 INPUT.
  CASE sy-dynnr.
    WHEN 0100.
      CASE save_ok.
        WHEN 'CANCEL'.
          LEAVE PROGRAM.
        WHEN 'DISPLAY'.
          PERFORM read_data.
        WHEN 'CLEAR'.
          CLEAR wa_spfli.
      ENDCASE.
      ...
  ENDCASE.
ENDMODULE.

FORM read_data.
  SELECT  SINGLE
          cityfrom, airpfrom, cityto, airpto, fltime, deptime, arrtime
    FROM  spfli
    WHERE carrid = @wa_spfli-carrid AND connid = @wa_spfli-connid
    INTO  CORRESPONDING FIELDS OF @wa_spfli.
ENDFORM.
