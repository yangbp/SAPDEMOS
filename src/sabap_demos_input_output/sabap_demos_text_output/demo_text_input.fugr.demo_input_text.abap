FUNCTION demo_input_text .
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     REFERENCE(TITLE) TYPE  STRING DEFAULT `Text`
*"  CHANGING
*"     REFERENCE(TEXT_STRING) TYPE  STRING
*"  EXCEPTIONS
*"      CANCELED
*"----------------------------------------------------------------------

*  DATA stack TYPE abap_callstack.
*  CALL FUNCTION 'SYSTEM_CALLSTACK'
*    IMPORTING
*      callstack = stack.
*  IF stack[ line_index( stack[ mainprogram = 'SAPLDEMO_TEXT_INPUT' ] ) + 1
*          ]-mainprogram <> 'CL_DEMO_TEXT==================CP'.
*    MESSAGE TEXT-not TYPE 'I' DISPLAY LIKE 'E'.
*    RETURN.
*  ENDIF.

  SPLIT text_string AT |\n|  INTO TABLE text_table.

  g_title  = title.
  CALL SCREEN 100 STARTING AT 30 6.

  text_string = concat_lines_of( table = text_table sep = |\n| ).
  "CONDENSE text_string.

ENDFUNCTION.
