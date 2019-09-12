PROGRAM demo_minesweeper_740.

CLASS game DEFINITION.
  PUBLIC SECTION.
    METHODS:
      constructor,
      display.
  PRIVATE SECTION.
    TYPES:
      BEGIN OF t_cell,
        bomb  TYPE abap_bool,  " cell contains bomb y/n
        bombs TYPE i,          " # of neighboring bombs
        state TYPE char1,      " [h]idden, [v]isible, [f]lagged
      END OF t_cell,
      t_cells TYPE STANDARD TABLE OF t_cell  WITH EMPTY KEY,
      t_field TYPE STANDARD TABLE OF t_cells WITH EMPTY KEY.
    DATA:
      field  TYPE t_field,
      n      TYPE i,        " dimension of field
      bombs  TYPE i,        " # of existing bombs
      hidden TYPE i,        " # of hidden cells
      flags  TYPE i,        " # of flagged cells
      moves  TYPE i,        " # of moves
      over   TYPE char1,    " game over: [w]in, [d]ead
      header TYPE string.   " HTML header string
    METHODS:
      at_click FOR EVENT sapevent OF cl_abap_browser IMPORTING action,
      detect IMPORTING VALUE(x) TYPE i VALUE(y) TYPE i.
ENDCLASS.

CLASS game IMPLEMENTATION.
  METHOD constructor.
    DATA(wh) = `width:13px;height:18px`.
    header = replace(
      occ = 0 sub = `@` with = `background-color:` val =
     `<html><head><style type="text/css">` &&
     `.bx{text-decoration:none;cursor:hand;` &&
     wh && `} a{` && wh && `}` &&
     `.hid{@#404080} .flg{@red} .bmb{@black}` &&
     `.b0{@#e0e0e0} .b1{@lightblue} .b2{@lightgreen} .b3{@orange}` &&
     `</style>` &&
     `<script>function setloc(e){window.location=e;}</script>` &&
     `</head><body scroll="no"><table border="0">` ) ##NO_TEXT.
    DATA(size) = 10.
    DATA(level) = 3.
    cl_demo_input=>add_field( CHANGING field = size ).
    cl_demo_input=>request(   CHANGING field = level ).
    " size: 2..32
    n     = nmax( val1 = 2 val2 = nmin( val1 = size val2 = 32 ) ).
    " level: 1..5
    level = nmax( val1 = 1 val2 = nmin( val1 = level val2 = 5 ) ).
    DATA(threshold) = 100 - level * 10.
    " place hidden bombs randomly
    field = VALUE #(
      LET r = cl_abap_random_int=>create( seed = CONV i( sy-uzeit )
                                          min  = 0
                                          max  = 99 ) IN
      FOR i = 1 UNTIL i > n
      ( VALUE #( FOR j = 1 UNTIL j > n
                 ( state = 'h'
                   bomb = COND #( WHEN r->get_next( ) > threshold
                                    THEN 'X' ) ) ) ) ).
    " compute neighboring-bombs count for each cell, and overall count
    LOOP AT field ASSIGNING FIELD-SYMBOL(<cells>).
      DATA(y) = sy-tabix.
      LOOP AT <cells> ASSIGNING FIELD-SYMBOL(<cell>).
        IF <cell>-bomb = 'X'.
          bombs = bombs + 1.
        ELSE.
          DATA(x) = sy-tabix.
          <cell>-bombs = REDUCE i(
            INIT b = 0
            FOR  i = nmax( val1 = 1 val2 = y - 1 )
            WHILE i <= nmin( val1 = y + 1 val2 = n )
            FOR  j = nmax( val1 = 1 val2 = x - 1 )
            WHILE j <= nmin( val1 = x + 1 val2 = n )
            LET <f> = field[ i ][ j ] IN
            NEXT b = COND #( WHEN <f>-bomb = 'X' THEN b + 1 ELSE b ) ).
        ENDIF.
      ENDLOOP.
    ENDLOOP.
    hidden = n * n.
    SET HANDLER at_click.
  ENDMETHOD.

  METHOD display.
    cl_abap_browser=>show_html(
     title        = CONV cl_abap_browser=>title( sy-title )
     size         = COND #( WHEN n < 20 THEN cl_abap_browser=>small
                                        ELSE cl_abap_browser=>medium )
     format       = cl_abap_browser=>portrait
     context_menu = 'X'
     html_string  =
       REDUCE string(
        INIT  h = header
        FOR   y = 1 UNTIL y > n
        NEXT  h = h && |<tr{ COND #( WHEN over <> '' THEN
                          ` onclick="setloc('sapevent:ovr');"` ) }>| &&
         REDUCE string(
          INIT k = ``
          FOR  x = 1  UNTIL x > n
          LET  c = field[ y ][ x ]
               " CSS style (hid,flg,b0,...,b3) of cell
               style = COND string(
                         WHEN over <> '' AND
                              c-bomb = 'X'  " bomb
                           THEN `bmb`
                         WHEN c-state = 'f' " flagged
                           THEN `flg`
                         WHEN c-state = 'v' " visible
                           THEN |b{ nmin( val1 = c-bombs val2 = 3 ) }|
                         WHEN over <> ''    " empty
                           THEN `b0`
                         ELSE  `hid` ) " hidden
               pos = |x{ x WIDTH = 2 ALIGN = RIGHT PAD = '0' }| &
                     |y{ y WIDTH = 2 ALIGN = RIGHT PAD = '0' }|
          IN
          NEXT k = |{ k }<td class={ style }| &&
                   COND #( WHEN c-state = 'v'
                    THEN |><a>{ c-bombs }</a>| " bombs value
                    ELSE " HTML events on cell (left: try; right: flag)
                     | oncontextmenu="setloc('sapevent:flg{ pos }');| &
                     |return false;"><a href="sapevent:try{ pos }">| &
                     |<div class="bx"/></a>| )
                   && `</td>` )
         && `</tr>` )
       && `</table><br>`
       && COND #(
           WHEN over = 'd' THEN `*** Bomb  -  Game over ***`
           WHEN over = 'w' THEN |Finished in { moves } moves!| )
       && `</body></html>` ).
  ENDMETHOD.

  METHOD at_click.
    IF over <> ''.  " game is over, final click
      cl_abap_browser=>close_browser( ).
      LEAVE PROGRAM.
    ENDIF.
    moves = moves + 1.
    DATA(x) = CONV i( action+4(2) ).
    DATA(y) = CONV i( action+7(2) ).
    ASSIGN field[ y ][ x ] TO FIELD-SYMBOL(<cell>).
    IF action(3) = 'try'.
      IF <cell>-bomb = 'X'.
        over = 'd'.  " hit bomb -> game over
      ELSE.
        detect( x = x y = y ).
      ENDIF.
    ELSE.  " action(3) = 'flg'
      IF <cell>-state = 'h'.
        <cell>-state = 'f'.  flags = flags + 1.  hidden = hidden - 1.
      ELSE.
        <cell>-state = 'h'.  flags = flags - 1.  hidden = hidden + 1.
      ENDIF.
    ENDIF.
    IF hidden = 0 AND flags = bombs .
      over = 'w'.  " all cells opened, all bombs found -> win
    ENDIF.
    display( ).
  ENDMETHOD.

  METHOD detect.
    CHECK x >= 1 AND x <= n AND y >= 1 AND y <= n.
    ASSIGN field[ y ][ x ] TO FIELD-SYMBOL(<cell>).
    CASE <cell>-state.
      WHEN 'v'.  RETURN.
      WHEN 'h'.  hidden = hidden - 1.
      WHEN 'f'.  flags = flags - 1.
    ENDCASE.
    <cell>-state = 'v'.
    CHECK <cell>-bombs = 0.
    DATA(u) = y - 1.
    DATA(d) = y + 1.
    DATA(l) = x - 1.
    DATA(r) = x + 1.
    detect( y = u x = l ).
    detect( y = u x = x ).
    detect( y = u x = r ).
    detect( y = y x = l ).
    detect( y = y x = r ).
    detect( y = d x = l ).
    detect( y = d x = x ).
    detect( y = d x = r ).
  ENDMETHOD.

ENDCLASS.

START-OF-SELECTION.
  NEW game( )->display( ).
