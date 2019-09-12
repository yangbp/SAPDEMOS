PROGRAM demo_dynpro_push_button .

DATA: ok_code TYPE sy-ucomm,
      save_ok LIKE ok_code,
      output(8) TYPE c.

CALL SCREEN 100.

MODULE user_command_0100 INPUT.
  save_ok = ok_code.
  CLEAR ok_code.
  CASE save_ok.
    WHEN 'BUTTON_EXIT'.
      LEAVE PROGRAM.
    WHEN 'BUTTON_1'.
      output = 'Button 1'(001).
    WHEN 'BUTTON_2'.
      output = 'Button 2'(002).
    WHEN 'BUTTON_3'.
      output = 'Button 3'(003).
    WHEN 'BUTTON_4'.
      output = 'Button 4'(004).
    WHEN OTHERS.
      output = save_ok.
  ENDCASE.
ENDMODULE.
