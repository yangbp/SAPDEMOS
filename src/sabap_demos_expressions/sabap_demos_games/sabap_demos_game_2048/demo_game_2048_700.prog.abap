PROGRAM demo_game_2048_700.

TYPE-POOLS abap.

CLASS game DEFINITION.
  PUBLIC SECTION.
    METHODS:
      constructor,
      display.
  PRIVATE SECTION.
    TYPES:
      BEGIN OF t_cell,
        value TYPE i,
        id    TYPE string,
        born  TYPE i,
      END OF t_cell,
      t_cells  TYPE STANDARD TABLE OF t_cell  WITH DEFAULT KEY,
      t_field  TYPE STANDARD TABLE OF t_cells WITH DEFAULT KEY,
      t_ref    TYPE REF TO t_cell,
      t_refs   TYPE STANDARD TABLE OF t_ref WITH DEFAULT KEY.
    CONSTANTS tile_colors TYPE string VALUE
      `eee4da ede0c8 f2b179 f59563 f67c5f f65e3b ` &
      `edcf72 f67c5f edc850 edc53f edc22e` ##NO_TEXT.
    DATA:
      mark_new_tiles TYPE abap_bool,
      rnd     TYPE REF TO cl_abap_random_int,
      field   TYPE t_field,
      n       TYPE i,             " dimension of field
      nsq     TYPE i,             " n * n
      target  TYPE i VALUE 2048,  " target value
      score   TYPE i,             " current score
      moves   TYPE i,             " # of moves
      header  TYPE string,        " HTML header string
      over    TYPE string,        " game-over message
      line    TYPE t_refs.
    METHODS:
      at_click FOR EVENT sapevent OF cl_abap_browser IMPORTING action,
      build_line IMPORTING VALUE(direction) TYPE char1 VALUE(i) TYPE i,
      move_lines IMPORTING VALUE(direction) TYPE char1
                 RETURNING VALUE(valid) TYPE abap_bool,
      move_line  RETURNING VALUE(valid) TYPE abap_bool,
      new_tiles  IMPORTING VALUE(factor) TYPE i DEFAULT 1,
      check_game.
ENDCLASS.

