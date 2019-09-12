FUNCTION DEMO_CALCULATOR_UI .
*"--------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     REFERENCE(DISPLAY) TYPE  CSEQUENCE
*"  EXPORTING
*"     REFERENCE(FUNCTION) TYPE  CSEQUENCE
*"--------------------------------------------------------------------

  g_display = display.
  CALL SCREEN 100 STARTING AT 10 10.
  function = sy-ucomm.

ENDFUNCTION.
