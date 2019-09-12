REPORT demo_dynpro_set_hold_data.

DATA field(10) TYPE c.

CALL SCREEN 100.

field = 'XXXXXXXXXX'.

CALL SCREEN 100.

MODULE hold_data OUTPUT.
  SET HOLD DATA ON.
ENDMODULE.
