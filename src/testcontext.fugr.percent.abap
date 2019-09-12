FUNCTION PERCENT.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"       IMPORTING
*"             VALUE(V1) LIKE  SFLIGHT-SEATSMAX
*"             VALUE(V2) LIKE  SFLIGHT-SEATSOCC
*"       EXPORTING
*"             VALUE(RESULT) LIKE  SFLIGHT-SEATSOCC
*"       EXCEPTIONS
*"              DIV_ZERO
*"----------------------------------------------------------------------


RESULT = V1 - V2.

IF V1 = 0.
  MESSAGE ID 'SABAPDEMOS' TYPE 'E' NUMBER '050' RAISING DIV_ZERO.
ELSE.
  RESULT = RESULT * 100 / V1.
ENDIF.

ENDFUNCTION.
