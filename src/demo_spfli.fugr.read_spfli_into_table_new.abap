FUNCTION read_spfli_into_table_new.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     VALUE(ID) LIKE  SPFLI-CARRID DEFAULT 'LH '
*"  EXPORTING
*"     VALUE(ITAB) TYPE  SPFLI_TAB
*"  RAISING
*"      CX_NO_FLIGHT_FOUND
*"----------------------------------------------------------------------

  SELECT * FROM spfli WHERE carrid = @id INTO TABLE @itab.

  IF sy-subrc NE 0.
    RAISE EXCEPTION TYPE cx_no_flight_found MESSAGE e007(sabapdemos).
  ENDIF.

ENDFUNCTION.
