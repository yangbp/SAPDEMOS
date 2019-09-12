class cl_demo_sql_chess definition
  public
  create private .

  public section.

    types:
      begin of gty_settings.
    types color type demo_chess_color.
    types castling_white_long type demo_chess_castling.
    types castling_white_short type demo_chess_castling.
    types castling_black_long type demo_chess_castling.
    types castling_black_short type demo_chess_castling.
    types end of gty_settings .
    types:
      begin of gty_position.
    types chessman type demo_chess_chessman.
    types color type demo_chess_color.
    types x type demo_chess_xpos.
    types y type demo_chess_ypos.
    types before_x type demo_chess_xpos.
    types before_y type demo_chess_ypos.
    types end of gty_position .
    types:
      gtt_positions type sorted table of gty_position with unique key x y .
    types:
      begin of gty_moves.
    types chessman type demo_chess_chessman.
    types color type demo_chess_color.
    types from_x type demo_chess_xpos.
    types from_y type demo_chess_ypos.
    types to_x type demo_chess_xpos.
    types to_y type demo_chess_ypos.
    types is_castling_black_long type abap_bool.
    types is_castling_black_short type abap_bool.
    types is_castling_white_long type abap_bool.
    types is_castling_white_short type abap_bool.
    types end of gty_moves .
    types:
      gtt_moves type sorted table of gty_moves with unique key from_x from_y to_x to_y .

    constants c_color_white type demo_chess_color value 'W' ##NO_TEXT.
    constants c_color_black type demo_chess_color value 'B' ##NO_TEXT.
    constants c_color_invalid type demo_chess_color value '-' ##NO_TEXT.
    constants c_chessman_king type demo_chess_chessman value 'K' ##NO_TEXT.
    constants c_chessman_queen type demo_chess_chessman value 'Q' ##NO_TEXT.
    constants c_chessman_rook type demo_chess_chessman value 'R' ##NO_TEXT.
    constants c_chessman_knight type demo_chess_chessman value 'N' ##NO_TEXT.
    constants c_chessman_bishop type demo_chess_chessman value 'B' ##NO_TEXT.
    constants c_chessman_pawn type demo_chess_chessman value space ##NO_TEXT.
    constants c_chessman_invalid type demo_chess_chessman value '-' ##NO_TEXT.
    constants c_special_flag_none type demo_chess_special_flag value space ##NO_TEXT.
    constants c_special_flag_pawn type demo_chess_special_flag value 'P' ##NO_TEXT.
    constants c_special_flag_castling type demo_chess_special_flag value 'C' ##NO_TEXT.
    constants c_special_flag_empty type demo_chess_special_flag value 'E' ##NO_TEXT.
    constants c_position_invalid type int1 value 0 ##NO_TEXT.
    constants c_moves_cnt type i value 7620 ##NO_TEXT.
    data gv_gameuuid type demo_chess_gameuuid read-only .
    data gv_movecnt type i read-only value 0 ##NO_TEXT.

    class-methods factory
      importing
        !iv_uuid         type sysuuid_c32 optional
        !io_uuid_factory type ref to if_system_uuid optional
      returning
        value(rv_ref)    type ref to cl_demo_sql_chess
      raising
        cx_demo_sql_chess .
    class-methods factory_from_position
      importing
        !is_settings     type cl_demo_sql_chess=>gty_settings
        !it_positions    type cl_demo_sql_chess=>gtt_positions
        !io_uuid_factory type ref to if_system_uuid optional
      returning
        value(rv_ref)    type ref to cl_demo_sql_chess
      raising
        cx_demo_sql_chess .
    methods delete
      raising
        cx_demo_sql_chess .
    methods release
      raising
        cx_demo_sql_chess .
    methods resume
      raising
        cx_demo_sql_chess .
    methods get_next_moves
      exporting
        !et_moves          type gtt_moves
      returning
        value(ev_flg_mate) type abap_bool
      raising
        cx_demo_sql_chess .
    methods move
      importing
        !iv_chessman          type demo_chess_chessman
        !iv_color             type demo_chess_color
        !iv_from_x            type demo_chess_xpos
        !iv_from_y            type demo_chess_ypos
        !iv_to_x              type demo_chess_xpos
        !iv_to_y              type demo_chess_ypos
      returning
        value(rv_flg_success) type abap_bool
      raising
        cx_demo_sql_chess .
