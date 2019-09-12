FUNCTION-POOL DEMO_TEXT_INPUT.              "MESSAGE-ID ..

DATA:
  container TYPE REF TO cl_gui_custom_container,
  editor    TYPE REF TO cl_gui_textedit.

DATA:
  text_line   TYPE c LENGTH 72,
  text_table  LIKE STANDARD TABLE OF text_line
              WITH DEFAULT KEY.

DATA ok_code TYPE sy-ucomm.

DATA g_title TYPE string.
INCLUDE ldemo_text_inputd01.
