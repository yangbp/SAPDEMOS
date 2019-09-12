REPORT demo_dialog_module.

DATA spfli_wa TYPE spfli.
spfli_wa-carrid = 'LH'.
spfli_wa-connid = '0400'.

START-OF-SELECTION.

  CALL DIALOG 'DEMO_DIALOG_MODULE'
    EXPORTING
      spfli-carrid FROM spfli_wa-carrid
      spfli-connid FROM spfli_wa-connid
    IMPORTING
      spfli_wa     TO spfli_wa.

      WRITE: / spfli_wa-carrid,
             / spfli_wa-connid,
             / spfli_wa-countryfr,
             / spfli_wa-cityfrom,
             / spfli_wa-airpfrom,
             / spfli_wa-countryto,
             / spfli_wa-cityto,
             / spfli_wa-airpto,
             / spfli_wa-fltime,
             / spfli_wa-deptime,
             / spfli_wa-arrtime,
             / spfli_wa-distance,
             / spfli_wa-distid,
             / spfli_wa-fltype,
             / spfli_wa-period.