private section.

  data GV_FLG_RELEASED type ABAP_BOOL value ABAP_FALSE ##NO_TEXT.
  data GV_FLG_MOVE_WRITE_LOCK type ABAP_BOOL value ABAP_FALSE ##NO_TEXT.
  data GV_FLG_MOVE_LOCK type ABAP_BOOL value ABAP_FALSE ##NO_TEXT.
  data GV_FLG_GAME_LOCK type ABAP_BOOL value ABAP_FALSE ##NO_TEXT.

  methods CHECK_NOT_RELEASED
    raising
      CX_DEMO_SQL_CHESS .
  methods LOCK_MOVES
    importing
      !IV_FLG_READ type ABAP_BOOL default ABAP_TRUE
    raising
      CX_DEMO_SQL_CHESS .
  methods UNLOCK_MOVES
    importing
      !IV_FLG_READ type ABAP_BOOL default ABAP_TRUE .
  methods LOCK_GAME
    raising
      CX_DEMO_SQL_CHESS .
  methods UNLOCK_GAME .
  methods CONSTRUCTOR
    importing
      !IV_FLG_NEW_GAME type ABAP_BOOL
      !IO_UUID_FACTORY type ref to IF_SYSTEM_UUID
      !IS_SETTINGS type CL_DEMO_SQL_CHESS=>GTY_SETTINGS optional
      !IT_POSITIONS type CL_DEMO_SQL_CHESS=>GTT_POSITIONS optional
      !IV_GAMEUUID type SYSUUID_C32 optional
    raising
      CX_DEMO_SQL_CHESS .
  methods GENERATE_MOVES
    raising
      CX_DEMO_SQL_CHESS .
  methods EXISTING_GAME
    importing
      !IS_SETTINGS type CL_DEMO_SQL_CHESS=>GTY_SETTINGS
      !IT_POSITIONS type CL_DEMO_SQL_CHESS=>GTT_POSITIONS
    raising
      CX_DEMO_SQL_CHESS .
  methods NEW_GAME .
  methods CHECK_GAME
    importing
      !IV_MOVECNT type I
    raising
      CX_DEMO_SQL_CHESS .
  methods RAISE
    importing
      !IS_T100KEY like IF_T100_MESSAGE=>T100KEY
      !IV_FLG_ROLLBACK type ABAP_BOOL
      !IV_FLG_RAISE type ABAP_BOOL default ABAP_TRUE
    raising
      CX_DEMO_SQL_CHESS .
  methods RELEASE_INTERNAL .
ENDCLASS.



