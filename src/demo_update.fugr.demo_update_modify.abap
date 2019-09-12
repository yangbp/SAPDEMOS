FUNCTION DEMO_UPDATE_MODIFY.
*"----------------------------------------------------------------------
*"*"Verbuchungsfunktionsbaustein:
*"
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     VALUE(VALUES) TYPE  DEMO_UPDATE_TAB
*"----------------------------------------------------------------------

  MODIFY demo_update FROM TABLE values.

ENDFUNCTION.
