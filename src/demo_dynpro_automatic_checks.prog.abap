PROGRAM demo_dynpro_automatic_checks .

DATA: ok_code TYPE sy-ucomm,
      date TYPE d.

TABLES demo_conn.

CALL SCREEN 100.

MODULE init_screen_100 OUTPUT.
  SET PF-STATUS 'STATUS_100'.
ENDMODULE.

MODULE cancel INPUT.
  LEAVE PROGRAM.
ENDMODULE.

MODULE pai INPUT.
  MESSAGE i888(sabapdemos) WITH text-001.
ENDMODULE.
