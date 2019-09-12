REPORT demo_program_read_tables.

DATA: wa_spfli TYPE spfli,
      wa_sflight TYPE sflight.

SELECT-OPTIONS sel_carr FOR wa_spfli-carrid.

SELECT carrid, connid, cityfrom, cityto
       FROM spfli
       WHERE carrid IN @sel_carr
       INTO CORRESPONDING FIELDS OF @wa_spfli.

  WRITE: / wa_spfli-carrid,
           wa_spfli-connid,
           wa_spfli-cityfrom,
           wa_spfli-cityto.

  SELECT fldate
         FROM sflight
         WHERE carrid = @wa_spfli-carrid
           AND connid = @wa_spfli-connid
         INTO CORRESPONDING FIELDS OF @wa_sflight.

    WRITE: / wa_sflight-fldate.

  ENDSELECT.

ENDSELECT.
