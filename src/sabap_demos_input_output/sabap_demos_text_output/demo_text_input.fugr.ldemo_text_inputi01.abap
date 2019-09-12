*&---------------------------------------------------------------------*
*&  Include           LDEMO_INPUT_TEXTI01
*&---------------------------------------------------------------------*

MODULE cancel INPUT.
  RAISE canceled.
ENDMODULE.

MODULE read_text_control INPUT.
  input_text_string=>read_text_control( ).
ENDMODULE.

MODULE user_command_0100 INPUT.
  input_text_string=>user_command( ).
ENDMODULE.
