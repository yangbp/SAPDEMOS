PROGRAM demo_dynpro_value_select.

DATA: ok_code TYPE sy-ucomm,
      carrier TYPE spfli-carrid,
      connect TYPE spfli-connid.

CALL SCREEN 100.

MODULE init_screen_0100 OUTPUT.
  SET PF-STATUS 'STATUS_100'.
ENDMODULE.

MODULE cancel INPUT.
  LEAVE PROGRAM.
ENDMODULE.

MODULE module_1 INPUT.
  MESSAGE i888(sabapdemos) WITH text-001 carrier
                        text-002 connect.
ENDMODULE.

MODULE module_2 INPUT.
  MESSAGE i888(sabapdemos) WITH text-001 carrier
                        text-002 connect.
ENDMODULE.