CLASS CL_DEMO_SQL_CHESS IMPLEMENTATION.


  method check_game.
    " check basic validity => no more than 2 kings and no white pawns on row 1 and no black pawns on row 8
    select sum( case when color    = @cl_demo_sql_chess=>c_color_black  and
                          chessman = @cl_demo_sql_chess=>c_chessman_king then 1 else 0 end ) as black_kings,
           sum( case when color    = @cl_demo_sql_chess=>c_color_white  and
                          chessman = @cl_demo_sql_chess=>c_chessman_king then 1 else 0 end ) as white_kings,
           sum( case when color    = @cl_demo_sql_chess=>c_color_black  and
                          chessman = @cl_demo_sql_chess=>c_chessman_pawn and
                          y        = 8 then 1 else 0 end ) as black_pawns,
           sum( case when color    = @cl_demo_sql_chess=>c_color_white  and
                          chessman = @cl_demo_sql_chess=>c_chessman_pawn and
                          y        = 1 then 1 else 0 end ) as white_pawns,
           sum( case when y < 1 or y > 8 or x < 1 or x > 8 then 1 else 0 end ) as invalid_coordinates,
           sum( case when chessman = @cl_demo_sql_chess=>c_chessman_bishop or
                          chessman = @cl_demo_sql_chess=>c_chessman_king or
                          chessman = @cl_demo_sql_chess=>c_chessman_knight or
                          chessman = @cl_demo_sql_chess=>c_chessman_pawn or
                          chessman = @cl_demo_sql_chess=>c_chessman_queen or
                          chessman = @cl_demo_sql_chess=>c_chessman_rook then 0 else 1 end ) as invalid_chessman,
           sum( case when color = @cl_demo_sql_chess=>c_color_black and
                          chessman = @cl_demo_sql_chess=>c_chessman_pawn then 1 else 0 end ) as black_pawns_total,
           sum( case when color = @cl_demo_sql_chess=>c_color_white and
                          chessman = @cl_demo_sql_chess=>c_chessman_pawn then 1 else 0 end ) as white_pawns_total
           from demo_chess_pos
           where gameuuid = @gv_gameuuid and movecnt = @iv_movecnt into @data(ls_check).
    if ls_check-black_kings <> 1 or ls_check-white_kings <> 1 or ls_check-black_pawns <> 0 or ls_check-white_pawns <> 0
      or ls_check-invalid_coordinates <> 0 or ls_check-invalid_chessman <> 0 or ls_check-black_pawns_total > 8 or
      ls_check-white_pawns_total > 8.
      raise( exporting is_t100key = cx_demo_sql_chess=>invalid_chess_position
                       iv_flg_rollback = abap_true ).
    endif.
  endmethod.


  method check_not_released.
    if gv_flg_released = abap_true.
      raise( exporting is_t100key = cx_demo_sql_chess=>instance_is_released
                       iv_flg_rollback = abap_false ).
    endif.
    assert gv_flg_game_lock = abap_true.
    assert gv_flg_move_lock = abap_true.
  endmethod.


  method constructor.
    " moves must be generated first => if an exception occurs here, no game should
    " be created.
    lock_moves( iv_flg_read = abap_true ). " read lock for moves
    select count(*) from demo_chess_moves.
    if sy-subrc <> 0 or sy-dbcnt <> c_moves_cnt.
      generate_moves( ).
    endif.
    if iv_flg_new_game = abap_true.
      assert io_uuid_factory is not initial.
      try.
          gv_gameuuid = io_uuid_factory->create_uuid_c32( ).
        catch cx_uuid_error.
          raise( exporting is_t100key = cx_demo_sql_chess=>uuid_error
                           iv_flg_rollback = abap_false ).
      endtry.
      lock_game( ). " lock
      select count(*) from demo_chess_game where gameuuid = @gv_gameuuid.
      if sy-subrc = 0.
        raise( exporting is_t100key = cx_demo_sql_chess=>uuid_error
                         iv_flg_rollback = abap_false ).
      endif.
      if it_positions is not supplied.
        new_game( ).
      else.
        existing_game( is_settings = is_settings it_positions = it_positions ).
      endif.
    else.
      gv_gameuuid = iv_gameuuid.
      lock_game( ). " read lock
      select single movecnt from demo_chess_game
        where gameuuid = @iv_gameuuid into @gv_movecnt.
      if sy-subrc <> 0.
        raise( exporting is_t100key = cx_demo_sql_chess=>game_not_found
                         iv_flg_rollback = abap_false ).
      endif.
    endif.
  endmethod.


  method delete.
    assert gv_gameuuid is not initial.
    check_not_released( ).
    delete from demo_chess_game where gameuuid = gv_gameuuid.
    delete from demo_chess_pos where gameuuid = gv_gameuuid.
    release( ).
  endmethod.


  method existing_game.
    insert into demo_chess_game values @(
      value #( gameuuid = gv_gameuuid movecnt = 0 color = is_settings-color
               castling_white_long = is_settings-castling_white_long
               castling_white_short = is_settings-castling_white_short
               castling_black_long = is_settings-castling_black_long
               castling_black_short = is_settings-castling_black_short
    ) ).
    insert demo_chess_pos from table @(
      value #( for line in it_positions
               ( gameuuid = gv_gameuuid
                 color    = line-color
                 movecnt  = 0
                 chessman = line-chessman
                 x        = line-x
                 y        = line-y
                 before_x = cond #( when line-before_x is initial then line-x else line-before_x )
                 before_y = cond #( when line-before_y is initial then line-y else line-before_y )
               )
             )
    ).
    check_game( iv_movecnt = 0 ).
  endmethod.


  method factory.
    rv_ref = new #( iv_flg_new_game = cond #( when iv_uuid is initial then abap_true else abap_false )
                    io_uuid_factory = cond #( when io_uuid_factory is not initial or iv_uuid is not initial then io_uuid_factory
                                              else cl_uuid_factory=>create_system_uuid( ) )
                    iv_gameuuid = iv_uuid ).
  endmethod.


  method factory_from_position.
    rv_ref = new #( iv_flg_new_game = abap_true
                    io_uuid_factory = cond #( when io_uuid_factory is not initial then io_uuid_factory
                                              else cl_uuid_factory=>create_system_uuid( ) )
                    it_positions = it_positions
                    is_settings  = is_settings ).
  endmethod.


  method generate_moves.
    lock_moves( iv_flg_read = abap_false ).
    delete from demo_chess_pos_t.
    delete from demo_chess_cm_t.
    delete from demo_chess_col_t.
    delete from demo_chess_moves where color = demo_chess_moves~color.
    " insert all possible chess positions (e.g. x,y values) into table demo_chess_pos_t
    insert demo_chess_pos_t from table @(
      value #( for i = 1 then i + 1 while i <= 8
                 for j = 1 then j + 1 while j <= 8
                ( x_pos = i y_pos = j )
    ) ).
    " insert all possible chessman into table demo_chess_cm_t
    insert demo_chess_cm_t from table @(
      value #( ( chessman = c_chessman_king   )
               ( chessman = c_chessman_queen  )
               ( chessman = c_chessman_rook   )
               ( chessman = c_chessman_knight )
               ( chessman = c_chessman_bishop )
               ( chessman = c_chessman_pawn   )
    ) ).
    " insert all different colors into table demo_chess_col_t
    insert demo_chess_col_t from table @( value #(
      ( color = c_color_white )
      ( color = c_color_black )
    ) ).
    " generate all possible chess moves (if only 1 chessman is on the board) into demo_chess_moves
    " special moves like en passant and castling (rochade) are marked specially and considered into account
    " the table is constructed like follows:
    " COLOR => color of the chessman (is important for pawns/kings only, but is generated two times for all other chessman, too)
    " CHESSMAN => type of chessman
    " FROM_X  => from x position, i.e. 1 .. 8 which means A, ..., H
    " FROM_Y  => from y position, i.e. 1 .. 8
    " TO_X => to x position, i.e. 1 .. 8 which means A, ..., H
    " TO_Y => to y position, i.e. 1 .. 8
    " SPECIAL_FLAG => normal move or special move
    "                 'P' (pawn) means that the move can only be done, if on the target field an enemy chessman is present
    "                     _OR_ when en passant can be made. For "en passant" the following columns COLOR_DEP, CHESSMAN_DEP, FROM_X_DEP, etc.
    "                     contain the preceeding move of the enemy
    "                 'E' may only move, if the field is empty (for pawns)
    "                 'C' (castling) means the the move has to be done _together_ with another move which is contained in COLOR_DEP, CHESSMAN_DEP, FROM_X_DEP, etc.
    "                     this happens during castling (i.e. "Rochade").
    " COLOR_DEP => color of the dependent move's chessman. is always the _same_ colour for castling or the opponents colour for en passant
    " CHESSMAN_DEP => chessman allowed to do the dependent's move
    " FROM_X_DEP => from x (dependent)
    " FROM_Y_DEP => from y (dependent)
    " TO_X_DEP => to x (dependent)
    " TO_Y_DEP => to y (dependent)
    insert demo_chess_moves from (
      select
      from demo_chess_col_t as color
        inner join demo_chess_cm_t as chessman on 1 = 1
        inner join demo_chess_pos_t as source on 1 = 1
        inner join demo_chess_pos_t as target on
        case chessman
          when @c_chessman_king then
             case when ( abs( source~x_pos - target~x_pos ) <= 1 and                                " normal king movement
                         abs( source~y_pos - target~y_pos ) <= 1 and not
                         ( source~x_pos = target~x_pos and source~y_pos = target~y_pos ) ) or
                       ( color = @c_color_white and source~x_pos = 5             " castling
                         and source~y_pos = 1 and target~x_pos = 7 and target~y_pos = 1 ) or
                       ( color = @c_color_white and source~x_pos = 5
                         and source~y_pos = 1 and target~x_pos = 3 and target~y_pos = 1 ) or
                       ( color = @c_color_black and source~x_pos = 5             " castling
                         and source~y_pos = 8 and target~x_pos = 7 and target~y_pos = 1 ) or
                       ( color = @c_color_black and source~x_pos = 5
                         and source~y_pos = 8 and target~x_pos = 3 and target~y_pos = 1 )
             then 1 else 0 end
          when @c_chessman_queen then
             case when ( abs( target~y_pos - source~y_pos ) = abs( target~x_pos - source~x_pos ) or
                         target~x_pos = source~x_pos or
                         target~y_pos = source~y_pos ) and not
                       ( source~x_pos = target~x_pos and source~y_pos = target~y_pos )
             then 1 else 0 end
          when @c_chessman_rook then
             case when ( target~x_pos = source~x_pos or
                         target~y_pos = source~y_pos ) and not
                       ( source~x_pos = target~x_pos and source~y_pos = target~y_pos )
             then 1 else 0 end
          when @c_chessman_knight then
             case when ( abs( target~x_pos - source~x_pos ) = 1 and
                         abs( target~y_pos - source~y_pos ) = 2 ) or
                       ( abs( target~x_pos - source~x_pos ) = 2 and
                         abs( target~y_pos - source~y_pos ) = 1 )
             then 1 else 2 end
          when @c_chessman_bishop then
             case when abs( target~y_pos - source~y_pos ) = abs( target~x_pos - source~x_pos ) and not
                      ( source~x_pos = target~x_pos and source~y_pos = target~y_pos )
             then 1 else 0 end
          when @c_chessman_pawn then
             case when ( color = @c_color_white and " white pawn move 1 field
                         target~y_pos = source~y_pos + 1 and
                         abs( target~x_pos - source~x_pos ) <= 1 and
                         source~y_pos > 1
                       ) or
                       ( color = @c_color_white and " white pawn move 2 fields
                         target~y_pos = 4 and
                         source~y_pos = 2 and
                         target~x_pos = source~x_pos ) or
                       ( color = @c_color_black and " black pawn move 1 field
                         target~y_pos = source~y_pos - 1 and
                         abs( target~x_pos - source~x_pos ) <= 1 and
                         source~y_pos < 8 ) or
                       ( color = @c_color_black and " black pawn move 2 fields
                         target~y_pos = 5 and
                         source~y_pos = 7 and
                         target~x_pos = source~x_pos )
             then 1 else 0 end
        end = 1
      fields color, chessman, source~x_pos, source~y_pos, target~x_pos, target~y_pos,
        coalesce(
          case chessman
            when @c_chessman_king then case when ( color = @c_color_white and source~x_pos = 5             " castling
                            and source~y_pos = 1 and target~x_pos = 7 and target~y_pos = 1 ) or
                           ( color = @c_color_white and source~x_pos = 5
                            and source~y_pos = 1 and target~x_pos = 3 and target~y_pos = 1 ) or
                           ( color = @c_color_black and source~x_pos = 5             " castling
                            and source~y_pos = 8 and target~x_pos = 7 and target~y_pos = 1 ) or
                           ( color = @c_color_black and source~x_pos = 5
                             and source~y_pos = 8 and target~x_pos = 3 and target~y_pos = 1 )
                        then @c_special_flag_castling
                        end
            when @c_chessman_pawn then case when abs( target~x_pos - source~x_pos ) = 1 " special rule for pawns => they may only move diagonal
                                                                 then @c_special_flag_pawn
                                                                 else @c_special_flag_empty
                                                          end " if there is some chessman on the target field or en passant
          end
        , @c_special_flag_none ),
        coalesce(
          case chessman
            when @c_chessman_king then case when abs( target~x_pos - source~x_pos ) > 1
                                                            then color
                                                          end
            when @c_chessman_pawn then
              case when abs( target~x_pos - source~x_pos ) = 1 and (  " en passant => color
                        color = @c_color_white and
                        source~y_pos = 5 and
                        target~y_pos = 6 )
                   then @c_color_black
                   when abs( target~x_pos - source~x_pos ) = 1 and (
                     color = @c_color_black and
                     source~y_pos = 4 and
                     target~y_pos = 3 )
                   then @c_color_white
              end
           end
           , @c_color_invalid ),
        coalesce(
          case chessman
            when @c_chessman_king then case when abs( target~x_pos - source~x_pos ) > 1
                                                            then @c_chessman_rook
                                                          end
            when @c_chessman_pawn then
              case when abs( target~x_pos - source~x_pos ) = 1 and (  " en passant/castling => chessman
                        color = @c_color_white and
                        source~y_pos = 5 and
                        target~y_pos = 6 )
                   then @c_chessman_pawn
                   when abs( target~x_pos - source~x_pos ) = 1 and (
                     color = @c_color_black and
                     source~y_pos = 4 and
                     target~y_pos = 3 )
                   then @c_chessman_pawn
              end
           end
           , @c_chessman_invalid ),
        coalesce(
          case chessman
            when @c_chessman_king then
              case when ( color = @c_color_white and source~x_pos = 5             " castling
                          and source~y_pos = 1 and target~x_pos = 7 and target~y_pos = 1 )
                     then cast( 8 as int1 )
                   when ( color = @c_color_white and source~x_pos = 5
                          and source~y_pos = 1 and target~x_pos = 3 and target~y_pos = 1 )
                     then cast( 1 as int1 )
                   when ( color = @c_color_black and source~x_pos = 5             " castling
                          and source~y_pos = 8 and target~x_pos = 7 and target~y_pos = 1 )
                      then cast( 8 as int1 )
                   when ( color = @c_color_black and source~x_pos = 5
                          and source~y_pos = 8 and target~x_pos = 3 and target~y_pos = 1 )
                      then cast( 1 as int1 )
             end
            when @c_chessman_pawn then
              case when abs( target~x_pos - source~x_pos ) = 1 and (  " en passant/castling => x_from_dep
                        color = @c_color_white and
                        source~y_pos = 5 and
                        target~y_pos = 6 )
                   then target~x_pos
                   when abs( target~x_pos - source~x_pos ) = 1 and (
                     color = @c_color_black and
                     source~y_pos = 4 and
                     target~y_pos = 3 )
                   then target~x_pos
              end
           end
           , @c_position_invalid ),
        coalesce(
          case chessman
            when @c_chessman_king then
              case when ( color = @c_color_white and source~x_pos = 5             " castling
                          and source~y_pos = 1 and target~x_pos = 7 and target~y_pos = 1 )
                     then cast( 1 as int1 )
                   when ( color = @c_color_white and source~x_pos = 5
                          and source~y_pos = 1 and target~x_pos = 3 and target~y_pos = 1 )
                     then cast( 1 as int1 )
                   when ( color = @c_color_black and source~x_pos = 5             " castling
                          and source~y_pos = 8 and target~x_pos = 7 and target~y_pos = 1 )
                      then cast( 8 as int1 )
                   when ( color = @c_color_black and source~x_pos = 5
                          and source~y_pos = 8 and target~x_pos = 3 and target~y_pos = 1 )
                      then cast( 8 as int1 )
             end
            when @c_chessman_pawn then
              case when abs( target~x_pos - source~x_pos ) = 1 and (  " en passant/castling => y_from_dep
                        color = @c_color_white and
                        source~y_pos = 5 and
                        target~y_pos = 6 )
                   then cast( 7 as int1 )
                   when abs( target~x_pos - source~x_pos ) = 1 and (
                     color = @c_color_black and
                     source~y_pos = 4 and
                     target~y_pos = 3 )
                   then cast( 2 as int1 )
              end
           end
           , @c_position_invalid ),
        coalesce(
          case chessman
            when @c_chessman_king then
              case when ( color = @c_color_white and source~x_pos = 5             " castling
                          and source~y_pos = 1 and target~x_pos = 7 and target~y_pos = 1 )
                     then cast( 6 as int1 )
                   when ( color = @c_color_white and source~x_pos = 5
                          and source~y_pos = 1 and target~x_pos = 3 and target~y_pos = 1 )
                     then cast( 4 as int1 )
                   when ( color = @c_color_black and source~x_pos = 5             " castling
                          and source~y_pos = 8 and target~x_pos = 7 and target~y_pos = 1 )
                      then cast( 6 as int1 )
                   when ( color = @c_color_black and source~x_pos = 5
                          and source~y_pos = 8 and target~x_pos = 3 and target~y_pos = 1 )
                      then cast( 4 as int1 )
             end
            when @c_chessman_pawn then
              case when abs( target~x_pos - source~x_pos ) = 1 and (  " en passant/castling => x_to_dep
                        color = @c_color_white and
                        source~y_pos = 5 and
                        target~y_pos = 6 )
                   then target~x_pos
                   when abs( target~x_pos - source~x_pos ) = 1 and (
                     color = @c_color_black and
                     source~y_pos = 4 and
                     target~y_pos = 3 )
                   then target~x_pos
              end
           end
           , @c_position_invalid ),
        coalesce(
          case chessman
            when @c_chessman_king then
              case when ( color = @c_color_white and source~x_pos = 5             " castling
                          and source~y_pos = 1 and target~x_pos = 7 and target~y_pos = 1 )
                     then cast( 1 as int1 )
                   when ( color = @c_color_white and source~x_pos = 5
                          and source~y_pos = 1 and target~x_pos = 3 and target~y_pos = 1 )
                     then cast( 1 as int1 )
                   when ( color = @c_color_black and source~x_pos = 5             " castling
                          and source~y_pos = 8 and target~x_pos = 7 and target~y_pos = 1 )
                      then cast( 8 as int1 )
                   when ( color = @c_color_black and source~x_pos = 5
                          and source~y_pos = 8 and target~x_pos = 3 and target~y_pos = 1 )
                      then cast( 8 as int1 )
             end
            when @c_chessman_pawn then
              case when abs( target~x_pos - source~x_pos ) = 1 and (  " en passant/castling => y_to_dep
                        color = @c_color_white and
                        source~y_pos = 5 and
                        target~y_pos = 6 )
                   then cast( 5 as int1 )
                   when abs( target~x_pos - source~x_pos ) = 1 and (
                     color = @c_color_black and
                     source~y_pos = 4 and
                     target~y_pos = 3 )
                   then cast( 4 as int1 )
              end
           end
           , @c_position_invalid ),
        case chessman
          when @c_chessman_pawn then
            case when ( target~y_pos = 1 and color = @c_color_black ) or
                      ( target~y_pos = 8 and color = @c_color_white )
                 then @abap_true
                 else @abap_false
            end
          else @abap_false
        end
    ).
    delete from demo_chess_pos_t.
    delete from demo_chess_cm_t.
    delete from demo_chess_col_t.
    unlock_moves( iv_flg_read = abap_false ).
  endmethod.


  method get_next_moves.
    check_not_released( ).
    " because DB4 can only handle 225 tables, this logic is now much more complicated, on
    " hana, you can write a view !
    delete from demo_chess_stp12.
    insert demo_chess_stp12 from (
      select from demo_chess_v_stage8 as allowed
             left outer join demo_chess_v_stage11 as forbidden
             on  allowed~gameuuid = forbidden~gameuuid and
                 allowed~movecnt  = forbidden~movecnt  and
                 allowed~move_color = forbidden~move_color and
                 allowed~move_chessman = forbidden~move_chessman and
                 allowed~move_from_x = forbidden~move_from_x and
                 allowed~move_from_y = forbidden~move_from_y and
                 allowed~move_to_x = forbidden~move_to_x and
                 allowed~move_to_y = forbidden~move_to_y and
                 allowed~color    = forbidden~color    and
                 allowed~chessman = forbidden~chessman and
                 allowed~from_x   = forbidden~from_x   and
                 allowed~from_y   = forbidden~from_y   and
                 allowed~to_x     = forbidden~to_x     and
                 allowed~to_y     = forbidden~to_y
      fields distinct
             allowed~gameuuid,
             allowed~movecnt,
             allowed~move_color,
             allowed~move_chessman,
             allowed~move_from_x,
             allowed~move_from_y,
             allowed~move_to_x,
             allowed~move_to_y,
             allowed~color,
             allowed~chessman,
             allowed~from_x,
             allowed~from_y,
             allowed~to_x,
             allowed~to_y,
             " we can only have 16 key fields, use concat to disambiguate
             concat( concat( concat( concat( concat( concat( concat( concat( concat( concat( concat(
             concat( coalesce( allowed~special_flag, '#' ), '#' ),
             concat( coalesce( allowed~color_dep, '#' ), '#' ) ),
             concat( coalesce( allowed~chessman_dep, '#' ), '#' ) ),
             concat( coalesce( cast( allowed~from_x_dep as char( 3 ) ), '#' ), '#' ) ),
             concat( coalesce( cast( allowed~from_y_dep as char( 3 ) ), '#' ), '#' ) ),
             concat( coalesce( cast( allowed~to_x_dep as char( 3 ) ), '#' ), '#' ) ),
             concat( coalesce( cast( allowed~to_y_dep as char( 3 ) ), '#' ), '#' ) ),
             concat( coalesce( allowed~transform_pawn_flag, '#' ), '#' ) ),
             concat( coalesce( allowed~castling_black_long, '#' ), '#' ) ),
             concat( coalesce( allowed~castling_black_short, '#' ), '#' ) ),
             concat( coalesce( allowed~castling_white_long, '#' ), '#' ) ),
             concat( coalesce( allowed~castling_white_short, '#' ), '#' ) ) as other_fields,
             allowed~special_flag,
             allowed~color_dep,
             allowed~chessman_dep,
             allowed~from_x_dep,
             allowed~from_y_dep,
             allowed~to_x_dep,
             allowed~to_y_dep,
             allowed~transform_pawn_flag,
             allowed~castling_black_long,
             allowed~castling_black_short,
             allowed~castling_white_long,
             allowed~castling_white_short
     where forbidden~gameuuid is null and
           allowed~gameuuid = @gv_gameuuid and
           allowed~movecnt = @gv_movecnt
    ).
    select * from demo_chess_v_allowed
      where gameuuid = @gv_gameuuid and
            movecnt  = @gv_movecnt
      into corresponding fields of table @et_moves.
    delete from demo_chess_stp12.
    ev_flg_mate = cond #( when lines( et_moves ) = 0 then abap_true else abap_false ).
  endmethod.


  method lock_game.
    assert gv_flg_game_lock = abap_false.
    call function 'ENQUEUE_EDEMO_CHESS_GAME'
      exporting
        mode_demo_chess_game = 'X'
        client               = sy-mandt
        gameuuid             = gv_gameuuid
        _scope               = '1'
        _wait                = 'X'
        _collect             = ' '
      exceptions
        foreign_lock         = 1
        system_failure       = 2
        others               = 3.
    if sy-subrc <> 0.
      raise( exporting is_t100key = cx_demo_sql_chess=>no_write_lock_game
                       iv_flg_rollback = abap_false ).
    endif.
    gv_flg_game_lock = abap_true.
  endmethod.


  method lock_moves.
    call function 'ENQUEUE_EDEMO_CHESS_MOVE'
      exporting
        mode_demo_chess_moves = cond #( when iv_flg_read = abap_true then 'S' else 'E' )
        client                = sy-mandt
        _scope                = '1'
        _wait                 = 'X'
        _collect              = ' '
      exceptions
        foreign_lock          = 1
        system_failure        = 2
        others                = 3.
    if sy-subrc <> 0.
      raise( exporting is_t100key = cond #( when iv_flg_read = abap_true then cx_demo_sql_chess=>no_read_lock_moves
                                            else cx_demo_sql_chess=>no_write_lock_moves )
                       iv_flg_rollback = abap_false ).
    endif.
    if iv_flg_read = abap_true.
      assert gv_flg_move_lock = abap_false.
      gv_flg_move_lock = abap_true.
    else.
      assert gv_flg_move_write_lock = abap_false.
      gv_flg_move_write_lock = abap_true.
    endif.
  endmethod.


  method move.
    check_not_released( ).
    select from demo_chess_v_next
             fields gameuuid, movecnt + 1 as movecnt, chessman, color,
                    x, y, before_x, before_y, castling_black_long,
                    castling_black_short, castling_white_long,
                    castling_white_short
             where gameuuid = @gv_gameuuid and
                   movecnt = @gv_movecnt and
                   move_color = @iv_color and
                   move_chessman = @iv_chessman and
                   move_from_x = @iv_from_x and
                   move_from_y = @iv_from_y and
                   move_to_x   = @iv_to_x   and
                   move_to_y   = @iv_to_y
    into table @data(lt_next).
    if sy-subrc = 0.
      assert sy-dbcnt > 0.
      assert lines( lt_next ) > 0.
      insert demo_chess_pos from table @( corresponding #( lt_next ) ).
      assert sy-subrc = 0.
      data(ls_next) = lt_next[ 1 ].
      update demo_chess_game set color = @( cond #( when iv_color = 'B' then 'W' else 'B' ) ),
                                 movecnt = movecnt + 1,
                                 castling_black_long = @ls_next-castling_black_long,
                                 castling_black_short = @ls_next-castling_black_short,
                                 castling_white_long = @ls_next-castling_white_long,
                                 castling_white_short = @ls_next-castling_white_short
                             where gameuuid = @gv_gameuuid.
      assert sy-subrc = 0.
      gv_movecnt = gv_movecnt + 1.
      rv_flg_success = abap_true.
    else.
      assert sy-dbcnt = 0.
    endif.
  endmethod.


  method new_game.
    insert into demo_chess_game values @(
      value #( gameuuid = gv_gameuuid movecnt = 0 color = c_color_white ) " white's turn
    ).
    insert demo_chess_pos from table @(
      value #( for color = 1 then color + 1 until color > 2
                 for x = 1 then x + 1 until x > 8
                   for y = 1 then y + 1 until y > 2
                     ( gameuuid = gv_gameuuid
                       color = cond #( when color = 1 then c_color_white else c_color_black )
                       movecnt = 0
                       chessman = cond #( when y = 2 then c_chessman_pawn
                                          else cond #( when x = 1 or x = 8 then c_chessman_rook
                                                       when x = 2 or x = 7 then c_chessman_knight
                                                       when x = 3 or x = 6 then c_chessman_bishop
                                                       when x = 4          then c_chessman_queen
                                                       when x = 5          then c_chessman_king ) )
                       x = x
                       y = cond #( when color = 1 then y else 9 - y )
                       before_x = x
                       before_y = cond #( when color = 1 then y else 9 - y )
                     )
             )
    ).
  endmethod.


  method raise.
    release_internal( ).
    if iv_flg_rollback = abap_true.
      rollback work.
    endif.
    if iv_flg_raise = abap_true.
      raise exception type cx_demo_sql_chess
        exporting
          textid = is_t100key.
    endif.
  endmethod.


  method release.
    assert gv_gameuuid is not initial.
    check_not_released( ).
    release_internal( ).
  endmethod.


  method release_internal.
    assert gv_flg_move_write_lock = abap_false. " should not be set, because corresponding method raises no exception
    if gv_flg_move_lock = abap_true.
      unlock_moves( iv_flg_read = abap_true ).
    endif.
    if gv_flg_game_lock = abap_true.
      unlock_game( ).
    endif.
    gv_flg_released = abap_true.
  endmethod.


  method resume.
    assert gv_gameuuid is not initial.
    if gv_flg_released = abap_true.
      gv_flg_released = abap_false.
      lock_moves( iv_flg_read = abap_true ). " read lock for moves
      select count(*) from demo_chess_moves.
      if sy-subrc <> 0 or sy-dbcnt <> c_moves_cnt.
        generate_moves( ).
      endif.
      lock_game( ). " read lock
      select single movecnt from demo_chess_game
        where gameuuid = @gv_gameuuid into @gv_movecnt.
      if sy-subrc <> 0.
        raise( exporting is_t100key = cx_demo_sql_chess=>game_not_found
                         iv_flg_rollback = abap_false ).
      endif.
      check_game( iv_movecnt = gv_movecnt ).
    endif.
  endmethod.


  method unlock_game.
    assert gv_flg_game_lock = abap_true.
    call function 'DEQUEUE_EDEMO_CHESS_GAME'
      exporting
        mode_demo_chess_game = 'X'
        client               = sy-mandt
        gameuuid             = gv_gameuuid
        _scope               = '1'
        _synchron            = ' '
        _collect             = ' '.
    gv_flg_game_lock = abap_false.
  endmethod.


  method unlock_moves.
    call function 'DEQUEUE_EDEMO_CHESS_MOVE'
      exporting
        mode_demo_chess_moves = cond #( when iv_flg_read = abap_true then 'S' else 'E' )
        client                = sy-mandt
        _scope                = '1'
        _synchron             = ' '
        _collect              = ' '.
    if iv_flg_read = abap_true.
      assert gv_flg_move_lock = abap_true.
      gv_flg_move_lock = abap_false.
    else.
      assert gv_flg_move_write_lock = abap_true.
      gv_flg_move_write_lock = abap_false.
    endif.
  endmethod.
ENDCLASS.
