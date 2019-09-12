REPORT  DEMO_MACRO.

DATA: x TYPE i, y TYPE i, l TYPE i.

DEFINE write_frame.
  x = sy-colno. y = sy-linno.
  WRITE: '|' NO-GAP, &1 NO-GAP, '|' NO-GAP.
  l = sy-colno - x.
  y = y - 1. SKIP TO LINE y. POSITION x.
  ULINE AT x(l).
  y = y + 2. SKIP TO LINE y. POSITION x.
  ULINE AT x(l).
  y = y - 1. x = sy-colno. SKIP TO LINE y. POSITION x.
END-OF-DEFINITION.

SKIP.
write_frame 'In a frame!'.
