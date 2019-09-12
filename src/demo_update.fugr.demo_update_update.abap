FUNCTION DEMO_UPDATE_UPDATE.
*"----------------------------------------------------------------------
*"*"Verbuchungsfunktionsbaustein:
*"
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     VALUE(VALUES) TYPE  DEMO_UPDATE_TAB
*"----------------------------------------------------------------------

  UPDATE demo_update FROM TABLE values.

ENDFUNCTION.
