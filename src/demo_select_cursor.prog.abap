REPORT demo_select_cursor.

DATA: wa_spfli   TYPE spfli,
      wa_sflight TYPE sflight,
      wa_sflight_back TYPE sflight.

DATA: c1 TYPE cursor,
      c2 TYPE cursor.

OPEN CURSOR @c1 FOR
  SELECT *
    FROM spfli
    ORDER BY PRIMARY KEY.

OPEN CURSOR @c2 FOR
  SELECT *
         FROM sflight
         ORDER BY PRIMARY KEY.

DATA(out) = cl_demo_output=>new( ).

DO.
  FETCH NEXT CURSOR @c1 INTO @wa_spfli.
  IF sy-subrc NE 0.
    EXIT.
  ENDIF.
  out->begin_section(
    |{ wa_spfli-carrid } { wa_spfli-connid }| ).
  DO.
    IF NOT wa_sflight_back IS INITIAL.
      wa_sflight = wa_sflight_back.
      CLEAR wa_sflight_back.
    ELSE.
      FETCH NEXT CURSOR @c2 INTO @wa_sflight.
      IF  sy-subrc <> 0.
        EXIT.
      ELSEIF wa_sflight-carrid <> wa_spfli-carrid
          OR wa_sflight-connid <> wa_spfli-connid.
        wa_sflight_back = wa_sflight.
        EXIT.
      ENDIF.
    ENDIF.
    out->write(
     |{ wa_sflight-carrid } {
        wa_sflight-connid } {
        wa_sflight-fldate }| ).
  ENDDO.
  out->end_section( ).
ENDDO.

CLOSE CURSOR: @c1, @c2.

out->display( ).
