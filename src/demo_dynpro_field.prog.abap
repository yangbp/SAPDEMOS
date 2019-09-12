PROGRAM demo_dynpro_field.

DATA: ok_code TYPE sy-ucomm,
      save_ok LIKE ok_code,
      box1(1) TYPE c, box2(1) TYPE c, box3(1) TYPE c, box4(1) TYPE c,
      mod1_result1(1) TYPE c, mod1_result2(1) TYPE c,
      mod1_result3(1) TYPE c, mod1_result4(1) TYPE c,
      mod2_result1(1) TYPE c, mod2_result2(1) TYPE c,
      mod2_result3(1) TYPE c, mod2_result4(1) TYPE c,
      mod3_result1(1) TYPE c, mod3_result2(1) TYPE c,
      mod3_result3(1) TYPE c, mod3_result4(1) TYPE c.

CALL SCREEN 100.

MODULE init_screen_100 OUTPUT.
  SET PF-STATUS 'STATUS_100'.
  CLEAR:  box1, box2, box3, box4.
ENDMODULE.

MODULE user_command_0100 INPUT.
  save_ok = ok_code.
  CLEAR ok_code.
  IF save_ok = 'CANCEL'.
    LEAVE PROGRAM.
  ENDIF.
ENDMODULE.

MODULE module_1 INPUT.
  mod1_result1 = box1.
  mod1_result2 = box2.
  mod1_result3 = box3.
  mod1_result4 = box4.
ENDMODULE.

MODULE module_2 INPUT.
  mod2_result1 = box1.
  mod2_result2 = box2.
  mod2_result3 = box3.
  mod2_result4 = box4.
ENDMODULE.

MODULE module_3 INPUT.
  mod3_result1 = box1.
  mod3_result2 = box2.
  mod3_result3 = box3.
  mod3_result4 = box4.
ENDMODULE.
