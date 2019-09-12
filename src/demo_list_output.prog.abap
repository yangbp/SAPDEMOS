REPORT demo_list_output.

NODES spfli.

GET spfli.
  NEW-LINE.
  WRITE: spfli-mandt, spfli-carrid, spfli-connid,
  spfli-cityfrom, spfli-airpfrom, spfli-cityto,
  spfli-airpto, spfli-fltime, spfli-deptime, spfli-arrtime,
  spfli-distance UNIT 'MI', spfli-distid, spfli-fltype.
