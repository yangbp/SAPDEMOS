FUNCTION demo_update_delete.
*"----------------------------------------------------------------------
*"*"Verbuchungsfunktionsbaustein:
*"
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     VALUE(VALUES) TYPE  DEMO_UPDATE_TAB OPTIONAL
*"----------------------------------------------------------------------

  IF values IS NOT INITIAL.
    DELETE demo_update FROM TABLE values.
  ELSE.
    DELETE FROM demo_update.
  ENDIF.

ENDFUNCTION.
