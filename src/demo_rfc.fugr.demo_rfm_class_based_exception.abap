FUNCTION demo_rfm_class_based_exception.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  RAISING
*"      CX_DEMO_EXCEPTION
*"----------------------------------------------------------------------

  DATA t100_msg TYPE scx_t100key.

  t100_msg-msgid = 'SABAPDEMOS'.
  t100_msg-msgno = '888'.
  t100_msg-attr1 = 'EXCEPTION_TEXT'.

  RAISE EXCEPTION TYPE cx_demo_exception
    EXPORTING
      exception_text = text-cbe
      textid         = t100_msg.

ENDFUNCTION.
