REPORT demo_logical_expr_seltab_1 .

DATA wa_carrid TYPE spfli-carrid.

SELECT-OPTIONS airline FOR wa_carrid.

WRITE: 'Inside', 'Outside'.
SKIP.

SELECT carrid FROM spfli INTO @wa_carrid.
  IF wa_carrid IN airline.
    WRITE: / wa_carrid UNDER 'Inside'.
  ELSE.
    WRITE: / wa_carrid UNDER 'Outside'.
  ENDIF.
ENDSELECT.
