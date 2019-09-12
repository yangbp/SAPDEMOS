FUNCTION demo_rfm_call_transaction.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     VALUE(TCODE) TYPE  SY-TCODE
*"----------------------------------------------------------------------

  DATA same_system  LIKE sy-batch.
  CALL FUNCTION 'RFC_WITHIN_SAME_SYSTEM'
    IMPORTING
      caller_in_same_system = same_system
    EXCEPTIONS
      OTHERS                = 4.
  DATA(subrc) = sy-subrc.
  AUTHORITY-CHECK OBJECT 'S_DEVELOP'
    ID 'DEVCLASS' FIELD '$TMP'
    ID 'OBJTYPE'  FIELD 'PROG'
    ID 'OBJNAME'  DUMMY
    ID 'P_GROUP'  DUMMY
    ID 'ACTVT'    FIELD '02'.
  subrc = subrc + sy-subrc.
  IF subrc <> 0 OR
     same_system <> 'Y' OR
     cl_abap_demo_services=>is_production_system( ).
    MESSAGE 'Not authorized' TYPE 'I' DISPLAY LIKE 'E'.
  ENDIF.

  CALL TRANSACTION tcode WITH AUTHORITY-CHECK.

ENDFUNCTION.
