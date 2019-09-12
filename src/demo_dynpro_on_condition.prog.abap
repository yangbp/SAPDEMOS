PROGRAM demo_dynpro_on_condition .

DATA: ok_code TYPE sy-ucomm,
      input1(20) TYPE c, input2(20) TYPE c, input3(20) TYPE c,
      fld(20) TYPE c.

CALL SCREEN 100.

MODULE init_screen_100 OUTPUT.
  SET PF-STATUS 'STATUS_100'.
ENDMODULE.

MODULE cancel INPUT.
  LEAVE PROGRAM.
ENDMODULE.

MODULE cursor INPUT.
  GET CURSOR FIELD fld.
  MESSAGE i888(sabapdemos) WITH text-001 fld.
ENDMODULE.

MODULE module_1 INPUT.
  MESSAGE i888(sabapdemos) WITH text-002.
ENDMODULE.

MODULE module_2 INPUT.
  MESSAGE i888(sabapdemos) WITH text-003.
ENDMODULE.

MODULE module_* INPUT.
  MESSAGE i888(sabapdemos) WITH text-004 input3.
ENDMODULE.

MODULE c1 INPUT.
  MESSAGE i888(sabapdemos) WITH text-005 '1'.
ENDMODULE.

MODULE c2 INPUT.
  MESSAGE i888(sabapdemos) WITH text-005 '2' text-006 '3'.
ENDMODULE.
