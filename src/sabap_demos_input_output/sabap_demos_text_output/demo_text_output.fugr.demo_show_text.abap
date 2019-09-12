FUNCTION demo_show_text .
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     REFERENCE(TEXT) TYPE  CL_DEMO_TEXT=>T_TEXT OPTIONAL
*"     REFERENCE(TEXT_STRING) TYPE  STRING OPTIONAL
*"----------------------------------------------------------------------

*  DATA stack TYPE abap_callstack.
*  CALL FUNCTION 'SYSTEM_CALLSTACK'
*    IMPORTING
*      callstack = stack.
*  IF stack[ line_index( stack[ mainprogram = 'SAPLDEMO_TEXT_OUTPUT' ] ) + 1
*          ]-mainprogram <> 'CL_DEMO_TEXT==================CP'.
*    MESSAGE TEXT-not TYPE 'I' DISPLAY LIKE 'E'.
*    RETURN.
*  ENDIF.

  IF text IS SUPPLIED AND text_string IS SUPPLIED.
    g_text_string = `Only one import parameter must be supplied` ##no_text.
  ELSEIF text IS SUPPLIED.
    g_text = text.
  ELSEIF text_string IS SUPPLIED.
    g_text_string = text_string.
  ENDIF.
  CALL SCREEN 100 STARTING AT 10 5.

ENDFUNCTION.
