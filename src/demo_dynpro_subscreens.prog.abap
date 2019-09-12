REPORT demo_dynpro_subscreens.

DATA: ok_code TYPE sy-ucomm,
      save_ok TYPE sy-ucomm.

DATA: number1(4) TYPE n VALUE '0110',
      number2(4) TYPE n VALUE '0130',
      field(10) TYPE c, field1(10) TYPE c, field2(10) TYPE c.

CALL SCREEN 100.

MODULE status_100 OUTPUT.
  SET PF-STATUS 'SCREEN_100'.
ENDMODULE.

MODULE fill_0110 OUTPUT.
  field = 'Eingabe 1'(001).
ENDMODULE.

MODULE fill_0120 OUTPUT.
  field = field1.
ENDMODULE.

MODULE fill_0130 OUTPUT.
  field = 'Eingabe 2'(002).
ENDMODULE.

MODULE fill_0140 OUTPUT.
  field = field2.
ENDMODULE.

MODULE cancel INPUT.
  LEAVE PROGRAM.
ENDMODULE.

MODULE save_ok INPUT.
  save_ok = ok_code.
  CLEAR ok_code.
ENDMODULE.

MODULE user_command_0110 INPUT.
  IF save_ok = 'OK1'.
    number1 = '0120'.
    field1 = field.
    CLEAR field.
  ENDIF.
ENDMODULE.

MODULE user_command_0130 INPUT.
  IF save_ok = 'OK2'.
    number2 = '0140'.
    field2 = field.
    CLEAR field.
  ENDIF.
ENDMODULE.

MODULE user_command_100 INPUT.
  CASE save_ok.
    WHEN 'SUB1'.
      number1 = '0110'.
    WHEN 'SUB2'.
      number1 = '0120'.
      CLEAR field1.
    WHEN 'SUB3'.
      number2 = '0130'.
    WHEN 'SUB4'.
      number2 = '0140'.
      CLEAR field2.
  ENDCASE.
ENDMODULE.
