FUNCTION DEMO_FUNCTION_MESSAGE_RAISING.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"       IMPORTING
*"             VALUE(MESSAGE_TYPE)
*"             VALUE(MESSAGE_PLACE)
*"             VALUE(MESSAGE_EVENT)
*"       EXCEPTIONS
*"              MESS
*"----------------------------------------------------------------------
  MESSAGE ID 'SABAPDEMOS' TYPE MESSAGE_TYPE NUMBER '777'
          WITH MESSAGE_TYPE MESSAGE_PLACE MESSAGE_EVENT
  RAISING MESS.
ENDFUNCTION.
