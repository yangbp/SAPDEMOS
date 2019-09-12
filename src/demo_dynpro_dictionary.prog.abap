PROGRAM demo_dynpro_dictionary .

TABLES demo_conn.
DATA wa_spfli TYPE spfli.

CALL SCREEN 100.

MODULE init_screen_100 OUTPUT.
  CLEAR demo_conn-mark.
  MOVE-CORRESPONDING wa_spfli TO demo_conn.
  CLEAR wa_spfli.
ENDMODULE.

MODULE user_command_0100 INPUT.
  IF demo_conn-mark = 'X'.
    LEAVE PROGRAM.
  ENDIF.
  MOVE-CORRESPONDING demo_conn TO wa_spfli.
  SELECT  SINGLE cityfrom, airpfrom, cityto, airpto,
                 fltime, deptime, arrtime
    FROM  spfli
    WHERE carrid = @wa_spfli-carrid AND connid = @wa_spfli-connid
    INTO  CORRESPONDING FIELDS OF @wa_spfli.
ENDMODULE.
