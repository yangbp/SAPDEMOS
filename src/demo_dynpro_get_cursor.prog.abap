PROGRAM demo_dynpro_get_cursor .

DATA: ok_code TYPE sy-ucomm,
      save_ok LIKE ok_code.

DATA: input_output(20) TYPE c,
      fld(20) TYPE c,
      off     TYPE i,
      val(20) TYPE c,
      len     TYPE i.

CALL SCREEN 100.

MODULE init_screen_0100 OUTPUT.
  SET PF-STATUS 'STATUS_100'.
ENDMODULE.

MODULE user_command_0100 INPUT.
  save_ok = ok_code.
  CLEAR ok_code.
  CASE save_ok.
    WHEN 'CANCEL'.
      LEAVE PROGRAM.
    WHEN 'SELE'.
      GET CURSOR FIELD fld OFFSET off VALUE val LENGTH len.
  ENDCASE.
ENDMODULE.
