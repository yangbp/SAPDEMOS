REPORT demo_write_cuttoffs LINE-SIZE 54 NO STANDARD PAGE HEADING.

PARAMETERS xdezp  TYPE t005x-xdezp DEFAULT ' '
                  AS LISTBOX VISIBLE LENGTH 40.

PARAMETERS datfm  TYPE t005x-datfm DEFAULT '1'
                  AS LISTBOX VISIBLE LENGTH 40.

PARAMETERS timefm TYPE t005x-timefm DEFAULT '0'
                  AS LISTBOX VISIBLE LENGTH 40.

SELECTION-SCREEN SKIP.

PARAMETERS length TYPE n LENGTH 2 DEFAULT '40'.


CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
  PRIVATE SECTION.
    CLASS-DATA:
      b          TYPE int1,
      s          TYPE int2,
      i          TYPE i,
      int8       TYPE int8,
      p          TYPE p DECIMALS 2,
      decfloat16 TYPE decfloat16,
      decfloat34 TYPE decfloat34,
      f          TYPE f.
    CLASS-DATA:
      c          TYPE c LENGTH 20,
      string     TYPE string,
      n          TYPE n LENGTH 20,
      d          TYPE d,
      t          TYPE t.
    CLASS-DATA:
      x          TYPE x LENGTH 10,
      xstring    TYPE xstring.
    CLASS-DATA:
      timestamp  TYPE timestamp,
      timestampl TYPE timestampl.
    CLASS-DATA
      names TYPE STANDARD TABLE OF string.
    CLASS-METHODS:
      setup,
      create_data,
      teardown,
      check_system,
      display
        IMPORTING name   TYPE string
                  len    TYPE i
                  output TYPE c.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.

    DATA: dref TYPE REF TO data,
          len TYPE i,
          name TYPE string.

    FIELD-SYMBOLS <output> TYPE data.

    len = length.
    IF len < 1 OR len > 40.
      WRITE 'Length must be between 1 and 40!' COLOR COL_TOTAL.
      RETURN.
    ENDIF.

    setup( ).
    create_data( ).

    CREATE DATA dref TYPE c LENGTH len.
    ASSIGN dref->* TO <output>.
    LOOP AT names INTO name.
      TRY.
          CASE name.
            WHEN 't'.
              WRITE t TO <output> ENVIRONMENT TIME FORMAT.
            WHEN 'TIMESTAMP'.
              WRITE timestamp TO <output> TIME ZONE sy-zonlo.
            WHEN 'TIMESTAMPL'.
              WRITE timestampl TO <output> TIME ZONE sy-zonlo.
            WHEN OTHERS.
              WRITE (name) TO <output>.
          ENDCASE.
          display( name   = name len = len
                   output = <output> ).
        CATCH cx_root.
          display( name = name
                   len  = len output = '!' ).
      ENDTRY.
    ENDLOOP.

    teardown( ).

  ENDMETHOD.
  METHOD setup.
    DATA: t005x_wa TYPE t005x,
          ans      TYPE c LENGTH 1.
    check_system( ).
    SELECT SINGLE land
           FROM t005x
           WHERE land = '@$@'
           INTO (@t005x_wa-land).
    IF sy-subrc = 0.
      CALL FUNCTION 'POPUP_TO_CONFIRM'
        EXPORTING
          titlebar              = 'Confirmation'
          text_question         = 'Delete existing'
          &
          ' entry with key'
          &
          ' @$@ in T005X?'
          text_button_1         = 'Yes'
          text_button_2         = 'No'
          display_cancel_button = ' '
        IMPORTING
          answer                = ans.
      IF ans = 1.
        teardown( ).
      ELSE.
        MESSAGE 'Execution not possible' TYPE 'I' DISPLAY LIKE 'E'.
        LEAVE PROGRAM.
      ENDIF.
    ENDIF.
    t005x_wa-land = '@$@'.
    t005x_wa-xdezp = xdezp.
    t005x_wa-datfm = datfm.
    t005x_wa-timefm = timefm.
    INSERT t005x FROM @t005x_wa.
    COMMIT WORK.
    SET COUNTRY '@$@'.
  ENDMETHOD.
  METHOD create_data.
    b          = 123.
    s          = -12345.
    i          = 1234567890.
    int8       = -1234567890123456789.
    p          = '-1234567.89'.
    decfloat16 = '-12345678.90123456'.
    decfloat34 = '12345678.90123456789012345678901234'.
    f          = '-1234.5678901234567'.

    c          = 'abcdefghijklmnopqrst'.
    string     = 'abcdefghijklmnopqrst'.
    n          = '12345678901234567890'.
    d          = '20101129'.
    t          = '193545'.

    x          = '00112233445566778899'.
    xstring    = '00112233445566778899'.

    timestamp  = '20101129193545'.
    timestampl = '20101129193545.1234567'.

    names = VALUE #(
      ( `b` ) ( `s` ) ( `i` ) ( `int8` ) ( `p` )
      ( `decfloat16` ) ( `decfloat34` ) ( `f` )
      ( `c` ) ( `string` ) ( `n` ) ( `d` ) ( `t` )
      ( `x` ) ( `xstring` )
      ( `TIMESTAMP` ) ( `TIMESTAMPL` ) ).
  ENDMETHOD.
  METHOD teardown.
    DELETE FROM t005x WHERE land = '@$@'.
    COMMIT WORK.
  ENDMETHOD.
  METHOD check_system.
    IF cl_abap_demo_services=>is_production_system( ).
      MESSAGE 'This demo cannot be executed in a production system'
              TYPE 'I' DISPLAY LIKE 'E'.
      LEAVE PROGRAM.
    ENDIF.
  ENDMETHOD.
  METHOD display.
    DATA:  col  TYPE i VALUE 2,
           fill TYPE c LENGTH 40,
           fill_len TYPE i.
    IF output = '!'.
      col = 6.
    ENDIF.
    fill_len = 41 - len.
    WRITE: AT /(12) name    COLOR COL_HEADING NO-GAP,
                    ' ' COLOR COL_POSITIVE NO-GAP,
           AT (len) output COLOR = col NO-GAP,
           AT (fill_len) fill COLOR COL_POSITIVE.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
