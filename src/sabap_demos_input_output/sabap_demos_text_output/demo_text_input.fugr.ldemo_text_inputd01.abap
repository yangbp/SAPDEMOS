*&---------------------------------------------------------------------*
*&  Include           LDEMO_INPUT_TEXTD01
*&---------------------------------------------------------------------*

CLASS input_text_string DEFINITION FINAL.
  PUBLIC SECTION.
    CLASS-METHODS pbo.
    CLASS-METHODS write_text_control.
    CLASS-METHODS read_text_control.
    CLASS-METHODS user_command.
ENDCLASS.
