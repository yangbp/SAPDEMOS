REPORT demo_dynpro_f4_help_dynpro.

DATA: carrier(3) TYPE c,
      connection(4) TYPE c.

CALL SCREEN 100.

MODULE cancel INPUT.
  LEAVE PROGRAM.
ENDMODULE.