CLASS game IMPLEMENTATION.
  METHOD constructor.
    DATA: size TYPE i VALUE 4,
          seed TYPE i, limit TYPE i.
    DATA: x TYPE string, y TYPE string, s TYPE string.
    DATA: cell TYPE t_cell.
    FIELD-SYMBOLS <cells> TYPE t_cells.

    cl_demo_input=>add_field( CHANGING field = size ).
    cl_demo_input=>add_field( CHANGING field = target ).
    cl_demo_input=>add_field( EXPORTING text = 'Mark new tiles'
      as_checkbox = 'X'  CHANGING field = mark_new_tiles ) ##NO_TEXT.
    cl_demo_input=>request( ).
    n = size.
    IF     n < 3.  n = 3.
    ELSEIF n > 8.  n = 8.
    ENDIF.  " size: 3..8
    nsq = n * n.
    " target tile value must be a power of 2, at least 8
    IF target < 8.  target = 8.  ENDIF.
    target = 2 ** ceil( log( target ) / log( 2 ) ).

    seed = sy-uzeit. limit = nsq - 1.
    rnd = cl_abap_random_int=>create( seed = seed
                                      min  = 0
                                      max = limit ).
    cell-born = -1.
    DO n TIMES.
      y = sy-index. CONDENSE y.
      APPEND INITIAL LINE to field ASSIGNING <cells>.
      DO n TIMES.
        x = sy-index. CONDENSE x.
        CONCATENATE y x INTO cell-id.
        APPEND cell TO <cells>.
      ENDDO.
    ENDDO.
    new_tiles( 2 ).  " place initial tiles in field

    " build HTML header with styles for tiles;
    " cell/font sizes depend on n
    DATA w  TYPE string.  w  = trunc( 360 / n ).  CONDENSE w.
    DATA w2 TYPE string.  w2 = trunc( w / 2 ).    CONDENSE w2.
    DATA w3 TYPE string.  w3 = trunc( w / 3 ).    CONDENSE w3.
    DATA w4 TYPE string.  w4 = trunc( w / 4 ).    CONDENSE w4.
    header =
      `<html><head><style type="text/css">` &
      `.t0{background-color:#cbbdb0}` &
      `td{border:1px solid bbada0;color:#776e65` &
      `;text-align:center;vertical-align:center` &
      `;font-family:'Century Gothic',sans-serif;font-weight:bold`.
    CONCATENATE header `;width:` w `px;height:` w `px` INTO header.
    CONCATENATE header `;font-size:` w2 `px}` INTO header.
    DATA: pow TYPE i VALUE 2, off TYPE i.
    DO 11 TIMES.
      s = pow.  CONDENSE s.
      CONCATENATE header `.t` s `{background-color:#`
                  tile_colors+off(6) INTO header.
      pow = pow * 2.  off = off + 7.
      IF sy-index >= 3.
        CONCATENATE header `;color:#f9f6f2` INTO header.
      ENDIF.
      IF sy-index >= 10.
        CONCATENATE header `;font-size:` w4 `px` INTO header.
      ELSEIF sy-index >= 7.
        CONCATENATE header `;font-size:` w3 `px` INTO header.
      ENDIF.
      CONCATENATE header `}` INTO header.
    ENDDO.
    CONCATENATE header ##NO_TEXT
      `div{text-align:center}</style><script type="text/javascript">` &
      `function okd(e)` &
      `{c=window.event.keyCode;window.location='sapevent:'+c;}` &
      `document.onkeydown = okd;</script></head> <body scroll=no ` &
      `style="background-color:#bbada0;color:white;font-size:20pt">`
    INTO header.
    SET HANDLER at_click.
  ENDMETHOD.

  METHOD display.
    DATA: title TYPE cl_abap_browser=>title.
    DATA: html TYPE string, s TYPE string.
    FIELD-SYMBOLS: <cells> TYPE t_cells,
                   <cell>  TYPE t_cell.
    s = target.
    CONCATENATE `Join the numbers and get to the `
                s `tile` INTO title ##NO_TEXT.
    s = score.
    CONCATENATE header `<p align=right>Score ` s `</p>` &
                `<table align=center>` INTO html.
    LOOP AT field ASSIGNING <cells>.
      CONCATENATE html `<tr>` INTO html.
      LOOP AT <cells> ASSIGNING <cell>.
        s = <cell>-value. CONDENSE s.
        CONCATENATE html `<td class=t` s INTO html.
        IF <cell>-born = moves.
          CONCATENATE html ` style="border-color:red"` INTO html.
        ENDIF.
        IF <cell>-value = 0.
          s = `&nbsp;`.
        ENDIF.
        CONCATENATE html `>` s `</td>` INTO html.
      ENDLOOP.
      CONCATENATE html `</tr>` INTO html.
    ENDLOOP.
    IF over IS INITIAL.
      CONCATENATE html `</table><div>` &
       `Use arrow keys to join tiles</div></body></html>` INTO html.
    ELSE.
      CONCATENATE html `</table><br>` over `</body></html>` INTO html.
    ENDIF.
    cl_abap_browser=>show_html(
     title        = title
     size         = cl_abap_browser=>small
     format       = cl_abap_browser=>portrait
     context_menu = 'X'
     html_string  = html ).
  ENDMETHOD.

  METHOD at_click.
    DATA direction TYPE char1.
    CASE action.
      WHEN 37.  direction = 'L'.
      WHEN 38.  direction = 'U'.
      WHEN 39.  direction = 'R'.
      WHEN 40.  direction = 'D'.
    ENDCASE.
    IF over <> ``.  " game is over; leave game with any non-arrow key
      IF direction IS INITIAL.
        cl_abap_browser=>close_browser( ).
        LEAVE PROGRAM.
      ENDIF.
      RETURN.
    ENDIF.
    IF move_lines( direction ) = abap_true.
       moves = moves + 1.
       new_tiles( ).
       check_game( ).
       display( ).
    ENDIF.
  ENDMETHOD.

  METHOD check_game.
    DATA: max_value TYPE i, off TYPE i, idx TYPE i,
          empty_cell TYPE abap_bool.
    CONSTANTS dirs TYPE char4 VALUE 'LRUD'.
    " find highest tile value and check if an empty cell exists
    FIELD-SYMBOLS: <cells> TYPE t_cells,
                   <cell>  TYPE t_cell,
                   <curr>  TYPE t_ref,
                   <prev>  TYPE t_ref.
    LOOP AT field ASSIGNING <cells>.
      LOOP AT <cells> ASSIGNING <cell>.
        IF <cell>-value > max_value.
          max_value = <cell>-value.
        ENDIF.
        IF <cell>-value = 0.
          empty_cell = abap_true.
        ENDIF.
      ENDLOOP.
    ENDLOOP.
    " game is won if target value is reached
    IF max_value >= target.
      over = moves.
      CONCATENATE `<div>Finished in ` over `moves!</div>`
       INTO over ##NO_TEXT.
    ELSEIF empty_cell IS INITIAL.
      " no empty cell -> check if stuck: try move in all 4 directions
      DO 4 TIMES.
        off = sy-index - 1.
        DO n TIMES.
          build_line( direction = dirs+off(1) i = sy-index ).
          LOOP AT line FROM 2 ASSIGNING <curr>.
            idx = sy-tabix - 1.
            READ TABLE line INDEX idx ASSIGNING <prev>.
            IF <curr>->value = <prev>->value.
              RETURN.  " found a possible move; game not over
            ENDIF.
          ENDLOOP.
        ENDDO.
      ENDDO.
      over = `<div>*** Stuck  -  Game over ***</div>`.
    ENDIF.
  ENDMETHOD.

  METHOD move_lines.
    CHECK direction IS NOT INITIAL.
    DO n TIMES.
      build_line( direction = direction i = sy-index ).
      IF move_line( ) = abap_true.
        valid = abap_true.
      ENDIF.
    ENDDO.
    CLEAR line.
  ENDMETHOD.

  METHOD build_line.
    DATA: x TYPE i, y TYPE i, j TYPE i.
    DATA: r_cell TYPE t_ref.
    FIELD-SYMBOLS: <cells> TYPE t_cells.
    " build cell references to line i, starting at end (wrt direction)
    CLEAR line.
    j = n + 1.
    DO n TIMES.
      j = j - 1.
      CASE direction.
        WHEN 'L'.
          y = i.
          x = n + 1 - j.
        WHEN 'R'.
          y = i.
          x = j.
        WHEN 'U'.
          y = n + 1 - j.
          x = i.
        WHEN 'D'.
          y = j.
          x = i.
      ENDCASE.
      READ TABLE field   INDEX y ASSIGNING <cells>.
      READ TABLE <cells> INDEX x REFERENCE INTO r_cell.
      APPEND r_cell TO line.
    ENDDO.
  ENDMETHOD.

  METHOD move_line.
    DATA: idx TYPE i VALUE 1, next_idx TYPE i VALUE 2.
    DATA: curr TYPE t_ref, next TYPE t_ref.
    READ TABLE line INTO curr INDEX 1.
    WHILE next_idx <= n.
      READ TABLE line INTO next INDEX next_idx.
      IF curr->value > 0.
        IF curr->value = next->value.
          curr->value = curr->value * 2.  " join tiles
          next->value = 0.
          valid = abap_true.
          score = score + curr->value.
          idx = idx + 1.  " proceed
          READ TABLE line INTO curr INDEX idx.
        ELSEIF next->value > 0 OR next_idx = n.
          idx = idx + 1.  " proceed
          READ TABLE line INTO curr INDEX idx.
          next_idx = idx.
        ENDIF.
      ELSEIF next->value <> 0.
        curr->value = next->value.  " shift tile to empty cell
        next->value = 0.
        valid = abap_true.
      ENDIF.
      next_idx = next_idx + 1.
    ENDWHILE.
  ENDMETHOD.

  METHOD new_tiles.
    " place 1 or more (for n>4) new tiles (* 2 at start of game)
    DATA: num TYPE i, pos TYPE i, attempts TYPE i, threshold TYPE i.
    DATA: x type i, y TYPE i.
    FIELD-SYMBOLS: <cells> TYPE t_cells,
                   <cell>  TYPE t_cell.
    num = n - 3.
    IF num < 1.  num = 1.  ENDIF.
    num = num * factor.
    threshold = nsq / 4.
    DO num TIMES.
      pos = rnd->get_next( ).
      attempts = nsq.
      DO. " try to place new tile at this or next free position
        y = 1 + pos DIV n.
        x = 1 + pos MOD n.
        READ TABLE field   INDEX y ASSIGNING <cells>.
        READ TABLE <cells> INDEX x ASSIGNING <cell>.
        IF <cell>-value = 0.
          " free position found - tile value: 2 (likelihood 75%) or 4
          IF rnd->get_next( ) > threshold.
            <cell>-value = 2.
          ELSE.
            <cell>-value = 4.
          ENDIF.
          " remember when tile was born, to display it as 'new'
          <cell>-born = -1.
          IF moves > 0 AND mark_new_tiles = abap_true.
            <cell>-born = moves.
          ENDIF.
          EXIT.
        ENDIF.
        pos = ( pos + 1 ) MOD nsq.
        attempts = attempts - 1.
        IF attempts = 0.
          RETURN.
        ENDIF.
      ENDDO.
    ENDDO.
  ENDMETHOD.

ENDCLASS.

DATA
  my_game TYPE REF TO game.

START-OF-SELECTION.
  CREATE OBJECT my_game.
  my_game->display( ).
