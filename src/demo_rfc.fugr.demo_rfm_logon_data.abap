FUNCTION demo_rfm_logon_data.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  EXPORTING
*"     VALUE(UNAME) TYPE  SY-UNAME
*"     VALUE(MANDT) TYPE  SY-MANDT
*"     VALUE(LANGU) TYPE  SY-LANGU
*"     VALUE(LOGON_LANGU) TYPE  SY-LANGU
*"----------------------------------------------------------------------

  IF cl_abap_syst=>get_logon_language( ) <> 'E'.
    SET LOCALE LANGUAGE 'E'.
  ELSE.
    SET LOCALE LANGUAGE 'D'.
  ENDIF.

  uname = sy-uname.
  mandt = sy-mandt.

  logon_langu = cl_abap_syst=>get_logon_language( ).
  langu = cl_abap_syst=>get_language( ).

  ASSERT langu = sy-langu.

ENDFUNCTION.
