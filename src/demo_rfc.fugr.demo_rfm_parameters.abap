FUNCTION demo_rfm_parameters.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     VALUE(P_IN) TYPE  STRING
*"  EXPORTING
*"     VALUE(P_OUT) TYPE  STRING
*"  CHANGING
*"     VALUE(P_IN_OUT) TYPE  STRING
*"----------------------------------------------------------------------

  p_out    = `Imported: ` && p_in.
  p_in_out = `Changed:  ` && p_in_out.

  ENDFUNCTION.
