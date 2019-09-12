PROGRAM demo_minesweeper_700.

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
      t_cells TYPE STANDARD TABLE OF t_cell  WITH DEFAULT KEY,
      t_field TYPE STANDARD TABLE OF t_cells WITH DEFAULT KEY.
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
    DATA: i         TYPE i,
          j         TYPE i,
          threshold TYPE i.
    DATA: cells TYPE t_cells,
          cell  TYPE t_cell.
    DATA r TYPE REF TO cl_abap_random_int.
    DATA wh TYPE string VALUE `width:13px;height:18px`.

    CONCATENATE ##NO_TEXT
     `<html><head><style type="text/css">`
     `.bx{text-decoration:none;cursor:hand;` wh `} a{` wh `}`
     `.hid{@#404080} .flg{@red} .bmb{@black}`
     `.b0{@#e0e0e0} .b1{@lightblue} .b2{@lightgreen} .b3{@orange}`
     `</style>`
     `<script>function setloc(e){window.location=e;}</script>`
     `</head><body scroll="no"><table border="0">` INTO header.
    REPLACE ALL OCCURRENCES OF `@` IN header WITH
     `background-color:` ##NO_TEXT.
    DATA size TYPE i VALUE 10.
    DATA level TYPE i VALUE 3.
    cl_demo_input=>add_field( CHANGING field = size ).
    cl_demo_input=>request(   CHANGING field = level ).
    IF     size < 2.
      n = 2.
    ELSEIF size > 32.
      n = 32.
    ELSE.
      n = size.
    ENDIF.  " size: 2..32
    IF     level < 1.
      level = 1.
    ELSEIF level > 5.
      level = 5.
    ENDIF.  " level: 1..5

    " place hidden bombs randomly
    i = sy-uzeit.
    r = cl_abap_random_int=>create( seed = i min = 0 max = 99 ).
    threshold = 100 - level * 10.
    cell-state = 'h'.  " initially all cells are hidden
    DO n TIMES.
      CLEAR cells.
      DO n TIMES.
        CLEAR cell-bomb.
        i = r->get_next( ).
        IF i > threshold.
          cell-bomb = 'X'.
        ENDIF.
        APPEND cell TO cells.
      ENDDO.
      APPEND cells TO field.
    ENDDO.

    " compute neighboring-bombs count for each cell, and overall count
    DATA: x TYPE i, y TYPE i.
    FIELD-SYMBOLS: <cells>  TYPE t_cells, <cell>  TYPE t_cell,
                   <cells1> TYPE t_cells, <cell1> TYPE t_cell.
    LOOP AT field ASSIGNING <cells>.
      y = sy-tabix.
      LOOP AT <cells> ASSIGNING <cell>.
        IF <cell>-bomb = 'X'.
          bombs = bombs + 1.
        ELSE.
          x = sy-tabix.
          DO 3 TIMES.
            i = y - 2 + sy-index.
            CHECK i >= 1 AND i <= n.
            DO 3 TIMES.
              j = x - 2 + sy-index.
              CHECK j >= 1 AND j <= n.
              READ TABLE field    INDEX i ASSIGNING <cells1>.
              READ TABLE <cells1> INDEX j ASSIGNING <cell1>.
              IF <cell1>-bomb = 'X'.
                ADD 1 TO <cell>-bombs.
              ENDIF.
            ENDDO.
          ENDDO.
        ENDIF.
      ENDLOOP.
    ENDLOOP.
    hidden = n * n.
    SET HANDLER at_click.
  ENDMETHOD.

  METHOD display.
    DATA: html  TYPE string, style TYPE string.
    DATA: title TYPE cl_abap_browser=>title.
    DATA: x TYPE i, y TYPE i.
    DATA: xn TYPE n LENGTH 2, yn TYPE n LENGTH 2.
    DATA: b     TYPE char1, b_lim TYPE char1.
    FIELD-SYMBOLS:
      <cells> TYPE t_cells, <cell> TYPE t_cell.
    html = header.

    LOOP AT field ASSIGNING <cells>.
      y = sy-tabix.  yn = y.
      CONCATENATE html '<tr' INTO html.
      IF over <> ''.
        CONCATENATE html ##NO_TEXT
         ` onclick="setloc('sapevent:ovr');"` INTO html.
      ENDIF.
      CONCATENATE html '>' INTO html.
      LOOP AT <cells> ASSIGNING <cell>.
        x = sy-tabix.  xn = x.
        WRITE <cell>-bombs TO b.
        b_lim = b.
        IF b_lim > '3'.  b_lim = '3'.  ENDIF.
        " determine CSS style (hid,flg,b0,...,b3) of cell
        IF over <> '' AND <cell>-bomb = 'X'.
          style = `bmb`.                    "cell with bomb (game over)
        ELSEIF <cell>-state = 'f'.
          style = `flg`.                    "cell flagged by player
        ELSEIF <cell>-state = 'v'.
          CONCATENATE 'b' b_lim INTO style. "visible cell
        ELSEIF over <> ''.
          style = `b0`.                     "empty cell (game over)
        ELSE.
          style = `hid`.                    "hidden cell
        ENDIF.
        CONCATENATE html '<td class=' style INTO html.
        IF <cell>-state = 'v'.
          CONCATENATE html '><a>' b '</a>' INTO html.  " bombs value
        ELSE.
          " HTML events on cell (left: try; right: flag)
          CONCATENATE html ##NO_TEXT
           ` oncontextmenu="setloc('sapevent:flg` 'x' xn 'y' yn `');`
           `return false;"><a href="sapevent:try` 'x' xn 'y' yn `">`
           `<div class="bx"/></a>`
           INTO html.
        ENDIF.
        CONCATENATE html `</td>` INTO html.
      ENDLOOP.
      CONCATENATE html `</tr>` INTO html.
    ENDLOOP.

    CONCATENATE html `</table><br>` INTO html.
    IF over = 'd'.
      CONCATENATE html `*** Bomb  -  Game over ***` INTO html.
    ELSEIF over = 'w'.
      DATA m TYPE string.  m = moves.  CONDENSE m.
      CONCATENATE html `Finished in ` m ` moves!` INTO html ##NO_TEXT.
    ENDIF.
    CONCATENATE html `</body></html>` INTO html.

    DATA size TYPE string.
    IF n < 20.
      size = cl_abap_browser=>small.
    ELSE.
      size = cl_abap_browser=>medium.
    ENDIF.
    title = sy-title.
    cl_abap_browser=>show_html(
     title        = title
     size         = size
     format       = cl_abap_browser=>portrait
     context_menu = 'X'
     html_string  = html ).
  ENDMETHOD.

  METHOD at_click.
    DATA: x TYPE i, y TYPE i.
    FIELD-SYMBOLS:
      <cells> TYPE t_cells, <cell> TYPE t_cell.

    IF over <> ''.  " game is over, final click
      cl_abap_browser=>close_browser( ).
      LEAVE PROGRAM.
    ENDIF.
    moves = moves + 1.
    x = action+4(2).
    y = action+7(2).
    READ TABLE field   INDEX y ASSIGNING <cells>.
    READ TABLE <cells> INDEX x ASSIGNING <cell>.

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
    IF hidden = 0 AND flags = bombs.
      over = 'w'.  " all cells opened, all bombs found -> win
    ENDIF.
    display( ).
  ENDMETHOD.

  METHOD detect.
    DATA: u TYPE i, d TYPE i, l TYPE i, r TYPE i.
    FIELD-SYMBOLS:
      <cells> TYPE t_cells, <cell> TYPE t_cell.

    CHECK x >= 1 AND x <= n AND y >= 1 AND y <= n.
    READ TABLE field   INDEX y ASSIGNING <cells>.
    READ TABLE <cells> INDEX x ASSIGNING <cell>.
    CASE <cell>-state.
      WHEN 'v'.  RETURN.
      WHEN 'h'.  hidden = hidden - 1.
      WHEN 'f'.  flags = flags - 1.
    ENDCASE.
    <cell>-state = 'v'.
    CHECK <cell>-bombs = 0.
    u = y - 1.  d = y + 1.  l = x - 1.  r = x + 1.
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

DATA:
  my_game TYPE REF TO game.

START-OF-SELECTION.
  CREATE OBJECT my_game.
  my_game->display( ).
