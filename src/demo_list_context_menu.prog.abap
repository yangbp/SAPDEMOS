REPORT demo_list_context_menu .

DATA: wa_spfli   TYPE spfli,
      wa_sflight TYPE sflight.

START-OF-SELECTION.
  SET PF-STATUS 'BASIC'.

  SELECT * FROM spfli INTO @wa_spfli.
    WRITE: / wa_spfli-carrid,
             wa_spfli-connid,
             wa_spfli-cityfrom,
             wa_spfli-cityto.
    HIDE: wa_spfli-carrid, wa_spfli-connid.
  ENDSELECT.
  CLEAR wa_spfli.

AT USER-COMMAND.
  CASE sy-ucomm.
    WHEN 'DETAIL'.
      CHECK NOT wa_spfli IS INITIAL.
      WRITE sy-lisel COLOR COL_HEADING.
      SELECT * FROM sflight
               WHERE carrid = @wa_spfli-carrid
                 AND connid = @wa_spfli-connid
               INTO @wa_sflight.
        WRITE / wa_sflight-fldate.
      ENDSELECT.
      CLEAR wa_spfli.
  ENDCASE.

FORM on_ctmenu_request USING l_menu TYPE REF TO cl_ctmenu.
  DATA lin TYPE i.
  GET CURSOR LINE lin.
  IF lin > 2 AND sy-lsind = 0.
    CALL METHOD l_menu->add_function
                EXPORTING fcode = 'DETAIL'
                          text  = text-001.
  ENDIF.
  CALL METHOD l_menu->add_function
              EXPORTING fcode = 'BACK'
                        text  = text-002.
ENDFORM.
