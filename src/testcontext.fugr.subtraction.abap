FUNCTION SUBTRACTION.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"       IMPORTING
*"             VALUE(V1) LIKE  SFLIGHT-SEATSMAX
*"             VALUE(V2) LIKE  SFLIGHT-SEATSOCC
*"       EXPORTING
*"             VALUE(RESULT) LIKE  SFLIGHT-SEATSOCC
*"----------------------------------------------------------------------


RESULT = V1 - V2.


ENDFUNCTION.
