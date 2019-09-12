REPORT demo_dynpro_set_cursor.

DATA:  field1(14) TYPE c, field2(14) TYPE c, field3(14) TYPE c,
       name(10) TYPE c.

SELECTION-SCREEN BEGIN OF BLOCK bloc WITH FRAME.
PARAMETERS: def RADIOBUTTON GROUP rad,
            txt RADIOBUTTON GROUP rad,
            f1  RADIOBUTTON GROUP rad,
            f2  RADIOBUTTON GROUP rad,
            f3  RADIOBUTTON GROUP rad.
SELECTION-SCREEN END OF BLOCK bloc.

PARAMETERS pos TYPE i.

IF txt = 'X'.
  name = 'TEXT'.
ELSEIF f1 = 'X'.
  name = 'FIELD1'.
ELSEIF f2 = 'X'.
  name = 'FIELD2'.
ELSEIF f3 = 'X'.
  name = 'FIELD3'.
ENDIF.

CALL SCREEN 100.

MODULE cursor OUTPUT.
  IF def NE 'X'.
    SET CURSOR FIELD name OFFSET pos.
  ENDIF.
  SET PF-STATUS 'SCREEN_100'.
ENDMODULE.

MODULE back INPUT.
  LEAVE SCREEN.
ENDMODULE.
