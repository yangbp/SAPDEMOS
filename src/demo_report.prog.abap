REPORT demo_report.

NODES: spfli, sflight, sbook.

DATA: weight       TYPE p LENGTH 8 DECIMALS 4,
      total_weight TYPE p LENGTH 8 DECIMALS 4.

INITIALIZATION.
  carrid-sign = 'I'.
  carrid-option = 'EQ'.
  carrid-low = 'AA'.
  carrid-high = 'LH'.
  APPEND carrid TO carrid.

START-OF-SELECTION.
  WRITE 'Luggage weight of flights'.

GET spfli FIELDS carrid connid cityfrom cityto.
  SKIP.
  ULINE.
  WRITE: / 'Carrid:', spfli-carrid,
           'Connid:', spfli-connid,
         / 'From:  ', spfli-cityfrom,
           'To:    ', spfli-cityto.
  ULINE.

GET sflight FIELDS fldate.
  SKIP.
  WRITE: / 'Date:', sflight-fldate.

GET sbook FIELDS luggweight.
  weight = weight + sbook-luggweight.
GET sflight LATE FIELDS carrid .
  WRITE: / 'Luggage weight =', weight.
  total_weight = total_weight + weight.
  weight = 0.

END-OF-SELECTION.
  ULINE.
  WRITE: / 'Sum of luggage weights =', total_weight.
