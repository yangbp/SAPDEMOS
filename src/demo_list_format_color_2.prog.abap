REPORT demo_list_format_color_2 NO STANDARD PAGE HEADING LINE-SIZE 70.

NODES: spfli, sflight.
DATA sum TYPE i.

TOP-OF-PAGE.

  WRITE 'List of Flights' COLOR COL_HEADING.
  ULINE.

GET spfli.

  FORMAT COLOR COL_HEADING.
  WRITE: 'CARRID', 10 'CONNID', 20 'FROM', 40 'TO'.

  FORMAT COLOR COL_KEY.
  WRITE: / spfli-carrid   UNDER 'CARRID',
           spfli-connid   UNDER 'CONNID',
           spfli-cityfrom UNDER 'FROM',
           spfli-cityto   UNDER 'TO'.
  ULINE.

  FORMAT COLOR COL_HEADING.
  WRITE: 'Date', 20 'Seats Occupied', 50 'Seats Available'.
  ULINE.

  sum = 0.

GET sflight.

  IF sflight-seatsocc LE 10.
    FORMAT COLOR COL_NEGATIVE.
  ELSE.
    FORMAT COLOR COL_NORMAL.
  ENDIF.

  WRITE: sflight-fldate   UNDER 'Date',
         sflight-seatsocc UNDER 'Seats Occupied',
         sflight-seatsmax UNDER 'Seats Available'.

  sum = sum + sflight-seatsocc.

GET spfli LATE.

  ULINE.
  WRITE: 'Total Bookings:  ' INTENSIFIED OFF,
         sum COLOR COL_TOTAL.
  ULINE.
  SKIP.
