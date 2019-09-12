
class lcl_system_uuid_mock definition for testing duration long final.
  public section.
    interfaces if_system_uuid partially implemented.
endclass.

class lcl_system_uuid_mock implementation.
  method if_system_uuid~create_uuid_c32.
    raise exception type cx_uuid_error.
  endmethod.
endclass.

class lcl_system_uuid_mock2 definition for testing final.
  public section.
    interfaces if_system_uuid partially implemented.

    methods constructor importing iv_uuid type sysuuid_c32.
  private section.
    data gv_uuid type sysuuid_c32.
endclass.

class lcl_system_uuid_mock2 implementation.
  method if_system_uuid~create_uuid_c32.
    uuid = gv_uuid.
  endmethod.
  method constructor.
    gv_uuid = iv_uuid.
  endmethod.
endclass.


class lcl_demo_sql_chess_test definition for testing
  duration long risk level harmless final.

  public section.
    methods lock_moves.
    methods unlock_moves.
    methods check_game_does_not_exist importing iv_gameuuid type sysuuid_c32.

    methods test_factory for testing raising cx_demo_sql_chess .
    methods test_generate_moves for testing raising cx_demo_sql_chess.
    methods test_delete for testing raising cx_demo_sql_chess.
    methods load_game_not_exist for testing raising cx_demo_sql_chess cx_uuid_error.
    methods simulate_uuid_error for testing raising cx_demo_sql_chess.
    methods generate_existing_uuid for testing raising cx_demo_sql_chess.
    methods check_not_released for testing raising cx_demo_sql_chess.
    methods read_lock_moves for testing raising cx_demo_sql_chess.
    methods write_lock_moves for testing raising cx_demo_sql_chess.
    methods write_lock_game for testing raising cx_demo_sql_chess.
    methods test_new_game for testing raising cx_demo_sql_chess.
    methods test_factory_from_pos for testing raising cx_demo_sql_chess.
    methods test_factory_from_pos_err1 for testing raising cx_demo_sql_chess cx_uuid_error.
    methods test_factory_from_pos_err2 for testing raising cx_demo_sql_chess cx_uuid_error.
    methods test_factory_from_pos_err3 for testing raising cx_demo_sql_chess cx_uuid_error.
    methods test_factory_from_pos_err4 for testing raising cx_demo_sql_chess cx_uuid_error.
    methods test_factory_from_pos_err5 for testing raising cx_demo_sql_chess cx_uuid_error.
    methods test_factory_from_pos_err6 for testing raising cx_demo_sql_chess cx_uuid_error.
    methods test_factory_from_pos_err7 for testing raising cx_demo_sql_chess cx_uuid_error.
    methods test_factory_from_pos_err8 for testing raising cx_demo_sql_chess cx_uuid_error.
    methods test_factory_from_pos_err9 for testing raising cx_demo_sql_chess cx_uuid_error.
    methods test_stage5_initial for testing raising cx_demo_sql_chess.
    methods test_stage5_pawn_001 for testing raising cx_demo_sql_chess.
    methods test_stage5_pawn_002 for testing raising cx_demo_sql_chess.
    methods test_stage5_pawn_003 for testing raising cx_demo_sql_chess.
    methods test_stage5_pawn_004 for testing raising cx_demo_sql_chess.
    methods test_stage5_pawn_005 for testing raising cx_demo_sql_chess.
    methods test_stage5_pawn_006 for testing raising cx_demo_sql_chess.
    methods test_stage5_pawn_007 for testing raising cx_demo_sql_chess.
    methods test_stage5_pawn_008 for testing raising cx_demo_sql_chess.
    methods test_stage5_pawn_009 for testing raising cx_demo_sql_chess.
    methods test_stage5_pawn_010 for testing raising cx_demo_sql_chess.
    methods test_stage5_pawn_011 for testing raising cx_demo_sql_chess.
    methods test_stage5_pawn_012 for testing raising cx_demo_sql_chess.
    methods test_stage5_pawn_013 for testing raising cx_demo_sql_chess.
    methods test_stage5_pawn_014 for testing raising cx_demo_sql_chess.
    methods test_stage5_queen_001 for testing raising cx_demo_sql_chess.
    methods test_stage5_queen_002 for testing raising cx_demo_sql_chess.
    methods test_stage5_bishop_001 for testing raising cx_demo_sql_chess.
    methods test_stage5_bishop_002 for testing raising cx_demo_sql_chess.
    methods test_stage5_rook_001 for testing raising cx_demo_sql_chess.
    methods test_stage5_rook_002 for testing raising cx_demo_sql_chess.
    methods test_stage5_knight_001 for testing raising cx_demo_sql_chess.
    methods test_stage5_knight_002 for testing raising cx_demo_sql_chess.
    methods test_stage5_king_001 for testing raising cx_demo_sql_chess.
    methods test_stage5_king_002 for testing raising cx_demo_sql_chess.
    methods test_stage6_castling_001 for testing raising cx_demo_sql_chess.
    methods test_stage6_castling_002 for testing raising cx_demo_sql_chess.
    methods test_stage6_castling_003 for testing raising cx_demo_sql_chess.
    methods test_stage6_castling_004 for testing raising cx_demo_sql_chess.
    methods test_stage6_castling_005 for testing raising cx_demo_sql_chess.
    methods test_stage6_castling_006 for testing raising cx_demo_sql_chess.
    methods test_stage6_castling_007 for testing raising cx_demo_sql_chess.
    methods test_stage6_castling_008 for testing raising cx_demo_sql_chess.
    methods test_stage6_castling_009 for testing raising cx_demo_sql_chess.
    methods test_stage6_castling_010 for testing raising cx_demo_sql_chess.
    methods test_stage6_castling_011 for testing raising cx_demo_sql_chess.
    methods test_stage6_castling_012 for testing raising cx_demo_sql_chess.
    methods test_stage7_001 for testing raising cx_demo_sql_chess.
    methods test_stage7_002 for testing raising cx_demo_sql_chess.
    methods test_stage7_003 for testing raising cx_demo_sql_chess.
    methods test_stage7_004 for testing raising cx_demo_sql_chess.
    methods test_stage7_005 for testing raising cx_demo_sql_chess.

    methods test_stage13_kings for testing raising cx_demo_sql_chess.
    methods test_stage13_kings_2 for testing raising cx_demo_sql_chess.
    methods test_stage13_mate for testing raising cx_demo_sql_chess.
    methods test_stage13_mate_2 for testing raising cx_demo_sql_chess.

    methods test_stage13_not_mate for testing raising cx_demo_sql_chess.
    methods test_stage13_not_mate_2 for testing raising cx_demo_sql_chess.

    methods test_next_move_mate_cst_001 for testing raising cx_demo_sql_chess.
    methods test_next_move_mate_cst_002 for testing raising cx_demo_sql_chess.
    methods test_next_move_mate_cst_003 for testing raising cx_demo_sql_chess.
    methods test_next_move_mate_cst_004 for testing raising cx_demo_sql_chess.
    methods test_next_move_mate_cst_005 for testing raising cx_demo_sql_chess.
    methods test_next_move_mate_cst_006 for testing raising cx_demo_sql_chess.
    methods test_next_move_mate_cst_007 for testing raising cx_demo_sql_chess.
    methods test_next_move_mate_cst_008 for testing raising cx_demo_sql_chess.
    methods test_next_move_mate_cst_009 for testing raising cx_demo_sql_chess.
    methods test_next_move_mate_cst_010 for testing raising cx_demo_sql_chess.
    methods test_next_move_mate_cst_011 for testing raising cx_demo_sql_chess.
    methods test_next_move_mate_cst_012 for testing raising cx_demo_sql_chess.
    methods test_next_move_mate_cst_013 for testing raising cx_demo_sql_chess.
    methods test_next_move_mate_cst_014 for testing raising cx_demo_sql_chess.
    methods test_next_move_mate_cst_015 for testing raising cx_demo_sql_chess.
    methods test_next_move_mate_cst_016 for testing raising cx_demo_sql_chess.

    methods test_next_move_released for testing raising cx_demo_sql_chess.
    methods test_move_released for testing raising cx_demo_sql_chess.

    methods test_move_001 for testing raising cx_demo_sql_chess.
    methods test_move_002 for testing raising cx_demo_sql_chess.
    methods test_move_003 for testing raising cx_demo_sql_chess.
    methods test_move_004 for testing raising cx_demo_sql_chess.
    methods test_move_005 for testing raising cx_demo_sql_chess.
    methods test_move_006 for testing raising cx_demo_sql_chess.
    methods test_move_007 for testing raising cx_demo_sql_chess.
    methods test_move_008 for testing raising cx_demo_sql_chess.
    methods test_move_009 for testing raising cx_demo_sql_chess.

    methods test_move_fail for testing raising cx_demo_sql_chess.
    methods test_resume_001 for testing raising cx_demo_sql_chess.
    methods test_resume_002 for testing raising cx_demo_sql_chess.
    methods test_resume_003 for testing raising cx_demo_sql_chess.
    methods test_resume_004 for testing raising cx_demo_sql_chess.
    methods test_resume_005 for testing raising cx_demo_sql_chess.
    methods test_raise for testing raising cx_demo_sql_chess.

  private section.
    methods teardown.
    class-methods class_setup.
    class-methods class_teardown.
endclass.       "lcl_Demo_Sql_Chess_Test

class lcl_demo_sql_chess_test implementation.
  method class_setup.
    call function 'ENQUEUE_EDEMO_CHESS_TEST'
      exporting
        mode_demo_chess_col_t = 'E'
        client                = sy-mandt
        _scope                = '1'
        _wait                 = 'X'
        _collect              = ' '
      exceptions
        foreign_lock         = 1
        system_failure       = 2
        others               = 3.
    if sy-subrc <> 0.
      cl_aunit_assert=>fail( msg = 'Unit test locked by other process. Could not execute.' level = if_aunit_constants=>tolerable ).
    endif.
  endmethod.

  method class_teardown.
    call function 'DEQUEUE_EDEMO_CHESS_TEST'
      exporting
        mode_demo_chess_col_t = 'E'
        client                = sy-mandt
        _scope                = '1'
        _synchron             = ' '
        _collect              = ' '.
  endmethod.

  method teardown.
    rollback work.
  endmethod.
  method lock_moves.
    call function 'ENQUEUE_EDEMO_CHESS_MOVE'
      exporting
        mode_demo_chess_moves = 'E'
        client                = sy-mandt
        _scope                = '1'
        _wait                 = 'X'
        _collect              = ' '
      exceptions
        foreign_lock          = 1
        system_failure        = 2
        others                = 3.
  endmethod.

  method unlock_moves.
    call function 'DEQUEUE_EDEMO_CHESS_MOVE'
      exporting
        mode_demo_chess_moves = 'E'
        client                = sy-mandt
        _scope                = '1'
        _synchron             = ' '
        _collect              = ' '.
  endmethod.

  method check_game_does_not_exist.
    select count(*) from demo_chess_game
      where gameuuid = @iv_gameuuid.
    cl_aunit_assert=>assert_subrc( act = sy-subrc exp = 4 quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = sy-dbcnt exp = 0 quit = if_aunit_constants=>no ).
    select count(*) from demo_chess_pos
      where gameuuid = @iv_gameuuid.
    cl_aunit_assert=>assert_subrc( act = sy-subrc exp = 4 quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = sy-dbcnt exp = 0 quit = if_aunit_constants=>no ).
  endmethod.

  method test_factory.
    data lo_object type ref to cl_demo_sql_chess.
    lo_object = cl_demo_sql_chess=>factory( ).
    cl_aunit_assert=>assert_not_initial( act = lo_object->gv_gameuuid quit = if_aunit_constants=>no ).
    lo_object->delete( ).
  endmethod.
  method test_generate_moves.
    data lo_object type ref to cl_demo_sql_chess.
    lock_moves( ).
    delete from demo_chess_moves where 1 = 1.
    unlock_moves( ).

    lo_object = cl_demo_sql_chess=>factory( ).
    lo_object->delete( ).
    select * from demo_chess_moves
      into table @data(lt_moves).
    cl_aunit_assert=>assert_subrc( act = sy-subrc quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = sy-dbcnt exp = 7620 quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = lines( lt_moves ) exp = 7620 quit = if_aunit_constants=>no ).
  endmethod.
  method test_delete.
    data lo_object type ref to cl_demo_sql_chess.
    lo_object = cl_demo_sql_chess=>factory( ).
    select single * from demo_chess_game
      where gameuuid = @lo_object->gv_gameuuid into @data(result).
    cl_aunit_assert=>assert_subrc( act = sy-subrc quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = sy-dbcnt exp = 1 quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = result-gameuuid exp = lo_object->gv_gameuuid quit = if_aunit_constants=>no ).
    lo_object->delete( ).
    select single * from demo_chess_game
      where gameuuid = @lo_object->gv_gameuuid into @result.
    cl_aunit_assert=>assert_subrc( act = sy-subrc exp = 4 quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = sy-dbcnt exp = 0 quit = if_aunit_constants=>no ).
  endmethod.
  method load_game_not_exist.
    data lo_exc type ref to cx_demo_sql_chess.
    data lv_catched type abap_bool.
    data lo_object type ref to cl_demo_sql_chess.
    try.
        lo_object = cl_demo_sql_chess=>factory( iv_uuid = cl_uuid_factory=>create_system_uuid( )->create_uuid_c32( ) ). " should not exist
      catch cx_demo_sql_chess into lo_exc.
        if lo_exc->if_t100_message~t100key = cx_demo_sql_chess=>game_not_found.
          lv_catched = abap_true.
        endif.
    endtry.
    cl_aunit_assert=>assert_equals( act = lv_catched exp = abap_true quit = if_aunit_constants=>no ).
    " now check that everything has been correctly given free and no lock is hung
    lo_object = cl_demo_sql_chess=>factory( ).
    lo_object->delete( ).
  endmethod.
  method simulate_uuid_error.
    data lo_exc type ref to cx_demo_sql_chess.
    data lv_catched type abap_bool.
    data lo_object type ref to cl_demo_sql_chess.
    data lo_uuid type ref to lcl_system_uuid_mock.
    lo_uuid = new #( ).
    try.
        lo_object = cl_demo_sql_chess=>factory( io_uuid_factory = lo_uuid ). " should not exist
      catch cx_demo_sql_chess into lo_exc.
        if lo_exc->if_t100_message~t100key = cx_demo_sql_chess=>uuid_error.
          lv_catched = abap_true.
        endif.
    endtry.
    cl_aunit_assert=>assert_equals( act = lv_catched exp = abap_true quit = if_aunit_constants=>no ).
    " now check that everything has been correctly given free and no lock is hung
    lo_object = cl_demo_sql_chess=>factory( ).
    lo_object->delete( ).
  endmethod.
  method generate_existing_uuid.
    data lo_exc type ref to cx_demo_sql_chess.
    data lo_object type ref to cl_demo_sql_chess.
    data lo_uuid type ref to lcl_system_uuid_mock2.
    data lv_catched type abap_bool.
    data lv_gameuuid type sysuuid_c32.
    lo_object = cl_demo_sql_chess=>factory( ).
    lo_object->release( ).
    lv_gameuuid = lo_object->gv_gameuuid.
    try.
        lo_uuid = new #( lv_gameuuid ).
        lo_object = cl_demo_sql_chess=>factory( io_uuid_factory = lo_uuid ).
      catch cx_demo_sql_chess into lo_exc.
        if lo_exc->if_t100_message~t100key = cx_demo_sql_chess=>uuid_error.
          lv_catched = abap_true.
        endif.
    endtry.
    cl_aunit_assert=>assert_equals( act = lv_catched exp = abap_true quit = if_aunit_constants=>no ).
    lo_object->resume( ).
    lo_object->delete( ).
    check_game_does_not_exist( iv_gameuuid = lv_gameuuid ).
  endmethod.
  method check_not_released.
    data lo_object type ref to cl_demo_sql_chess.
    data lo_exc type ref to cx_demo_sql_chess.
    data lv_catched type abap_bool.
    lo_object = cl_demo_sql_chess=>factory( ).
    lo_object->release( ).
    try.
        lo_object->delete( ).
      catch cx_demo_sql_chess into lo_exc.
        if lo_exc->if_t100_message~t100key = cx_demo_sql_chess=>instance_is_released.
          lv_catched = abap_true.
        endif.
    endtry.
    cl_aunit_assert=>assert_equals( act = lv_catched exp = abap_true quit = if_aunit_constants=>no ).
    lo_object = cl_demo_sql_chess=>factory( iv_uuid = lo_object->gv_gameuuid ).
    lo_object->delete( ).
  endmethod.

  method read_lock_moves.
    data lo_object type ref to cl_demo_sql_chess ##NEEDED.
    data lo_exc type ref to cx_demo_sql_chess.
    data lv_catched type abap_bool.
    set language 'E'.
    set locale language 'E'.
    call function 'ENQUEUE_EDEMO_CHESS_MOVE'
      destination 'NONE'
      exporting
        mode_demo_chess_moves = 'E'
        client                = sy-mandt
        _scope                = '1'
        _wait                 = ' '
        _collect              = ' '
      exceptions
        foreign_lock          = 1
        system_failure        = 2
        others                = 3.
    cl_aunit_assert=>assert_subrc( act = sy-subrc quit = if_aunit_constants=>no ).
    try.
        lo_object = cl_demo_sql_chess=>factory( ).
      catch cx_demo_sql_chess into lo_exc.
        if lo_exc->if_t100_message~t100key = cx_demo_sql_chess=>no_read_lock_moves.
          lv_catched = abap_true.
        endif.
    endtry.
    cl_aunit_assert=>assert_equals( act = lv_catched exp = abap_true quit = if_aunit_constants=>no ).
    call function 'DEQUEUE_EDEMO_CHESS_MOVE'
      destination 'NONE'
      exporting
        mode_demo_chess_moves = 'E'
        client                = sy-mandt
        _scope                = '1'
        _synchron             = ' '
        _collect              = ' '.
  endmethod.

  method write_lock_moves.
    data lo_object type ref to cl_demo_sql_chess.
    data lo_exc type ref to cx_demo_sql_chess.
    data lv_catched type abap_bool.
    set language 'E'.
    set locale language 'E'.

    lock_moves(  ).
    delete from demo_chess_moves where 1 = 1.
    unlock_moves(  ).

    call function 'ENQUEUE_EDEMO_CHESS_MOVE'
      destination 'NONE'
      exporting
        mode_demo_chess_moves = 'S'
        client                = sy-mandt
        _scope                = '1'
        _wait                 = ' '
        _collect              = ' '
      exceptions
        foreign_lock          = 1
        system_failure        = 2
        others                = 3.
    cl_aunit_assert=>assert_subrc( act = sy-subrc quit = if_aunit_constants=>no ).
    try.
        lo_object = cl_demo_sql_chess=>factory( ).
      catch cx_demo_sql_chess into lo_exc.
        if lo_exc->if_t100_message~t100key = cx_demo_sql_chess=>no_write_lock_moves.
          lv_catched = abap_true.
        endif.
    endtry.
    cl_aunit_assert=>assert_equals( act = lv_catched exp = abap_true quit = if_aunit_constants=>no ).
    call function 'DEQUEUE_EDEMO_CHESS_MOVE'
      destination 'NONE'
      exporting
        mode_demo_chess_moves = 'S'
        client                = sy-mandt
        _scope                = '1'
        _synchron             = ' '
        _collect              = ' '.
  endmethod.

  method write_lock_game.
    data lo_object type ref to cl_demo_sql_chess.
    data lo_object2 type ref to cl_demo_sql_chess.
    data lo_exc type ref to cx_demo_sql_chess.
    data lv_catched type abap_bool.

    lo_object =  cl_demo_sql_chess=>factory( ).
    try.
        lo_object2 =  cl_demo_sql_chess=>factory( iv_uuid = lo_object->gv_gameuuid ).
      catch cx_demo_sql_chess into lo_exc.
        if lo_exc->if_t100_message~t100key = cx_demo_sql_chess=>no_write_lock_game.
          lv_catched = abap_true.
        endif.
    endtry.
    cl_aunit_assert=>assert_equals( act = lv_catched exp = abap_true quit = if_aunit_constants=>no ).
    lo_object->release( ).
    " now it should work
    lo_object2 = cl_demo_sql_chess=>factory( iv_uuid = lo_object->gv_gameuuid ).
    lo_object2->delete( ).
  endmethod.
  method test_new_game.
    data lo_object type ref to cl_demo_sql_chess.
    data ls_positions type demo_chess_v_pos2line.
    lo_object =  cl_demo_sql_chess=>factory( ).
    select single * from demo_chess_v_pos2line
      where gameuuid = @lo_object->gv_gameuuid
      into @ls_positions.
    cl_aunit_assert=>assert_subrc( act = sy-subrc quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = sy-dbcnt exp = 1 quit = if_aunit_constants=>no ).

    lo_object->delete( ).

    cl_aunit_assert=>assert_equals( act = ls_positions-a1_color    exp = cl_demo_sql_chess=>c_color_white     quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_positions-a1_chessman exp = cl_demo_sql_chess=>c_chessman_rook   quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_positions-b1_color    exp = cl_demo_sql_chess=>c_color_white     quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_positions-b1_chessman exp = cl_demo_sql_chess=>c_chessman_knight quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_positions-c1_color    exp = cl_demo_sql_chess=>c_color_white     quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_positions-c1_chessman exp = cl_demo_sql_chess=>c_chessman_bishop quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_positions-d1_color    exp = cl_demo_sql_chess=>c_color_white     quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_positions-d1_chessman exp = cl_demo_sql_chess=>c_chessman_queen quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_positions-e1_color    exp = cl_demo_sql_chess=>c_color_white     quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_positions-e1_chessman exp = cl_demo_sql_chess=>c_chessman_king   quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_positions-f1_color    exp = cl_demo_sql_chess=>c_color_white     quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_positions-f1_chessman exp = cl_demo_sql_chess=>c_chessman_bishop quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_positions-g1_color    exp = cl_demo_sql_chess=>c_color_white     quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_positions-g1_chessman exp = cl_demo_sql_chess=>c_chessman_knight quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_positions-h1_color    exp = cl_demo_sql_chess=>c_color_white     quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_positions-h1_chessman exp = cl_demo_sql_chess=>c_chessman_rook   quit = if_aunit_constants=>no ).

    cl_aunit_assert=>assert_equals( act = ls_positions-a2_color    exp = cl_demo_sql_chess=>c_color_white     quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_positions-a2_chessman exp = cl_demo_sql_chess=>c_chessman_pawn   quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_positions-b2_color    exp = cl_demo_sql_chess=>c_color_white     quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_positions-b2_chessman exp = cl_demo_sql_chess=>c_chessman_pawn   quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_positions-c2_color    exp = cl_demo_sql_chess=>c_color_white     quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_positions-c2_chessman exp = cl_demo_sql_chess=>c_chessman_pawn   quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_positions-d2_color    exp = cl_demo_sql_chess=>c_color_white     quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_positions-d2_chessman exp = cl_demo_sql_chess=>c_chessman_pawn   quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_positions-e2_color    exp = cl_demo_sql_chess=>c_color_white     quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_positions-e2_chessman exp = cl_demo_sql_chess=>c_chessman_pawn   quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_positions-f2_color    exp = cl_demo_sql_chess=>c_color_white     quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_positions-f2_chessman exp = cl_demo_sql_chess=>c_chessman_pawn   quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_positions-g2_color    exp = cl_demo_sql_chess=>c_color_white     quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_positions-g2_chessman exp = cl_demo_sql_chess=>c_chessman_pawn   quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_positions-h2_color    exp = cl_demo_sql_chess=>c_color_white     quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_positions-h2_chessman exp = cl_demo_sql_chess=>c_chessman_pawn   quit = if_aunit_constants=>no ).

    cl_aunit_assert=>assert_equals( act = ls_positions-a3_color    exp = ''   quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_positions-a3_chessman exp = ''   quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_positions-b3_color    exp = ''   quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_positions-b3_chessman exp = ''   quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_positions-c3_color    exp = ''   quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_positions-c3_chessman exp = ''   quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_positions-d3_color    exp = ''   quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_positions-d3_chessman exp = ''   quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_positions-e3_color    exp = ''   quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_positions-e3_chessman exp = ''   quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_positions-f3_color    exp = ''   quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_positions-f3_chessman exp = ''   quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_positions-g3_color    exp = ''   quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_positions-g3_chessman exp = ''   quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_positions-h3_color    exp = ''   quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_positions-h3_chessman exp = ''   quit = if_aunit_constants=>no ).

    cl_aunit_assert=>assert_equals( act = ls_positions-a4_color    exp = ''   quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_positions-a4_chessman exp = ''   quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_positions-b4_color    exp = ''   quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_positions-b4_chessman exp = ''   quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_positions-c4_color    exp = ''   quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_positions-c4_chessman exp = ''   quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_positions-d4_color    exp = ''   quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_positions-d4_chessman exp = ''   quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_positions-e4_color    exp = ''   quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_positions-e4_chessman exp = ''   quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_positions-f4_color    exp = ''   quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_positions-f4_chessman exp = ''   quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_positions-g4_color    exp = ''   quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_positions-g4_chessman exp = ''   quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_positions-h4_color    exp = ''   quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_positions-h4_chessman exp = ''   quit = if_aunit_constants=>no ).

    cl_aunit_assert=>assert_equals( act = ls_positions-a5_color    exp = ''   quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_positions-a5_chessman exp = ''   quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_positions-b5_color    exp = ''   quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_positions-b5_chessman exp = ''   quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_positions-c5_color    exp = ''   quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_positions-c5_chessman exp = ''   quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_positions-d5_color    exp = ''   quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_positions-d5_chessman exp = ''   quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_positions-e5_color    exp = ''   quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_positions-e5_chessman exp = ''   quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_positions-f5_color    exp = ''   quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_positions-f5_chessman exp = ''   quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_positions-g5_color    exp = ''   quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_positions-g5_chessman exp = ''   quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_positions-h5_color    exp = ''   quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_positions-h5_chessman exp = ''   quit = if_aunit_constants=>no ).

    cl_aunit_assert=>assert_equals( act = ls_positions-a6_color    exp = ''   quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_positions-a6_chessman exp = ''   quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_positions-b6_color    exp = ''   quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_positions-b6_chessman exp = ''   quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_positions-c6_color    exp = ''   quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_positions-c6_chessman exp = ''   quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_positions-d6_color    exp = ''   quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_positions-d6_chessman exp = ''   quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_positions-e6_color    exp = ''   quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_positions-e6_chessman exp = ''   quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_positions-f6_color    exp = ''   quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_positions-f6_chessman exp = ''   quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_positions-g6_color    exp = ''   quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_positions-g6_chessman exp = ''   quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_positions-h6_color    exp = ''   quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_positions-h6_chessman exp = ''   quit = if_aunit_constants=>no ).

    cl_aunit_assert=>assert_equals( act = ls_positions-a7_color    exp = cl_demo_sql_chess=>c_color_black     quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_positions-a7_chessman exp = cl_demo_sql_chess=>c_chessman_pawn   quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_positions-b7_color    exp = cl_demo_sql_chess=>c_color_black     quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_positions-b7_chessman exp = cl_demo_sql_chess=>c_chessman_pawn   quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_positions-c7_color    exp = cl_demo_sql_chess=>c_color_black     quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_positions-c7_chessman exp = cl_demo_sql_chess=>c_chessman_pawn   quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_positions-d7_color    exp = cl_demo_sql_chess=>c_color_black     quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_positions-d7_chessman exp = cl_demo_sql_chess=>c_chessman_pawn   quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_positions-e7_color    exp = cl_demo_sql_chess=>c_color_black     quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_positions-e7_chessman exp = cl_demo_sql_chess=>c_chessman_pawn   quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_positions-f7_color    exp = cl_demo_sql_chess=>c_color_black     quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_positions-f7_chessman exp = cl_demo_sql_chess=>c_chessman_pawn   quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_positions-g7_color    exp = cl_demo_sql_chess=>c_color_black     quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_positions-g7_chessman exp = cl_demo_sql_chess=>c_chessman_pawn   quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_positions-h7_color    exp = cl_demo_sql_chess=>c_color_black     quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_positions-h7_chessman exp = cl_demo_sql_chess=>c_chessman_pawn   quit = if_aunit_constants=>no ).

    cl_aunit_assert=>assert_equals( act = ls_positions-a8_color    exp = cl_demo_sql_chess=>c_color_black     quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_positions-a8_chessman exp = cl_demo_sql_chess=>c_chessman_rook   quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_positions-b8_color    exp = cl_demo_sql_chess=>c_color_black     quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_positions-b8_chessman exp = cl_demo_sql_chess=>c_chessman_knight quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_positions-c8_color    exp = cl_demo_sql_chess=>c_color_black     quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_positions-c8_chessman exp = cl_demo_sql_chess=>c_chessman_bishop quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_positions-d8_color    exp = cl_demo_sql_chess=>c_color_black     quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_positions-d8_chessman exp = cl_demo_sql_chess=>c_chessman_queen  quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_positions-e8_color    exp = cl_demo_sql_chess=>c_color_black     quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_positions-e8_chessman exp = cl_demo_sql_chess=>c_chessman_king   quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_positions-f8_color    exp = cl_demo_sql_chess=>c_color_black     quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_positions-f8_chessman exp = cl_demo_sql_chess=>c_chessman_bishop quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_positions-g8_color    exp = cl_demo_sql_chess=>c_color_black     quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_positions-g8_chessman exp = cl_demo_sql_chess=>c_chessman_knight quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_positions-h8_color    exp = cl_demo_sql_chess=>c_color_black     quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_positions-h8_chessman exp = cl_demo_sql_chess=>c_chessman_rook   quit = if_aunit_constants=>no ).
  endmethod.

  method test_factory_from_pos.
    data lo_object type ref to cl_demo_sql_chess.
    data lt_positions type cl_demo_sql_chess=>gtt_positions.
    data lt_positions_exp type standard table of demo_chess_v_pos_cds with empty key.
    lt_positions = value #(
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king   x = 4 y = 8 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king   x = 7 y = 8 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_bishop x = 8 y = 8 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_pawn   x = 4 y = 4 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_bishop x = 8 y = 3 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_knight x = 8 y = 2 )
    ).
    lo_object = cl_demo_sql_chess=>factory_from_position( is_settings  = value #( color = cl_demo_sql_chess=>c_color_black
                                                                                  castling_black_long  = abap_true
                                                                                  castling_black_short = abap_true
                                                                                  castling_white_long  = abap_true
                                                                                  castling_white_short = abap_true
                                                                                )
                                                          it_positions = lt_positions ).

    select single * from demo_chess_v_game_cds
      where gameuuid = @lo_object->gv_gameuuid
      into @data(ls_game_act).
    cl_aunit_assert=>assert_subrc( act = sy-subrc quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = sy-dbcnt exp = 1 quit = if_aunit_constants=>no ).

    cl_aunit_assert=>assert_equals( act = ls_game_act-color                exp = cl_demo_sql_chess=>c_color_black  quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_game_act-movecnt              exp = 0  quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_game_act-castling_black_long  exp = abap_true  quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_game_act-castling_black_short  exp = abap_true  quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_game_act-castling_white_long  exp = abap_true  quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_game_act-castling_white_short  exp = abap_true  quit = if_aunit_constants=>no ).

    select * from demo_chess_v_pos_cds
      where gameuuid = @lo_object->gv_gameuuid and
            movecnt  = 0
      order by x, y
      into table @data(lt_positions_act).
    cl_aunit_assert=>assert_subrc( act = sy-subrc quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = sy-dbcnt exp = 6 quit = if_aunit_constants=>no ).

    lt_positions_exp = value #(
      ( gameuuid = lo_object->gv_gameuuid movecnt  = 0 color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king   x = 4 y = 8 before_x = 4 before_y = 8 )
      ( gameuuid = lo_object->gv_gameuuid movecnt  = 0 color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king   x = 7 y = 8 before_x = 7 before_y = 8 )
      ( gameuuid = lo_object->gv_gameuuid movecnt  = 0 color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_bishop x = 8 y = 8 before_x = 8 before_y = 8 )
      ( gameuuid = lo_object->gv_gameuuid movecnt  = 0 color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_pawn   x = 4 y = 4 before_x = 4 before_y = 4 )
      ( gameuuid = lo_object->gv_gameuuid movecnt  = 0 color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_bishop x = 8 y = 3 before_x = 8 before_y = 3 )
      ( gameuuid = lo_object->gv_gameuuid movecnt  = 0 color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_knight x = 8 y = 2 before_x = 8 before_y = 2 )
    ).
    sort lt_positions_exp by x y.
    cl_aunit_assert=>assert_equals( act = lt_positions_act  exp = lt_positions_exp  quit = if_aunit_constants=>no ).
    lo_object->delete( ).
  endmethod.

  method test_factory_from_pos_err1.
    data lo_exc type ref to cx_demo_sql_chess.
    data lo_object type ref to cl_demo_sql_chess.
    data lt_positions type cl_demo_sql_chess=>gtt_positions.
    data lv_catched type abap_bool.
    data lo_uuid type ref to lcl_system_uuid_mock2.
    data lv_uuid type sysuuid_c32.
    lt_positions = value #(
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king   x = 4 y = 8 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king   x = 7 y = 8 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_bishop x = 8 y = 8 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_pawn   x = 4 y = 4 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_bishop x = 8 y = 3 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_knight x = 8 y = 2 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king   x = 1 y = 1 ) " more than 1 white king
    ).

    lv_uuid = cl_uuid_factory=>create_system_uuid( )->create_uuid_c32( ).
    lo_uuid = new #( lv_uuid ).

    try.
        lo_object = cl_demo_sql_chess=>factory_from_position(  io_uuid_factory = lo_uuid
                                                               is_settings  = value #( color = cl_demo_sql_chess=>c_color_black
                                                                                      castling_black_long  = abap_true
                                                                                      castling_black_short = abap_true
                                                                                      castling_white_long  = abap_true
                                                                                      castling_white_short = abap_true
                                                                                  )
                                                               it_positions = lt_positions ).
      catch cx_demo_sql_chess into lo_exc.
        if lo_exc->if_t100_message~t100key = cx_demo_sql_chess=>invalid_chess_position.
          lv_catched = abap_true.
        endif.
    endtry.
    cl_aunit_assert=>assert_equals( act = lv_catched  exp = abap_true  quit = if_aunit_constants=>no ).

    " check if rollback was successfull
    select single * from demo_chess_v_game_cds
      where gameuuid = @lv_uuid
      into @data(ls_game).
    cl_aunit_assert=>assert_subrc( act = sy-subrc exp = 4 quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = sy-dbcnt exp = 0 quit = if_aunit_constants=>no ).

    select * from demo_chess_v_pos_cds
      where gameuuid = @lv_uuid
      into @data(ls_pos) up to 1 rows.
    endselect.
    cl_aunit_assert=>assert_subrc( act = sy-subrc exp = 4 quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = sy-dbcnt exp = 0 quit = if_aunit_constants=>no ).

    " check if everything has been released properly
    lo_object = cl_demo_sql_chess=>factory( io_uuid_factory = lo_uuid ).
    lo_object->delete( ).
  endmethod.

  method test_factory_from_pos_err2.
    data lo_exc type ref to cx_demo_sql_chess.
    data lo_object type ref to cl_demo_sql_chess.
    data lt_positions type cl_demo_sql_chess=>gtt_positions.
    data lv_catched type abap_bool.
    data lo_uuid type ref to lcl_system_uuid_mock2.
    data lv_uuid type sysuuid_c32.
    lt_positions = value #(
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king   x = 4 y = 8 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king   x = 7 y = 8 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_bishop x = 8 y = 8 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_pawn   x = 4 y = 4 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_bishop x = 8 y = 3 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_knight x = 8 y = 2 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king   x = 1 y = 1 ) " more than 1 black king
    ).

    lv_uuid = cl_uuid_factory=>create_system_uuid( )->create_uuid_c32( ).
    lo_uuid = new #( lv_uuid ).

    try.
        lo_object = cl_demo_sql_chess=>factory_from_position(  io_uuid_factory = lo_uuid
                                                               is_settings  = value #( color = cl_demo_sql_chess=>c_color_black
                                                                                      castling_black_long  = abap_true
                                                                                      castling_black_short = abap_true
                                                                                      castling_white_long  = abap_true
                                                                                      castling_white_short = abap_true
                                                                                  )
                                                               it_positions = lt_positions ).
      catch cx_demo_sql_chess into lo_exc.
        if lo_exc->if_t100_message~t100key = cx_demo_sql_chess=>invalid_chess_position.
          lv_catched = abap_true.
        endif.
    endtry.
    cl_aunit_assert=>assert_equals( act = lv_catched  exp = abap_true  quit = if_aunit_constants=>no ).

    " check if rollback was successfull
    select single * from demo_chess_v_game_cds
      where gameuuid = @lv_uuid
      into @data(ls_game).
    cl_aunit_assert=>assert_subrc( act = sy-subrc exp = 4 quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = sy-dbcnt exp = 0 quit = if_aunit_constants=>no ).

    select * from demo_chess_v_pos_cds
      where gameuuid = @lv_uuid
      into @data(ls_pos) up to 1 rows.
    endselect.
    cl_aunit_assert=>assert_subrc( act = sy-subrc exp = 4 quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = sy-dbcnt exp = 0 quit = if_aunit_constants=>no ).

    " check if everything has been released properly
    lo_object = cl_demo_sql_chess=>factory( io_uuid_factory = lo_uuid ).
    lo_object->delete( ).
  endmethod.

  method test_factory_from_pos_err3.
    data lo_exc type ref to cx_demo_sql_chess.
    data lo_object type ref to cl_demo_sql_chess.
    data lt_positions type cl_demo_sql_chess=>gtt_positions.
    data lv_catched type abap_bool.
    data lo_uuid type ref to lcl_system_uuid_mock2.
    data lv_uuid type sysuuid_c32.
    lt_positions = value #(
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king   x = 4 y = 8 ) " no white king
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_bishop x = 8 y = 8 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_pawn   x = 4 y = 4 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_bishop x = 8 y = 3 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_knight x = 8 y = 2 )
    ).

    lv_uuid = cl_uuid_factory=>create_system_uuid( )->create_uuid_c32( ).
    lo_uuid = new #( lv_uuid ).

    try.
        lo_object = cl_demo_sql_chess=>factory_from_position(  io_uuid_factory = lo_uuid
                                                               is_settings  = value #( color = cl_demo_sql_chess=>c_color_black
                                                                                      castling_black_long  = abap_true
                                                                                      castling_black_short = abap_true
                                                                                      castling_white_long  = abap_true
                                                                                      castling_white_short = abap_true
                                                                                  )
                                                               it_positions = lt_positions ).
      catch cx_demo_sql_chess into lo_exc.
        if lo_exc->if_t100_message~t100key = cx_demo_sql_chess=>invalid_chess_position.
          lv_catched = abap_true.
        endif.
    endtry.
    cl_aunit_assert=>assert_equals( act = lv_catched  exp = abap_true  quit = if_aunit_constants=>no ).

    " check if rollback was successfull
    select single * from demo_chess_v_game_cds
      where gameuuid = @lv_uuid
      into @data(ls_game).
    cl_aunit_assert=>assert_subrc( act = sy-subrc exp = 4 quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = sy-dbcnt exp = 0 quit = if_aunit_constants=>no ).

    select * from demo_chess_v_pos_cds
      where gameuuid = @lv_uuid
      into @data(ls_pos) up to 1 rows.
    endselect.
    cl_aunit_assert=>assert_subrc( act = sy-subrc exp = 4 quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = sy-dbcnt exp = 0 quit = if_aunit_constants=>no ).

    " check if everything has been released properly
    lo_object = cl_demo_sql_chess=>factory( io_uuid_factory = lo_uuid ).
    lo_object->delete( ).
  endmethod.

  method test_factory_from_pos_err4.
    data lo_exc type ref to cx_demo_sql_chess.
    data lo_object type ref to cl_demo_sql_chess.
    data lt_positions type cl_demo_sql_chess=>gtt_positions.
    data lv_catched type abap_bool.
    data lo_uuid type ref to lcl_system_uuid_mock2.
    data lv_uuid type sysuuid_c32.
    lt_positions = value #(
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_bishop x = 8 y = 8 ) " no black king
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_pawn   x = 4 y = 4 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_bishop x = 8 y = 3 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_knight x = 8 y = 2 )
    ).

    lv_uuid = cl_uuid_factory=>create_system_uuid( )->create_uuid_c32( ).
    lo_uuid = new #( lv_uuid ).

    try.
        lo_object = cl_demo_sql_chess=>factory_from_position(  io_uuid_factory = lo_uuid
                                                               is_settings  = value #( color = cl_demo_sql_chess=>c_color_black
                                                                                      castling_black_long  = abap_true
                                                                                      castling_black_short = abap_true
                                                                                      castling_white_long  = abap_true
                                                                                      castling_white_short = abap_true
                                                                                  )
                                                               it_positions = lt_positions ).
      catch cx_demo_sql_chess into lo_exc.
        if lo_exc->if_t100_message~t100key = cx_demo_sql_chess=>invalid_chess_position.
          lv_catched = abap_true.
        endif.
    endtry.
    cl_aunit_assert=>assert_equals( act = lv_catched  exp = abap_true  quit = if_aunit_constants=>no ).

    " check if rollback was successfull
    select single * from demo_chess_v_game_cds
      where gameuuid = @lv_uuid
      into @data(ls_game).
    cl_aunit_assert=>assert_subrc( act = sy-subrc exp = 4 quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = sy-dbcnt exp = 0 quit = if_aunit_constants=>no ).

    select * from demo_chess_v_pos_cds
      where gameuuid = @lv_uuid
      into @data(ls_pos) up to 1 rows.
    endselect.
    cl_aunit_assert=>assert_subrc( act = sy-subrc exp = 4 quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = sy-dbcnt exp = 0 quit = if_aunit_constants=>no ).

    " check if everything has been released properly
    lo_object = cl_demo_sql_chess=>factory( io_uuid_factory = lo_uuid ).
    lo_object->delete( ).
  endmethod.

  method test_factory_from_pos_err5.
    data lo_exc type ref to cx_demo_sql_chess.
    data lo_object type ref to cl_demo_sql_chess.
    data lt_positions type cl_demo_sql_chess=>gtt_positions.
    data lv_catched type abap_bool.
    data lo_uuid type ref to lcl_system_uuid_mock2.
    data lv_uuid type sysuuid_c32.
    lt_positions = value #(
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king   x = 4 y = 8 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king   x = 7 y = 8 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_bishop x = 8 y = 8 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_pawn   x = 1 y = 8 ) " black pawn on last row
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_bishop x = 8 y = 3 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_knight x = 8 y = 2 )
    ).

    lv_uuid = cl_uuid_factory=>create_system_uuid( )->create_uuid_c32( ).
    lo_uuid = new #( lv_uuid ).

    try.
        lo_object = cl_demo_sql_chess=>factory_from_position(  io_uuid_factory = lo_uuid
                                                               is_settings  = value #( color = cl_demo_sql_chess=>c_color_black
                                                                                      castling_black_long  = abap_true
                                                                                      castling_black_short = abap_true
                                                                                      castling_white_long  = abap_true
                                                                                      castling_white_short = abap_true
                                                                                  )
                                                               it_positions = lt_positions ).
      catch cx_demo_sql_chess into lo_exc.
        if lo_exc->if_t100_message~t100key = cx_demo_sql_chess=>invalid_chess_position.
          lv_catched = abap_true.
        endif.
    endtry.
    cl_aunit_assert=>assert_equals( act = lv_catched  exp = abap_true  quit = if_aunit_constants=>no ).

    " check if rollback was successfull
    select single * from demo_chess_v_game_cds
      where gameuuid = @lv_uuid
      into @data(ls_game).
    cl_aunit_assert=>assert_subrc( act = sy-subrc exp = 4 quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = sy-dbcnt exp = 0 quit = if_aunit_constants=>no ).

    select * from demo_chess_v_pos_cds
      where gameuuid = @lv_uuid
      into @data(ls_pos) up to 1 rows.
    endselect.
    cl_aunit_assert=>assert_subrc( act = sy-subrc exp = 4 quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = sy-dbcnt exp = 0 quit = if_aunit_constants=>no ).

    " check if everything has been released properly
    lo_object = cl_demo_sql_chess=>factory( io_uuid_factory = lo_uuid ).
    lo_object->delete( ).
  endmethod.

  method test_factory_from_pos_err6.
    data lo_exc type ref to cx_demo_sql_chess.
    data lo_object type ref to cl_demo_sql_chess.
    data lt_positions type cl_demo_sql_chess=>gtt_positions.
    data lv_catched type abap_bool.
    data lo_uuid type ref to lcl_system_uuid_mock2.
    data lv_uuid type sysuuid_c32.
    lt_positions = value #(
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king   x = 4 y = 8 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king   x = 7 y = 8 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_bishop x = 8 y = 8 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_pawn   x = 1 y = 1 ) " white pawn on first row
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_bishop x = 8 y = 3 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_knight x = 8 y = 2 )
    ).

    lv_uuid = cl_uuid_factory=>create_system_uuid( )->create_uuid_c32( ).
    lo_uuid = new #( lv_uuid ).

    try.
        lo_object = cl_demo_sql_chess=>factory_from_position(  io_uuid_factory = lo_uuid
                                                               is_settings  = value #( color = cl_demo_sql_chess=>c_color_black
                                                                                      castling_black_long  = abap_true
                                                                                      castling_black_short = abap_true
                                                                                      castling_white_long  = abap_true
                                                                                      castling_white_short = abap_true
                                                                                  )
                                                               it_positions = lt_positions ).
      catch cx_demo_sql_chess into lo_exc.
        if lo_exc->if_t100_message~t100key = cx_demo_sql_chess=>invalid_chess_position.
          lv_catched = abap_true.
        endif.
    endtry.
    cl_aunit_assert=>assert_equals( act = lv_catched  exp = abap_true  quit = if_aunit_constants=>no ).

    " check if rollback was successfull
    select single * from demo_chess_v_game_cds
      where gameuuid = @lv_uuid
      into @data(ls_game).
    cl_aunit_assert=>assert_subrc( act = sy-subrc exp = 4 quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = sy-dbcnt exp = 0 quit = if_aunit_constants=>no ).

    select * from demo_chess_v_pos_cds
      where gameuuid = @lv_uuid
      into @data(ls_pos) up to 1 rows.
    endselect.
    cl_aunit_assert=>assert_subrc( act = sy-subrc exp = 4 quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = sy-dbcnt exp = 0 quit = if_aunit_constants=>no ).

    " check if everything has been released properly
    lo_object = cl_demo_sql_chess=>factory( io_uuid_factory = lo_uuid ).
    lo_object->delete( ).
  endmethod.

  method test_factory_from_pos_err7.
    data lo_exc type ref to cx_demo_sql_chess.
    data lo_object type ref to cl_demo_sql_chess.
    data lt_positions type cl_demo_sql_chess=>gtt_positions.
    data lv_catched type abap_bool.
    data lo_uuid type ref to lcl_system_uuid_mock2.
    data lv_uuid type sysuuid_c32.
    lt_positions = value #(
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king   x = 4 y = 8 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king   x = 7 y = 8 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_bishop x = 8 y = 8 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_bishop x = 8 y = 3 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_knight x = 9 y = 2 )
    ).

    lv_uuid = cl_uuid_factory=>create_system_uuid( )->create_uuid_c32( ).
    lo_uuid = new #( lv_uuid ).

    try.
        lo_object = cl_demo_sql_chess=>factory_from_position(  io_uuid_factory = lo_uuid
                                                               is_settings  = value #( color = cl_demo_sql_chess=>c_color_black
                                                                                      castling_black_long  = abap_true
                                                                                      castling_black_short = abap_true
                                                                                      castling_white_long  = abap_true
                                                                                      castling_white_short = abap_true
                                                                                  )
                                                               it_positions = lt_positions ).
      catch cx_demo_sql_chess into lo_exc.
        if lo_exc->if_t100_message~t100key = cx_demo_sql_chess=>invalid_chess_position.
          lv_catched = abap_true.
        endif.
    endtry.
    cl_aunit_assert=>assert_equals( act = lv_catched  exp = abap_true  quit = if_aunit_constants=>no ).

    " check if rollback was successfull
    select single * from demo_chess_v_game_cds
      where gameuuid = @lv_uuid
      into @data(ls_game).
    cl_aunit_assert=>assert_subrc( act = sy-subrc exp = 4 quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = sy-dbcnt exp = 0 quit = if_aunit_constants=>no ).

    select * from demo_chess_v_pos_cds
      where gameuuid = @lv_uuid
      into @data(ls_pos) up to 1 rows.
    endselect.
    cl_aunit_assert=>assert_subrc( act = sy-subrc exp = 4 quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = sy-dbcnt exp = 0 quit = if_aunit_constants=>no ).

    " check if everything has been released properly
    lo_object = cl_demo_sql_chess=>factory( io_uuid_factory = lo_uuid ).
    lo_object->delete( ).
  endmethod.

  method test_factory_from_pos_err8.
    data lo_exc type ref to cx_demo_sql_chess.
    data lo_object type ref to cl_demo_sql_chess.
    data lt_positions type cl_demo_sql_chess=>gtt_positions.
    data lv_catched type abap_bool.
    data lo_uuid type ref to lcl_system_uuid_mock2.
    data lv_uuid type sysuuid_c32.
    lt_positions = value #(
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king   x = 4 y = 8 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king   x = 7 y = 8 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_bishop x = 8 y = 8 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_bishop x = 8 y = 3 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_knight x = 0 y = 2 )
    ).

    lv_uuid = cl_uuid_factory=>create_system_uuid( )->create_uuid_c32( ).
    lo_uuid = new #( lv_uuid ).

    try.
        lo_object = cl_demo_sql_chess=>factory_from_position(  io_uuid_factory = lo_uuid
                                                               is_settings  = value #( color = cl_demo_sql_chess=>c_color_black
                                                                                      castling_black_long  = abap_true
                                                                                      castling_black_short = abap_true
                                                                                      castling_white_long  = abap_true
                                                                                      castling_white_short = abap_true
                                                                                  )
                                                               it_positions = lt_positions ).
      catch cx_demo_sql_chess into lo_exc.
        if lo_exc->if_t100_message~t100key = cx_demo_sql_chess=>invalid_chess_position.
          lv_catched = abap_true.
        endif.
    endtry.
    cl_aunit_assert=>assert_equals( act = lv_catched  exp = abap_true  quit = if_aunit_constants=>no ).

    " check if rollback was successfull
    select single * from demo_chess_v_game_cds
      where gameuuid = @lv_uuid
      into @data(ls_game).
    cl_aunit_assert=>assert_subrc( act = sy-subrc exp = 4 quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = sy-dbcnt exp = 0 quit = if_aunit_constants=>no ).

    select * from demo_chess_v_pos_cds
      where gameuuid = @lv_uuid
      into @data(ls_pos) up to 1 rows.
    endselect.
    cl_aunit_assert=>assert_subrc( act = sy-subrc exp = 4 quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = sy-dbcnt exp = 0 quit = if_aunit_constants=>no ).

    " check if everything has been released properly
    lo_object = cl_demo_sql_chess=>factory( io_uuid_factory = lo_uuid ).
    lo_object->delete( ).
  endmethod.

  method test_factory_from_pos_err9.
    data lo_exc type ref to cx_demo_sql_chess.
    data lo_object type ref to cl_demo_sql_chess.
    data lt_positions type cl_demo_sql_chess=>gtt_positions.
    data lv_catched type abap_bool.
    data lo_uuid type ref to lcl_system_uuid_mock2.
    data lv_uuid type sysuuid_c32.
    lt_positions = value #(
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king   x = 4 y = 8 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king   x = 7 y = 8 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_bishop x = 8 y = 8 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_bishop x = 8 y = 3 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_knight x = 1 y = 0 )
    ).

    lv_uuid = cl_uuid_factory=>create_system_uuid( )->create_uuid_c32( ).
    lo_uuid = new #( lv_uuid ).

    try.
        lo_object = cl_demo_sql_chess=>factory_from_position(  io_uuid_factory = lo_uuid
                                                               is_settings  = value #( color = cl_demo_sql_chess=>c_color_black
                                                                                      castling_black_long  = abap_true
                                                                                      castling_black_short = abap_true
                                                                                      castling_white_long  = abap_true
                                                                                      castling_white_short = abap_true
                                                                                  )
                                                               it_positions = lt_positions ).
      catch cx_demo_sql_chess into lo_exc.
        if lo_exc->if_t100_message~t100key = cx_demo_sql_chess=>invalid_chess_position.
          lv_catched = abap_true.
        endif.
    endtry.
    cl_aunit_assert=>assert_equals( act = lv_catched  exp = abap_true  quit = if_aunit_constants=>no ).

    " check if rollback was successfull
    select single * from demo_chess_v_game_cds
      where gameuuid = @lv_uuid
      into @data(ls_game).
    cl_aunit_assert=>assert_subrc( act = sy-subrc exp = 4 quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = sy-dbcnt exp = 0 quit = if_aunit_constants=>no ).

    select * from demo_chess_v_pos_cds
      where gameuuid = @lv_uuid
      into @data(ls_pos) up to 1 rows.
    endselect.
    cl_aunit_assert=>assert_subrc( act = sy-subrc exp = 4 quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = sy-dbcnt exp = 0 quit = if_aunit_constants=>no ).

    " check if everything has been released properly
    lo_object = cl_demo_sql_chess=>factory( io_uuid_factory = lo_uuid ).
    lo_object->delete( ).
  endmethod.
  method test_stage5_initial. " test all moves from initial chess position
    data lo_object type ref to cl_demo_sql_chess.

    types begin of lty_expected.
    types color type demo_chess_color.
    types chessman type demo_chess_chessman.
    types from_x type demo_chess_xpos.
    types from_y type demo_chess_xpos.
    types to_x type demo_chess_xpos.
    types to_y type demo_chess_xpos.
    types end of lty_expected.
    data lt_expected type sorted table of lty_expected with unique key from_x from_y to_x to_y.
    data lt_actual type sorted table of lty_expected with unique key from_x from_y to_x to_y.
    lt_expected = value #(
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_pawn   from_x = 1 from_y = 2 to_x = 1 to_y = 3 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_pawn   from_x = 1 from_y = 2 to_x = 1 to_y = 4 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_knight from_x = 2 from_y = 1 to_x = 1 to_y = 3 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_knight from_x = 2 from_y = 1 to_x = 3 to_y = 3 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_pawn   from_x = 2 from_y = 2 to_x = 2 to_y = 3 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_pawn   from_x = 2 from_y = 2 to_x = 2 to_y = 4 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_pawn   from_x = 3 from_y = 2 to_x = 3 to_y = 3 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_pawn   from_x = 3 from_y = 2 to_x = 3 to_y = 4 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_pawn   from_x = 4 from_y = 2 to_x = 4 to_y = 3 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_pawn   from_x = 4 from_y = 2 to_x = 4 to_y = 4 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_pawn   from_x = 5 from_y = 2 to_x = 5 to_y = 3 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_pawn   from_x = 5 from_y = 2 to_x = 5 to_y = 4 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_pawn   from_x = 6 from_y = 2 to_x = 6 to_y = 3 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_pawn   from_x = 6 from_y = 2 to_x = 6 to_y = 4 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_knight from_x = 7 from_y = 1 to_x = 6 to_y = 3 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_knight from_x = 7 from_y = 1 to_x = 8 to_y = 3 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_pawn   from_x = 7 from_y = 2 to_x = 7 to_y = 3 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_pawn   from_x = 7 from_y = 2 to_x = 7 to_y = 4 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_pawn   from_x = 8 from_y = 2 to_x = 8 to_y = 3 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_pawn   from_x = 8 from_y = 2 to_x = 8 to_y = 4 )
    ).
    lo_object = cl_demo_sql_chess=>factory( ).
    select * from demo_chess_v_stage5
      where gameuuid = @lo_object->gv_gameuuid
      order by from_x, from_y, to_x, to_y
      into corresponding fields of table @lt_actual.
    cl_aunit_assert=>assert_subrc( act = sy-subrc quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = sy-dbcnt exp = 20 quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = lt_actual exp = lt_expected quit = if_aunit_constants=>no ).

    " check the result of get_next_moves
    data lv_mate type abap_bool.
    data lt_moves type cl_demo_sql_chess=>gtt_moves.
    data lt_expected_moves type cl_demo_sql_chess=>gtt_moves.
    lt_expected_moves = corresponding #( lt_expected ).
    lv_mate = lo_object->get_next_moves( importing et_moves = lt_moves ).
    cl_aunit_assert=>assert_equals( act = lv_mate exp = abap_false quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = lt_moves exp = lt_expected_moves quit = if_aunit_constants=>no ).

    lo_object->delete( ).
  endmethod.

  method test_stage5_pawn_001. " test en passant from white
    data lo_object type ref to cl_demo_sql_chess.
    types begin of lty_expected.
    types color type demo_chess_color.
    types chessman type demo_chess_chessman.
    types from_x type demo_chess_xpos.
    types from_y type demo_chess_xpos.
    types to_x type demo_chess_xpos.
    types to_y type demo_chess_xpos.
    types end of lty_expected.
    data lt_expected type sorted table of lty_expected with unique key from_x from_y to_x to_y.
    data lt_actual type sorted table of lty_expected with unique key from_x from_y to_x to_y.
    data lt_positions type cl_demo_sql_chess=>gtt_positions.
    lt_positions = value #(
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king   x = 5 y = 8 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king   x = 5 y = 1 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_pawn   x = 1 y = 4 before_x = 1 before_y = 2 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_pawn   x = 2 y = 4 )
    ).
    lt_expected = value #(
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_pawn   from_x = 2 from_y = 4 to_x = 2 to_y = 3 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_pawn   from_x = 2 from_y = 4 to_x = 1 to_y = 3 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king   from_x = 5 from_y = 8 to_x = 4 to_y = 7 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king   from_x = 5 from_y = 8 to_x = 4 to_y = 8 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king   from_x = 5 from_y = 8 to_x = 5 to_y = 7 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king   from_x = 5 from_y = 8 to_x = 6 to_y = 7 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king   from_x = 5 from_y = 8 to_x = 6 to_y = 8 )
    ).
    lo_object = cl_demo_sql_chess=>factory_from_position( is_settings  = value #( color = cl_demo_sql_chess=>c_color_black )
                                                          it_positions = lt_positions ).
    select * from demo_chess_v_stage5
      where gameuuid = @lo_object->gv_gameuuid
      order by from_x, from_y, to_x, to_y
      into corresponding fields of table @lt_actual.
    cl_aunit_assert=>assert_subrc( act = sy-subrc quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = sy-dbcnt exp = 7 quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = lt_actual exp = lt_expected quit = if_aunit_constants=>no ).

    " check the result of get_next_moves
    data lv_mate type abap_bool.
    data lt_moves type cl_demo_sql_chess=>gtt_moves.
    data lt_expected_moves type cl_demo_sql_chess=>gtt_moves.
    lt_expected_moves = corresponding #( lt_expected ).
    lv_mate = lo_object->get_next_moves( importing et_moves = lt_moves ).
    cl_aunit_assert=>assert_equals( act = lv_mate exp = abap_false quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = lt_moves exp = lt_expected_moves quit = if_aunit_constants=>no ).

    lo_object->delete( ).
  endmethod.

  method test_stage5_pawn_002. " test en passant from white, negative test, e.g. no en passant
    data lo_object type ref to cl_demo_sql_chess.
    types begin of lty_expected.
    types color type demo_chess_color.
    types chessman type demo_chess_chessman.
    types from_x type demo_chess_xpos.
    types from_y type demo_chess_xpos.
    types to_x type demo_chess_xpos.
    types to_y type demo_chess_xpos.
    types end of lty_expected.
    data lt_expected type sorted table of lty_expected with unique key from_x from_y to_x to_y.
    data lt_actual type sorted table of lty_expected with unique key from_x from_y to_x to_y.
    data lt_positions type cl_demo_sql_chess=>gtt_positions.
    lt_positions = value #(
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king   x = 5 y = 8 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king   x = 5 y = 1 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_pawn   x = 1 y = 4 before_x = 1 before_y = 3 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_pawn   x = 2 y = 4 )
    ).
    lt_expected = value #(
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_pawn   from_x = 2 from_y = 4 to_x = 2 to_y = 3 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king   from_x = 5 from_y = 8 to_x = 4 to_y = 7 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king   from_x = 5 from_y = 8 to_x = 4 to_y = 8 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king   from_x = 5 from_y = 8 to_x = 5 to_y = 7 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king   from_x = 5 from_y = 8 to_x = 6 to_y = 7 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king   from_x = 5 from_y = 8 to_x = 6 to_y = 8 )
    ).
    lo_object = cl_demo_sql_chess=>factory_from_position( is_settings  = value #( color = cl_demo_sql_chess=>c_color_black )
                                                          it_positions = lt_positions ).
    select * from demo_chess_v_stage5
      where gameuuid = @lo_object->gv_gameuuid
      order by from_x, from_y, to_x, to_y
      into corresponding fields of table @lt_actual.
    cl_aunit_assert=>assert_subrc( act = sy-subrc quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = sy-dbcnt exp = 6 quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = lt_actual exp = lt_expected quit = if_aunit_constants=>no ).

    " check the result of get_next_moves
    data lv_mate type abap_bool.
    data lt_moves type cl_demo_sql_chess=>gtt_moves.
    data lt_expected_moves type cl_demo_sql_chess=>gtt_moves.
    lt_expected_moves = corresponding #( lt_expected ).
    lv_mate = lo_object->get_next_moves( importing et_moves = lt_moves ).
    cl_aunit_assert=>assert_equals( act = lv_mate exp = abap_false quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = lt_moves exp = lt_expected_moves quit = if_aunit_constants=>no ).

    lo_object->delete( ).
  endmethod.

  method test_stage5_pawn_003. " test en passant from black
    data lo_object type ref to cl_demo_sql_chess.
    types begin of lty_expected.
    types color type demo_chess_color.
    types chessman type demo_chess_chessman.
    types from_x type demo_chess_xpos.
    types from_y type demo_chess_xpos.
    types to_x type demo_chess_xpos.
    types to_y type demo_chess_xpos.
    types end of lty_expected.
    data lt_expected type sorted table of lty_expected with unique key from_x from_y to_x to_y.
    data lt_actual type sorted table of lty_expected with unique key from_x from_y to_x to_y.
    data lt_positions type cl_demo_sql_chess=>gtt_positions.
    lt_positions = value #(
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king   x = 5 y = 1 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king   x = 5 y = 8 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_pawn   x = 4 y = 5 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_pawn   x = 5 y = 5 before_x = 5 before_y = 7 )
    ).
    lt_expected = value #(
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_pawn   from_x = 4 from_y = 5 to_x = 4 to_y = 6 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_pawn   from_x = 4 from_y = 5 to_x = 5 to_y = 6 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king   from_x = 5 from_y = 1 to_x = 4 to_y = 1 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king   from_x = 5 from_y = 1 to_x = 4 to_y = 2 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king   from_x = 5 from_y = 1 to_x = 5 to_y = 2 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king   from_x = 5 from_y = 1 to_x = 6 to_y = 1 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king   from_x = 5 from_y = 1 to_x = 6 to_y = 2 )
    ).
    lo_object = cl_demo_sql_chess=>factory_from_position( is_settings  = value #( color = cl_demo_sql_chess=>c_color_white )
                                                          it_positions = lt_positions ).
    select * from demo_chess_v_stage5
      where gameuuid = @lo_object->gv_gameuuid
      order by from_x, from_y, to_x, to_y
      into corresponding fields of table @lt_actual.
    cl_aunit_assert=>assert_subrc( act = sy-subrc quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = sy-dbcnt exp = 7 quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = lt_actual exp = lt_expected quit = if_aunit_constants=>no ).

    " check the result of get_next_moves
    data lv_mate type abap_bool.
    data lt_moves type cl_demo_sql_chess=>gtt_moves.
    data lt_expected_moves type cl_demo_sql_chess=>gtt_moves.
    lt_expected_moves = corresponding #( lt_expected ).
    lv_mate = lo_object->get_next_moves( importing et_moves = lt_moves ).
    cl_aunit_assert=>assert_equals( act = lv_mate exp = abap_false quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = lt_moves exp = lt_expected_moves quit = if_aunit_constants=>no ).

    lo_object->delete( ).
  endmethod.

  method test_stage5_pawn_004. " test en passant from black
    data lo_object type ref to cl_demo_sql_chess.
    types begin of lty_expected.
    types color type demo_chess_color.
    types chessman type demo_chess_chessman.
    types from_x type demo_chess_xpos.
    types from_y type demo_chess_xpos.
    types to_x type demo_chess_xpos.
    types to_y type demo_chess_xpos.
    types end of lty_expected.
    data lt_expected type sorted table of lty_expected with unique key from_x from_y to_x to_y.
    data lt_actual type sorted table of lty_expected with unique key from_x from_y to_x to_y.
    data lt_positions type cl_demo_sql_chess=>gtt_positions.
    lt_positions = value #(
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king   x = 5 y = 1 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king   x = 5 y = 8 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_pawn   x = 4 y = 5 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_pawn   x = 5 y = 5 before_x = 5 before_y = 7 )
    ).
    lt_expected = value #(
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_pawn   from_x = 4 from_y = 5 to_x = 4 to_y = 6 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_pawn   from_x = 4 from_y = 5 to_x = 5 to_y = 6 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king   from_x = 5 from_y = 1 to_x = 4 to_y = 1 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king   from_x = 5 from_y = 1 to_x = 4 to_y = 2 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king   from_x = 5 from_y = 1 to_x = 5 to_y = 2 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king   from_x = 5 from_y = 1 to_x = 6 to_y = 1 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king   from_x = 5 from_y = 1 to_x = 6 to_y = 2 )
    ).
    lo_object = cl_demo_sql_chess=>factory_from_position( is_settings  = value #( color = cl_demo_sql_chess=>c_color_white )
                                                          it_positions = lt_positions ).
    select * from demo_chess_v_stage5
      where gameuuid = @lo_object->gv_gameuuid
      order by from_x, from_y, to_x, to_y
      into corresponding fields of table @lt_actual.
    cl_aunit_assert=>assert_subrc( act = sy-subrc quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = sy-dbcnt exp = 7 quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = lt_actual exp = lt_expected quit = if_aunit_constants=>no ).

    " check the result of get_next_moves
    data lv_mate type abap_bool.
    data lt_moves type cl_demo_sql_chess=>gtt_moves.
    data lt_expected_moves type cl_demo_sql_chess=>gtt_moves.
    lt_expected_moves = corresponding #( lt_expected ).
    lv_mate = lo_object->get_next_moves( importing et_moves = lt_moves ).
    cl_aunit_assert=>assert_equals( act = lv_mate exp = abap_false quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = lt_moves exp = lt_expected_moves quit = if_aunit_constants=>no ).

    lo_object->delete( ).
  endmethod.

  method test_stage5_pawn_005. " test straight movement of pawn
    data lo_object type ref to cl_demo_sql_chess.
    types begin of lty_expected.
    types color type demo_chess_color.
    types chessman type demo_chess_chessman.
    types from_x type demo_chess_xpos.
    types from_y type demo_chess_xpos.
    types to_x type demo_chess_xpos.
    types to_y type demo_chess_xpos.
    types end of lty_expected.
    data lt_expected type sorted table of lty_expected with unique key from_x from_y to_x to_y.
    data lt_actual type sorted table of lty_expected with unique key from_x from_y to_x to_y.
    data lt_positions type cl_demo_sql_chess=>gtt_positions.
    lt_positions = value #(
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king   x = 5 y = 1 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king   x = 5 y = 8 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_pawn   x = 1 y = 2 )
    ).
    lt_expected = value #(
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_pawn   from_x = 1 from_y = 2 to_x = 1 to_y = 3 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_pawn   from_x = 1 from_y = 2 to_x = 1 to_y = 4 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king   from_x = 5 from_y = 1 to_x = 4 to_y = 1 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king   from_x = 5 from_y = 1 to_x = 4 to_y = 2 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king   from_x = 5 from_y = 1 to_x = 5 to_y = 2 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king   from_x = 5 from_y = 1 to_x = 6 to_y = 1 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king   from_x = 5 from_y = 1 to_x = 6 to_y = 2 )
    ).
    lo_object = cl_demo_sql_chess=>factory_from_position( is_settings  = value #( color = cl_demo_sql_chess=>c_color_white )
                                                          it_positions = lt_positions ).
    select * from demo_chess_v_stage5
      where gameuuid = @lo_object->gv_gameuuid
      order by from_x, from_y, to_x, to_y
      into corresponding fields of table @lt_actual.
    cl_aunit_assert=>assert_subrc( act = sy-subrc quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = sy-dbcnt exp = 7 quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = lt_actual exp = lt_expected quit = if_aunit_constants=>no ).

    " check the result of get_next_moves
    data lv_mate type abap_bool.
    data lt_moves type cl_demo_sql_chess=>gtt_moves.
    data lt_expected_moves type cl_demo_sql_chess=>gtt_moves.
    lt_expected_moves = corresponding #( lt_expected ).
    lv_mate = lo_object->get_next_moves( importing et_moves = lt_moves ).
    cl_aunit_assert=>assert_equals( act = lv_mate exp = abap_false quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = lt_moves exp = lt_expected_moves quit = if_aunit_constants=>no ).

    lo_object->delete( ).
  endmethod.

  method test_stage5_pawn_006. " test straight movement of pawn
    data lo_object type ref to cl_demo_sql_chess.
    types begin of lty_expected.
    types color type demo_chess_color.
    types chessman type demo_chess_chessman.
    types from_x type demo_chess_xpos.
    types from_y type demo_chess_xpos.
    types to_x type demo_chess_xpos.
    types to_y type demo_chess_xpos.
    types end of lty_expected.
    data lt_expected type sorted table of lty_expected with unique key from_x from_y to_x to_y.
    data lt_actual type sorted table of lty_expected with unique key from_x from_y to_x to_y.
    data lt_positions type cl_demo_sql_chess=>gtt_positions.
    lt_positions = value #(
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_pawn   x = 5 y = 7 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king   x = 5 y = 8 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king   x = 1 y = 2 )
    ).
    lt_expected = value #(
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_pawn   from_x = 5 from_y = 7 to_x = 5 to_y = 5 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_pawn   from_x = 5 from_y = 7 to_x = 5 to_y = 6 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king   from_x = 5 from_y = 8 to_x = 4 to_y = 7 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king   from_x = 5 from_y = 8 to_x = 4 to_y = 8 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king   from_x = 5 from_y = 8 to_x = 6 to_y = 7 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king   from_x = 5 from_y = 8 to_x = 6 to_y = 8 )
    ).
    lo_object = cl_demo_sql_chess=>factory_from_position( is_settings  = value #( color = cl_demo_sql_chess=>c_color_black )
                                                          it_positions = lt_positions ).
    select * from demo_chess_v_stage5
      where gameuuid = @lo_object->gv_gameuuid
      order by from_x, from_y, to_x, to_y
      into corresponding fields of table @lt_actual.
    cl_aunit_assert=>assert_subrc( act = sy-subrc quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = sy-dbcnt exp = 6 quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = lt_actual exp = lt_expected quit = if_aunit_constants=>no ).

    " check the result of get_next_moves
    data lv_mate type abap_bool.
    data lt_moves type cl_demo_sql_chess=>gtt_moves.
    data lt_expected_moves type cl_demo_sql_chess=>gtt_moves.
    lt_expected_moves = corresponding #( lt_expected ).
    lv_mate = lo_object->get_next_moves( importing et_moves = lt_moves ).
    cl_aunit_assert=>assert_equals( act = lv_mate exp = abap_false quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = lt_moves exp = lt_expected_moves quit = if_aunit_constants=>no ).

    lo_object->delete( ).
  endmethod.

  method test_stage5_pawn_007. " test straight movement of pawn
    data lo_object type ref to cl_demo_sql_chess.
    types begin of lty_expected.
    types color type demo_chess_color.
    types chessman type demo_chess_chessman.
    types from_x type demo_chess_xpos.
    types from_y type demo_chess_xpos.
    types to_x type demo_chess_xpos.
    types to_y type demo_chess_xpos.
    types end of lty_expected.
    data lt_expected type sorted table of lty_expected with unique key from_x from_y to_x to_y.
    data lt_actual type sorted table of lty_expected with unique key from_x from_y to_x to_y.
    data lt_positions type cl_demo_sql_chess=>gtt_positions.
    lt_positions = value #(
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king   x = 5 y = 1 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king   x = 5 y = 8 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_pawn   x = 1 y = 2 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_pawn   x = 1 y = 3 )
    ).
    lt_expected = value #(
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king   from_x = 5 from_y = 1 to_x = 4 to_y = 1 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king   from_x = 5 from_y = 1 to_x = 4 to_y = 2 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king   from_x = 5 from_y = 1 to_x = 5 to_y = 2 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king   from_x = 5 from_y = 1 to_x = 6 to_y = 1 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king   from_x = 5 from_y = 1 to_x = 6 to_y = 2 )
    ).
    lo_object = cl_demo_sql_chess=>factory_from_position( is_settings  = value #( color = cl_demo_sql_chess=>c_color_white )
                                                          it_positions = lt_positions ).
    select * from demo_chess_v_stage5
      where gameuuid = @lo_object->gv_gameuuid
      order by from_x, from_y, to_x, to_y
      into corresponding fields of table @lt_actual.
    cl_aunit_assert=>assert_subrc( act = sy-subrc quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = sy-dbcnt exp = 5 quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = lt_actual exp = lt_expected quit = if_aunit_constants=>no ).

    " check the result of get_next_moves
    data lv_mate type abap_bool.
    data lt_moves type cl_demo_sql_chess=>gtt_moves.
    data lt_expected_moves type cl_demo_sql_chess=>gtt_moves.
    lt_expected_moves = corresponding #( lt_expected ).
    lv_mate = lo_object->get_next_moves( importing et_moves = lt_moves ).
    cl_aunit_assert=>assert_equals( act = lv_mate exp = abap_false quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = lt_moves exp = lt_expected_moves quit = if_aunit_constants=>no ).

    lo_object->delete( ).
  endmethod.

  method test_stage5_pawn_008. " test straight movement of pawn
    data lo_object type ref to cl_demo_sql_chess.
    types begin of lty_expected.
    types color type demo_chess_color.
    types chessman type demo_chess_chessman.
    types from_x type demo_chess_xpos.
    types from_y type demo_chess_xpos.
    types to_x type demo_chess_xpos.
    types to_y type demo_chess_xpos.
    types end of lty_expected.
    data lt_expected type sorted table of lty_expected with unique key from_x from_y to_x to_y.
    data lt_actual type sorted table of lty_expected with unique key from_x from_y to_x to_y.
    data lt_positions type cl_demo_sql_chess=>gtt_positions.
    lt_positions = value #(
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_pawn   x = 5 y = 7 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_pawn   x = 5 y = 6 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king   x = 5 y = 8 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king   x = 1 y = 2 )
    ).
    lt_expected = value #(
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king   from_x = 5 from_y = 8 to_x = 4 to_y = 7 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king   from_x = 5 from_y = 8 to_x = 4 to_y = 8 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king   from_x = 5 from_y = 8 to_x = 6 to_y = 7 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king   from_x = 5 from_y = 8 to_x = 6 to_y = 8 )
    ).
    lo_object = cl_demo_sql_chess=>factory_from_position( is_settings  = value #( color = cl_demo_sql_chess=>c_color_black )
                                                          it_positions = lt_positions ).
    select * from demo_chess_v_stage5
      where gameuuid = @lo_object->gv_gameuuid
      order by from_x, from_y, to_x, to_y
      into corresponding fields of table @lt_actual.
    cl_aunit_assert=>assert_subrc( act = sy-subrc quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = sy-dbcnt exp = 4 quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = lt_actual exp = lt_expected quit = if_aunit_constants=>no ).

    " check the result of get_next_moves
    data lv_mate type abap_bool.
    data lt_moves type cl_demo_sql_chess=>gtt_moves.
    data lt_expected_moves type cl_demo_sql_chess=>gtt_moves.
    lt_expected_moves = value #(
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king   from_x = 5 from_y = 8 to_x = 4 to_y = 8 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king   from_x = 5 from_y = 8 to_x = 6 to_y = 8 )
    ).
    lv_mate = lo_object->get_next_moves( importing et_moves = lt_moves ).
    cl_aunit_assert=>assert_equals( act = lv_mate exp = abap_false quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = lt_moves exp = lt_expected_moves quit = if_aunit_constants=>no ).

    lo_object->delete( ).
  endmethod.

  method test_stage5_pawn_009. " test straight movement of pawn
    data lo_object type ref to cl_demo_sql_chess.
    types begin of lty_expected.
    types color type demo_chess_color.
    types chessman type demo_chess_chessman.
    types from_x type demo_chess_xpos.
    types from_y type demo_chess_xpos.
    types to_x type demo_chess_xpos.
    types to_y type demo_chess_xpos.
    types end of lty_expected.
    data lt_expected type sorted table of lty_expected with unique key from_x from_y to_x to_y.
    data lt_actual type sorted table of lty_expected with unique key from_x from_y to_x to_y.
    data lt_positions type cl_demo_sql_chess=>gtt_positions.
    lt_positions = value #(
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king   x = 5 y = 1 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king   x = 5 y = 8 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_pawn   x = 1 y = 3 )
    ).
    lt_expected = value #(
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_pawn   from_x = 1 from_y = 3 to_x = 1 to_y = 4 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king   from_x = 5 from_y = 1 to_x = 4 to_y = 1 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king   from_x = 5 from_y = 1 to_x = 4 to_y = 2 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king   from_x = 5 from_y = 1 to_x = 5 to_y = 2 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king   from_x = 5 from_y = 1 to_x = 6 to_y = 1 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king   from_x = 5 from_y = 1 to_x = 6 to_y = 2 )
    ).
    lo_object = cl_demo_sql_chess=>factory_from_position( is_settings  = value #( color = cl_demo_sql_chess=>c_color_white )
                                                          it_positions = lt_positions ).
    select * from demo_chess_v_stage5
      where gameuuid = @lo_object->gv_gameuuid
      order by from_x, from_y, to_x, to_y
      into corresponding fields of table @lt_actual.
    cl_aunit_assert=>assert_subrc( act = sy-subrc quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = sy-dbcnt exp = 6 quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = lt_actual exp = lt_expected quit = if_aunit_constants=>no ).

    " check the result of get_next_moves
    data lv_mate type abap_bool.
    data lt_moves type cl_demo_sql_chess=>gtt_moves.
    data lt_expected_moves type cl_demo_sql_chess=>gtt_moves.
    lt_expected_moves = corresponding #( lt_expected ).
    lv_mate = lo_object->get_next_moves( importing et_moves = lt_moves ).
    cl_aunit_assert=>assert_equals( act = lv_mate exp = abap_false quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = lt_moves exp = lt_expected_moves quit = if_aunit_constants=>no ).

    lo_object->delete( ).
  endmethod.

  method test_stage5_pawn_010. " test straight movement of pawn
    data lo_object type ref to cl_demo_sql_chess.
    types begin of lty_expected.
    types color type demo_chess_color.
    types chessman type demo_chess_chessman.
    types from_x type demo_chess_xpos.
    types from_y type demo_chess_xpos.
    types to_x type demo_chess_xpos.
    types to_y type demo_chess_xpos.
    types end of lty_expected.
    data lt_expected type sorted table of lty_expected with unique key from_x from_y to_x to_y.
    data lt_actual type sorted table of lty_expected with unique key from_x from_y to_x to_y.
    data lt_positions type cl_demo_sql_chess=>gtt_positions.
    lt_positions = value #(
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_pawn   x = 5 y = 6 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king   x = 5 y = 8 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king   x = 5 y = 1 )
    ).
    lt_expected = value #(
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_pawn   from_x = 5 from_y = 6 to_x = 5 to_y = 5 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king   from_x = 5 from_y = 8 to_x = 4 to_y = 7 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king   from_x = 5 from_y = 8 to_x = 4 to_y = 8 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king   from_x = 5 from_y = 8 to_x = 5 to_y = 7 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king   from_x = 5 from_y = 8 to_x = 6 to_y = 7 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king   from_x = 5 from_y = 8 to_x = 6 to_y = 8 )
    ).
    lo_object = cl_demo_sql_chess=>factory_from_position( is_settings  = value #( color = cl_demo_sql_chess=>c_color_black )
                                                          it_positions = lt_positions ).
    select * from demo_chess_v_stage5
      where gameuuid = @lo_object->gv_gameuuid
      order by from_x, from_y, to_x, to_y
      into corresponding fields of table @lt_actual.
    cl_aunit_assert=>assert_subrc( act = sy-subrc quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = sy-dbcnt exp = 6 quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = lt_actual exp = lt_expected quit = if_aunit_constants=>no ).

    " check the result of get_next_moves
    data lv_mate type abap_bool.
    data lt_moves type cl_demo_sql_chess=>gtt_moves.
    data lt_expected_moves type cl_demo_sql_chess=>gtt_moves.
    lt_expected_moves = corresponding #( lt_expected ).
    lv_mate = lo_object->get_next_moves( importing et_moves = lt_moves ).
    cl_aunit_assert=>assert_equals( act = lv_mate exp = abap_false quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = lt_moves exp = lt_expected_moves quit = if_aunit_constants=>no ).

    lo_object->delete( ).
  endmethod.

  method test_stage5_pawn_011. " test diagnonal movement of pawn
    data lo_object type ref to cl_demo_sql_chess.
    types begin of lty_expected.
    types color type demo_chess_color.
    types chessman type demo_chess_chessman.
    types from_x type demo_chess_xpos.
    types from_y type demo_chess_xpos.
    types to_x type demo_chess_xpos.
    types to_y type demo_chess_xpos.
    types end of lty_expected.
    data lt_expected type sorted table of lty_expected with unique key from_x from_y to_x to_y.
    data lt_actual type sorted table of lty_expected with unique key from_x from_y to_x to_y.
    data lt_positions type cl_demo_sql_chess=>gtt_positions.
    lt_positions = value #(
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king   x = 5 y = 1 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king   x = 5 y = 8 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_pawn   x = 1 y = 2 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_pawn   x = 2 y = 3 )
    ).
    lt_expected = value #(
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_pawn   from_x = 1 from_y = 2 to_x = 1 to_y = 3 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_pawn   from_x = 1 from_y = 2 to_x = 1 to_y = 4 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_pawn   from_x = 1 from_y = 2 to_x = 2 to_y = 3 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king   from_x = 5 from_y = 1 to_x = 4 to_y = 1 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king   from_x = 5 from_y = 1 to_x = 4 to_y = 2 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king   from_x = 5 from_y = 1 to_x = 5 to_y = 2 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king   from_x = 5 from_y = 1 to_x = 6 to_y = 1 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king   from_x = 5 from_y = 1 to_x = 6 to_y = 2 )
    ).
    lo_object = cl_demo_sql_chess=>factory_from_position( is_settings  = value #( color = cl_demo_sql_chess=>c_color_white )
                                                          it_positions = lt_positions ).
    select * from demo_chess_v_stage5
      where gameuuid = @lo_object->gv_gameuuid
      order by from_x, from_y, to_x, to_y
      into corresponding fields of table @lt_actual.
    cl_aunit_assert=>assert_subrc( act = sy-subrc quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = sy-dbcnt exp = 8 quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = lt_actual exp = lt_expected quit = if_aunit_constants=>no ).

    " check the result of get_next_moves
    data lv_mate type abap_bool.
    data lt_moves type cl_demo_sql_chess=>gtt_moves.
    data lt_expected_moves type cl_demo_sql_chess=>gtt_moves.
    lt_expected_moves = corresponding #( lt_expected ).
    lv_mate = lo_object->get_next_moves( importing et_moves = lt_moves ).
    cl_aunit_assert=>assert_equals( act = lv_mate exp = abap_false quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = lt_moves exp = lt_expected_moves quit = if_aunit_constants=>no ).

    lo_object->delete( ).
  endmethod.

  method test_stage5_pawn_012. " test diagonal movement of pawn
    data lo_object type ref to cl_demo_sql_chess.
    types begin of lty_expected.
    types color type demo_chess_color.
    types chessman type demo_chess_chessman.
    types from_x type demo_chess_xpos.
    types from_y type demo_chess_xpos.
    types to_x type demo_chess_xpos.
    types to_y type demo_chess_xpos.
    types end of lty_expected.
    data lt_expected type sorted table of lty_expected with unique key from_x from_y to_x to_y.
    data lt_actual type sorted table of lty_expected with unique key from_x from_y to_x to_y.
    data lt_positions type cl_demo_sql_chess=>gtt_positions.
    lt_positions = value #(
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_pawn    x = 5 y = 7 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_bishop  x = 4 y = 6 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king    x = 5 y = 8 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king    x = 5 y = 1 )
    ).
    lt_expected = value #(
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_pawn   from_x = 5 from_y = 7 to_x = 4 to_y = 6 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_pawn   from_x = 5 from_y = 7 to_x = 5 to_y = 6 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_pawn   from_x = 5 from_y = 7 to_x = 5 to_y = 5 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king   from_x = 5 from_y = 8 to_x = 4 to_y = 7 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king   from_x = 5 from_y = 8 to_x = 4 to_y = 8 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king   from_x = 5 from_y = 8 to_x = 6 to_y = 7 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king   from_x = 5 from_y = 8 to_x = 6 to_y = 8 )
    ).
    lo_object = cl_demo_sql_chess=>factory_from_position( is_settings  = value #( color = cl_demo_sql_chess=>c_color_black )
                                                          it_positions = lt_positions ).
    select * from demo_chess_v_stage5
      where gameuuid = @lo_object->gv_gameuuid
      order by from_x, from_y, to_x, to_y
      into corresponding fields of table @lt_actual.
    cl_aunit_assert=>assert_subrc( act = sy-subrc quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = sy-dbcnt exp = 7 quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = lt_actual exp = lt_expected quit = if_aunit_constants=>no ).

    " check the result of get_next_moves
    data lv_mate type abap_bool.
    data lt_moves type cl_demo_sql_chess=>gtt_moves.
    data lt_expected_moves type cl_demo_sql_chess=>gtt_moves.
    lt_expected_moves = corresponding #( lt_expected ).
    lv_mate = lo_object->get_next_moves( importing et_moves = lt_moves ).
    cl_aunit_assert=>assert_equals( act = lv_mate exp = abap_false quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = lt_moves exp = lt_expected_moves quit = if_aunit_constants=>no ).

    lo_object->delete( ).
  endmethod.

  method test_stage5_pawn_013. " test diagnonal movement of pawn
    data lo_object type ref to cl_demo_sql_chess.
    types begin of lty_expected.
    types color type demo_chess_color.
    types chessman type demo_chess_chessman.
    types from_x type demo_chess_xpos.
    types from_y type demo_chess_xpos.
    types to_x type demo_chess_xpos.
    types to_y type demo_chess_xpos.
    types end of lty_expected.
    data lt_expected type sorted table of lty_expected with unique key from_x from_y to_x to_y.
    data lt_actual type sorted table of lty_expected with unique key from_x from_y to_x to_y.
    data lt_positions type cl_demo_sql_chess=>gtt_positions.
    lt_positions = value #(
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king   x = 5 y = 1 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king   x = 5 y = 8 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_pawn   x = 1 y = 2 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_pawn   x = 2 y = 3 )
    ).
    lt_expected = value #(
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_pawn   from_x = 1 from_y = 2 to_x = 1 to_y = 3 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_pawn   from_x = 1 from_y = 2 to_x = 1 to_y = 4 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_pawn   from_x = 2 from_y = 3 to_x = 2 to_y = 4 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king   from_x = 5 from_y = 1 to_x = 4 to_y = 1 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king   from_x = 5 from_y = 1 to_x = 4 to_y = 2 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king   from_x = 5 from_y = 1 to_x = 5 to_y = 2 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king   from_x = 5 from_y = 1 to_x = 6 to_y = 1 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king   from_x = 5 from_y = 1 to_x = 6 to_y = 2 )
    ).
    lo_object = cl_demo_sql_chess=>factory_from_position( is_settings  = value #( color = cl_demo_sql_chess=>c_color_white )
                                                          it_positions = lt_positions ).
    select * from demo_chess_v_stage5
      where gameuuid = @lo_object->gv_gameuuid
      order by from_x, from_y, to_x, to_y
      into corresponding fields of table @lt_actual.
    cl_aunit_assert=>assert_subrc( act = sy-subrc quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = sy-dbcnt exp = 8 quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = lt_actual exp = lt_expected quit = if_aunit_constants=>no ).

    " check the result of get_next_moves
    data lv_mate type abap_bool.
    data lt_moves type cl_demo_sql_chess=>gtt_moves.
    data lt_expected_moves type cl_demo_sql_chess=>gtt_moves.
    lt_expected_moves = corresponding #( lt_expected ).
    lv_mate = lo_object->get_next_moves( importing et_moves = lt_moves ).
    cl_aunit_assert=>assert_equals( act = lv_mate exp = abap_false quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = lt_moves exp = lt_expected_moves quit = if_aunit_constants=>no ).

    lo_object->delete( ).
  endmethod.

  method test_stage5_pawn_014. " test diagonal movement of pawn
    data lo_object type ref to cl_demo_sql_chess.
    types begin of lty_expected.
    types color type demo_chess_color.
    types chessman type demo_chess_chessman.
    types from_x type demo_chess_xpos.
    types from_y type demo_chess_xpos.
    types to_x type demo_chess_xpos.
    types to_y type demo_chess_xpos.
    types end of lty_expected.
    data lt_expected type sorted table of lty_expected with unique key from_x from_y to_x to_y.
    data lt_actual type sorted table of lty_expected with unique key from_x from_y to_x to_y.
    data lt_positions type cl_demo_sql_chess=>gtt_positions.
    lt_positions = value #(
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_pawn    x = 4 y = 6 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_pawn    x = 5 y = 7 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king    x = 5 y = 8 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king    x = 5 y = 1 )
    ).
    lt_expected = value #(
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_pawn   from_x = 4 from_y = 6 to_x = 4 to_y = 5 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_pawn   from_x = 5 from_y = 7 to_x = 5 to_y = 6 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_pawn   from_x = 5 from_y = 7 to_x = 5 to_y = 5 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king   from_x = 5 from_y = 8 to_x = 4 to_y = 7 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king   from_x = 5 from_y = 8 to_x = 4 to_y = 8 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king   from_x = 5 from_y = 8 to_x = 6 to_y = 7 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king   from_x = 5 from_y = 8 to_x = 6 to_y = 8 )
    ).
    lo_object = cl_demo_sql_chess=>factory_from_position( is_settings  = value #( color = cl_demo_sql_chess=>c_color_black )
                                                          it_positions = lt_positions ).
    select * from demo_chess_v_stage5
      where gameuuid = @lo_object->gv_gameuuid
      order by from_x, from_y, to_x, to_y
      into corresponding fields of table @lt_actual.
    cl_aunit_assert=>assert_subrc( act = sy-subrc quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = sy-dbcnt exp = 7 quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = lt_actual exp = lt_expected quit = if_aunit_constants=>no ).

    " check the result of get_next_moves
    data lv_mate type abap_bool.
    data lt_moves type cl_demo_sql_chess=>gtt_moves.
    data lt_expected_moves type cl_demo_sql_chess=>gtt_moves.
    lt_expected_moves = corresponding #( lt_expected ).
    lv_mate = lo_object->get_next_moves( importing et_moves = lt_moves ).
    cl_aunit_assert=>assert_equals( act = lv_mate exp = abap_false quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = lt_moves exp = lt_expected_moves quit = if_aunit_constants=>no ).

    lo_object->delete( ).
  endmethod.

  method test_stage5_queen_001. " test queen
    data lo_object type ref to cl_demo_sql_chess.
    types begin of lty_expected.
    types color type demo_chess_color.
    types chessman type demo_chess_chessman.
    types from_x type demo_chess_xpos.
    types from_y type demo_chess_xpos.
    types to_x type demo_chess_xpos.
    types to_y type demo_chess_xpos.
    types end of lty_expected.
    data lt_expected type sorted table of lty_expected with unique key from_x from_y to_x to_y.
    data lt_actual type sorted table of lty_expected with unique key from_x from_y to_x to_y.
    data lt_positions type cl_demo_sql_chess=>gtt_positions.
    lt_positions = value #(
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king   x = 5 y = 1 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king   x = 5 y = 8 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_queen  x = 5 y = 4 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_queen  x = 7 y = 4 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_pawn   x = 3 y = 6 )
    ).
    lt_expected = value #(
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_pawn   from_x = 3 from_y = 6 to_x = 3 to_y = 7 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king   from_x = 5 from_y = 1 to_x = 4 to_y = 1 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king   from_x = 5 from_y = 1 to_x = 4 to_y = 2 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king   from_x = 5 from_y = 1 to_x = 5 to_y = 2 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king   from_x = 5 from_y = 1 to_x = 6 to_y = 1 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king   from_x = 5 from_y = 1 to_x = 6 to_y = 2 )

      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_queen  from_x = 5 from_y = 4 to_x = 1 to_y = 4 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_queen  from_x = 5 from_y = 4 to_x = 2 to_y = 1 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_queen  from_x = 5 from_y = 4 to_x = 2 to_y = 4 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_queen  from_x = 5 from_y = 4 to_x = 3 to_y = 2 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_queen  from_x = 5 from_y = 4 to_x = 3 to_y = 4 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_queen  from_x = 5 from_y = 4 to_x = 4 to_y = 3 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_queen  from_x = 5 from_y = 4 to_x = 4 to_y = 4 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_queen  from_x = 5 from_y = 4 to_x = 4 to_y = 5 )

      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_queen  from_x = 5 from_y = 4 to_x = 5 to_y = 2 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_queen  from_x = 5 from_y = 4 to_x = 5 to_y = 3 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_queen  from_x = 5 from_y = 4 to_x = 5 to_y = 5 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_queen  from_x = 5 from_y = 4 to_x = 5 to_y = 6 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_queen  from_x = 5 from_y = 4 to_x = 5 to_y = 7 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_queen  from_x = 5 from_y = 4 to_x = 5 to_y = 8 )

      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_queen  from_x = 5 from_y = 4 to_x = 6 to_y = 3 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_queen  from_x = 5 from_y = 4 to_x = 6 to_y = 4 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_queen  from_x = 5 from_y = 4 to_x = 6 to_y = 5 )

      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_queen  from_x = 5 from_y = 4 to_x = 7 to_y = 2 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_queen  from_x = 5 from_y = 4 to_x = 7 to_y = 4 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_queen  from_x = 5 from_y = 4 to_x = 7 to_y = 6 )

      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_queen  from_x = 5 from_y = 4 to_x = 8 to_y = 1 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_queen  from_x = 5 from_y = 4 to_x = 8 to_y = 7 )

    ).
    lo_object = cl_demo_sql_chess=>factory_from_position( is_settings  = value #( color = cl_demo_sql_chess=>c_color_white )
                                                          it_positions = lt_positions ).
    select * from demo_chess_v_stage5
      where gameuuid = @lo_object->gv_gameuuid
      order by from_x, from_y, to_x, to_y
      into corresponding fields of table @lt_actual.
    cl_aunit_assert=>assert_subrc( act = sy-subrc quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = sy-dbcnt exp = 28 quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = lt_actual exp = lt_expected quit = if_aunit_constants=>no ).

    " check the result of get_next_moves
    data lv_mate type abap_bool.
    data lt_moves type cl_demo_sql_chess=>gtt_moves.
    data lt_expected_moves type cl_demo_sql_chess=>gtt_moves.
    lt_expected_moves = value #(
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_pawn   from_x = 3 from_y = 6 to_x = 3 to_y = 7 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king   from_x = 5 from_y = 1 to_x = 4 to_y = 2 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king   from_x = 5 from_y = 1 to_x = 6 to_y = 1 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king   from_x = 5 from_y = 1 to_x = 6 to_y = 2 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_queen  from_x = 5 from_y = 4 to_x = 1 to_y = 4 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_queen  from_x = 5 from_y = 4 to_x = 2 to_y = 1 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_queen  from_x = 5 from_y = 4 to_x = 2 to_y = 4 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_queen  from_x = 5 from_y = 4 to_x = 3 to_y = 2 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_queen  from_x = 5 from_y = 4 to_x = 3 to_y = 4 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_queen  from_x = 5 from_y = 4 to_x = 4 to_y = 3 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_queen  from_x = 5 from_y = 4 to_x = 4 to_y = 4 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_queen  from_x = 5 from_y = 4 to_x = 4 to_y = 5 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_queen  from_x = 5 from_y = 4 to_x = 5 to_y = 2 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_queen  from_x = 5 from_y = 4 to_x = 5 to_y = 3 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_queen  from_x = 5 from_y = 4 to_x = 5 to_y = 5 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_queen  from_x = 5 from_y = 4 to_x = 5 to_y = 6 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_queen  from_x = 5 from_y = 4 to_x = 5 to_y = 7 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_queen  from_x = 5 from_y = 4 to_x = 5 to_y = 8 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_queen  from_x = 5 from_y = 4 to_x = 6 to_y = 3 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_queen  from_x = 5 from_y = 4 to_x = 6 to_y = 4 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_queen  from_x = 5 from_y = 4 to_x = 6 to_y = 5 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_queen  from_x = 5 from_y = 4 to_x = 7 to_y = 2 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_queen  from_x = 5 from_y = 4 to_x = 7 to_y = 4 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_queen  from_x = 5 from_y = 4 to_x = 7 to_y = 6 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_queen  from_x = 5 from_y = 4 to_x = 8 to_y = 1 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_queen  from_x = 5 from_y = 4 to_x = 8 to_y = 7 )

    ).
    lv_mate = lo_object->get_next_moves( importing et_moves = lt_moves ).
    cl_aunit_assert=>assert_equals( act = lv_mate exp = abap_false quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = lt_moves exp = lt_expected_moves quit = if_aunit_constants=>no ).

    lo_object->delete( ).
  endmethod.

  method test_stage5_queen_002. " test queen
    data lo_object type ref to cl_demo_sql_chess.
    types begin of lty_expected.
    types color type demo_chess_color.
    types chessman type demo_chess_chessman.
    types from_x type demo_chess_xpos.
    types from_y type demo_chess_xpos.
    types to_x type demo_chess_xpos.
    types to_y type demo_chess_xpos.
    types end of lty_expected.
    data lt_expected type sorted table of lty_expected with unique key from_x from_y to_x to_y.
    data lt_actual type sorted table of lty_expected with unique key from_x from_y to_x to_y.
    data lt_positions type cl_demo_sql_chess=>gtt_positions.
    lt_positions = value #(
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king   x = 5 y = 1 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king   x = 5 y = 8 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_queen  x = 5 y = 4 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_pawn   x = 7 y = 4 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_pawn   x = 3 y = 6 )
    ).
    lt_expected = value #(
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_queen  from_x = 5 from_y = 4 to_x = 1 to_y = 4 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_queen  from_x = 5 from_y = 4 to_x = 2 to_y = 1 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_queen  from_x = 5 from_y = 4 to_x = 2 to_y = 4 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_queen  from_x = 5 from_y = 4 to_x = 3 to_y = 2 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_queen  from_x = 5 from_y = 4 to_x = 3 to_y = 4 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_queen  from_x = 5 from_y = 4 to_x = 3 to_y = 6 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_queen  from_x = 5 from_y = 4 to_x = 4 to_y = 3 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_queen  from_x = 5 from_y = 4 to_x = 4 to_y = 4 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_queen  from_x = 5 from_y = 4 to_x = 4 to_y = 5 )

      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_queen  from_x = 5 from_y = 4 to_x = 5 to_y = 1 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_queen  from_x = 5 from_y = 4 to_x = 5 to_y = 2 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_queen  from_x = 5 from_y = 4 to_x = 5 to_y = 3 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_queen  from_x = 5 from_y = 4 to_x = 5 to_y = 5 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_queen  from_x = 5 from_y = 4 to_x = 5 to_y = 6 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_queen  from_x = 5 from_y = 4 to_x = 5 to_y = 7 )

      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_queen  from_x = 5 from_y = 4 to_x = 6 to_y = 3 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_queen  from_x = 5 from_y = 4 to_x = 6 to_y = 4 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_queen  from_x = 5 from_y = 4 to_x = 6 to_y = 5 )

      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_queen  from_x = 5 from_y = 4 to_x = 7 to_y = 2 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_queen  from_x = 5 from_y = 4 to_x = 7 to_y = 6 )

      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_queen  from_x = 5 from_y = 4 to_x = 8 to_y = 1 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_queen  from_x = 5 from_y = 4 to_x = 8 to_y = 7 )

      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king   from_x = 5 from_y = 8 to_x = 4 to_y = 7 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king   from_x = 5 from_y = 8 to_x = 4 to_y = 8 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king   from_x = 5 from_y = 8 to_x = 5 to_y = 7 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king   from_x = 5 from_y = 8 to_x = 6 to_y = 7 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king   from_x = 5 from_y = 8 to_x = 6 to_y = 8 )

      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_pawn   from_x = 7 from_y = 4 to_x = 7 to_y = 3 )

    ).
    lo_object = cl_demo_sql_chess=>factory_from_position( is_settings  = value #( color = cl_demo_sql_chess=>c_color_black )
                                                          it_positions = lt_positions ).
    select * from demo_chess_v_stage5
      where gameuuid = @lo_object->gv_gameuuid
      order by from_x, from_y, to_x, to_y
      into corresponding fields of table @lt_actual.
    cl_aunit_assert=>assert_subrc( act = sy-subrc quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = sy-dbcnt exp = 28 quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = lt_actual exp = lt_expected quit = if_aunit_constants=>no ).

    " check the result of get_next_moves
    data lv_mate type abap_bool.
    data lt_moves type cl_demo_sql_chess=>gtt_moves.
    data lt_expected_moves type cl_demo_sql_chess=>gtt_moves.
    lt_expected_moves = value #( " totally unrealisitc scenario
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_queen  from_x = 5 from_y = 4 to_x = 1 to_y = 4 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_queen  from_x = 5 from_y = 4 to_x = 2 to_y = 1 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_queen  from_x = 5 from_y = 4 to_x = 2 to_y = 4 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_queen  from_x = 5 from_y = 4 to_x = 3 to_y = 2 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_queen  from_x = 5 from_y = 4 to_x = 3 to_y = 4 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_queen  from_x = 5 from_y = 4 to_x = 3 to_y = 6 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_queen  from_x = 5 from_y = 4 to_x = 4 to_y = 3 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_queen  from_x = 5 from_y = 4 to_x = 4 to_y = 4 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_queen  from_x = 5 from_y = 4 to_x = 4 to_y = 5 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_queen  from_x = 5 from_y = 4 to_x = 5 to_y = 1 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_queen  from_x = 5 from_y = 4 to_x = 5 to_y = 2 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_queen  from_x = 5 from_y = 4 to_x = 5 to_y = 3 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_queen  from_x = 5 from_y = 4 to_x = 5 to_y = 5 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_queen  from_x = 5 from_y = 4 to_x = 5 to_y = 6 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_queen  from_x = 5 from_y = 4 to_x = 5 to_y = 7 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_queen  from_x = 5 from_y = 4 to_x = 6 to_y = 3 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_queen  from_x = 5 from_y = 4 to_x = 6 to_y = 4 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_queen  from_x = 5 from_y = 4 to_x = 6 to_y = 5 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_queen  from_x = 5 from_y = 4 to_x = 7 to_y = 2 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_queen  from_x = 5 from_y = 4 to_x = 7 to_y = 6 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_queen  from_x = 5 from_y = 4 to_x = 8 to_y = 1 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_queen  from_x = 5 from_y = 4 to_x = 8 to_y = 7 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king   from_x = 5 from_y = 8 to_x = 4 to_y = 8 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king   from_x = 5 from_y = 8 to_x = 5 to_y = 7 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king   from_x = 5 from_y = 8 to_x = 6 to_y = 7 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king   from_x = 5 from_y = 8 to_x = 6 to_y = 8 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_pawn   from_x = 7 from_y = 4 to_x = 7 to_y = 3 )
    ).
    lv_mate = lo_object->get_next_moves( importing et_moves = lt_moves ).
    cl_aunit_assert=>assert_equals( act = lv_mate exp = abap_false quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = lt_moves exp = lt_expected_moves quit = if_aunit_constants=>no ).

    lo_object->delete( ).
  endmethod.

  method test_stage5_bishop_001. " test bishop white
    data lo_object type ref to cl_demo_sql_chess.
    types begin of lty_expected.
    types color type demo_chess_color.
    types chessman type demo_chess_chessman.
    types from_x type demo_chess_xpos.
    types from_y type demo_chess_xpos.
    types to_x type demo_chess_xpos.
    types to_y type demo_chess_xpos.
    types end of lty_expected.
    data lt_expected type sorted table of lty_expected with unique key from_x from_y to_x to_y.
    data lt_actual type sorted table of lty_expected with unique key from_x from_y to_x to_y.
    data lt_positions type cl_demo_sql_chess=>gtt_positions.
    lt_positions = value #(
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king   x = 5 y = 1 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king   x = 5 y = 8 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_bishop x = 5 y = 4 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_pawn   x = 7 y = 2 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_pawn   x = 3 y = 6 )
    ).
    lt_expected = value #(
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_pawn   from_x = 3 from_y = 6 to_x = 3 to_y = 7 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king   from_x = 5 from_y = 1 to_x = 4 to_y = 1 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king   from_x = 5 from_y = 1 to_x = 4 to_y = 2 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king   from_x = 5 from_y = 1 to_x = 5 to_y = 2 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king   from_x = 5 from_y = 1 to_x = 6 to_y = 1 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king   from_x = 5 from_y = 1 to_x = 6 to_y = 2 )

      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_bishop  from_x = 5 from_y = 4 to_x = 2 to_y = 1 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_bishop  from_x = 5 from_y = 4 to_x = 3 to_y = 2 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_bishop  from_x = 5 from_y = 4 to_x = 4 to_y = 3 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_bishop  from_x = 5 from_y = 4 to_x = 4 to_y = 5 )

      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_bishop  from_x = 5 from_y = 4 to_x = 6 to_y = 3 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_bishop  from_x = 5 from_y = 4 to_x = 6 to_y = 5 )

      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_bishop  from_x = 5 from_y = 4 to_x = 7 to_y = 2 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_bishop  from_x = 5 from_y = 4 to_x = 7 to_y = 6 )

      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_bishop  from_x = 5 from_y = 4 to_x = 8 to_y = 7 )

    ).
    lo_object = cl_demo_sql_chess=>factory_from_position( is_settings  = value #( color = cl_demo_sql_chess=>c_color_white )
                                                          it_positions = lt_positions ).
    select * from demo_chess_v_stage5
      where gameuuid = @lo_object->gv_gameuuid
      order by from_x, from_y, to_x, to_y
      into corresponding fields of table @lt_actual.
    cl_aunit_assert=>assert_subrc( act = sy-subrc quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = sy-dbcnt exp = 15 quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = lt_actual exp = lt_expected quit = if_aunit_constants=>no ).

    " check the result of get_next_moves
    data lv_mate type abap_bool.
    data lt_moves type cl_demo_sql_chess=>gtt_moves.
    data lt_expected_moves type cl_demo_sql_chess=>gtt_moves.
    lt_expected_moves = corresponding #( lt_expected ).
    delete lt_expected_moves where from_x = 5 and from_y = 1 and to_x = 6 and to_y = 1. " this move is not allowed => king is in check!
    lv_mate = lo_object->get_next_moves( importing et_moves = lt_moves ).
    cl_aunit_assert=>assert_equals( act = lv_mate exp = abap_false quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = lt_moves exp = lt_expected_moves quit = if_aunit_constants=>no ).

    lo_object->delete( ).
  endmethod.

  method test_stage5_bishop_002. " test bishop black
    data lo_object type ref to cl_demo_sql_chess.
    types begin of lty_expected.
    types color type demo_chess_color.
    types chessman type demo_chess_chessman.
    types from_x type demo_chess_xpos.
    types from_y type demo_chess_xpos.
    types to_x type demo_chess_xpos.
    types to_y type demo_chess_xpos.
    types end of lty_expected.
    data lt_expected type sorted table of lty_expected with unique key from_x from_y to_x to_y.
    data lt_actual type sorted table of lty_expected with unique key from_x from_y to_x to_y.
    data lt_positions type cl_demo_sql_chess=>gtt_positions.
    lt_positions = value #(
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king   x = 5 y = 1 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king   x = 5 y = 8 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_bishop x = 5 y = 5 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_pawn   x = 7 y = 3 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_pawn   x = 3 y = 7 )
    ).
    lt_expected = value #(
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_bishop  from_x = 5 from_y = 5 to_x = 1 to_y = 1 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_bishop  from_x = 5 from_y = 5 to_x = 2 to_y = 2 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_bishop  from_x = 5 from_y = 5 to_x = 3 to_y = 3 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_bishop  from_x = 5 from_y = 5 to_x = 3 to_y = 7 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_bishop  from_x = 5 from_y = 5 to_x = 4 to_y = 4 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_bishop  from_x = 5 from_y = 5 to_x = 4 to_y = 6 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_bishop  from_x = 5 from_y = 5 to_x = 6 to_y = 4 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_bishop  from_x = 5 from_y = 5 to_x = 6 to_y = 6 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_bishop  from_x = 5 from_y = 5 to_x = 7 to_y = 7 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_bishop  from_x = 5 from_y = 5 to_x = 8 to_y = 8 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king   from_x = 5 from_y = 8 to_x = 4 to_y = 7 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king   from_x = 5 from_y = 8 to_x = 4 to_y = 8 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king   from_x = 5 from_y = 8 to_x = 5 to_y = 7 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king   from_x = 5 from_y = 8 to_x = 6 to_y = 7 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king   from_x = 5 from_y = 8 to_x = 6 to_y = 8 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_pawn   from_x = 7 from_y = 3 to_x = 7 to_y = 2 )
    ).
    lo_object = cl_demo_sql_chess=>factory_from_position( is_settings  = value #( color = cl_demo_sql_chess=>c_color_black )
                                                          it_positions = lt_positions ).
    select * from demo_chess_v_stage5
      where gameuuid = @lo_object->gv_gameuuid
      order by from_x, from_y, to_x, to_y
      into corresponding fields of table @lt_actual.
    cl_aunit_assert=>assert_subrc( act = sy-subrc quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = sy-dbcnt exp = 16 quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = lt_actual exp = lt_expected quit = if_aunit_constants=>no ).

    " check the result of get_next_moves
    data lv_mate type abap_bool.
    data lt_moves type cl_demo_sql_chess=>gtt_moves.
    data lt_expected_moves type cl_demo_sql_chess=>gtt_moves.
    lt_expected_moves = corresponding #( lt_expected ).
    delete lt_expected_moves where from_x = 5 and from_y = 8 and to_x = 4 and to_y = 8. " this move is not allowed => king is in check!
    lv_mate = lo_object->get_next_moves( importing et_moves = lt_moves ).
    cl_aunit_assert=>assert_equals( act = lv_mate exp = abap_false quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = lt_moves exp = lt_expected_moves quit = if_aunit_constants=>no ).

    lo_object->delete( ).
  endmethod.

  method test_stage5_rook_001. " test rook white
    data lo_object type ref to cl_demo_sql_chess.
    types begin of lty_expected.
    types color type demo_chess_color.
    types chessman type demo_chess_chessman.
    types from_x type demo_chess_xpos.
    types from_y type demo_chess_xpos.
    types to_x type demo_chess_xpos.
    types to_y type demo_chess_xpos.
    types end of lty_expected.
    data lt_expected type sorted table of lty_expected with unique key from_x from_y to_x to_y.
    data lt_actual type sorted table of lty_expected with unique key from_x from_y to_x to_y.
    data lt_positions type cl_demo_sql_chess=>gtt_positions.
    lt_positions = value #(
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king   x = 5 y = 1 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king   x = 5 y = 8 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_rook   x = 5 y = 4 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_pawn   x = 3 y = 4 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_pawn   x = 7 y = 4 )
    ).
    lt_expected = value #(
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king   from_x = 5 from_y = 1 to_x = 4 to_y = 1 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king   from_x = 5 from_y = 1 to_x = 4 to_y = 2 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king   from_x = 5 from_y = 1 to_x = 5 to_y = 2 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king   from_x = 5 from_y = 1 to_x = 6 to_y = 1 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king   from_x = 5 from_y = 1 to_x = 6 to_y = 2 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_rook   from_x = 5 from_y = 4 to_x = 3 to_y = 4 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_rook   from_x = 5 from_y = 4 to_x = 4 to_y = 4 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_rook   from_x = 5 from_y = 4 to_x = 5 to_y = 2 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_rook   from_x = 5 from_y = 4 to_x = 5 to_y = 3 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_rook   from_x = 5 from_y = 4 to_x = 5 to_y = 5 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_rook   from_x = 5 from_y = 4 to_x = 5 to_y = 6 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_rook   from_x = 5 from_y = 4 to_x = 5 to_y = 7 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_rook   from_x = 5 from_y = 4 to_x = 5 to_y = 8 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_rook   from_x = 5 from_y = 4 to_x = 6 to_y = 4 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_pawn   from_x = 7 from_y = 4 to_x = 7 to_y = 5 )
    ).
    lo_object = cl_demo_sql_chess=>factory_from_position( is_settings  = value #( color = cl_demo_sql_chess=>c_color_white )
                                                          it_positions = lt_positions ).
    select * from demo_chess_v_stage5
      where gameuuid = @lo_object->gv_gameuuid
      order by from_x, from_y, to_x, to_y
      into corresponding fields of table @lt_actual.
    cl_aunit_assert=>assert_subrc( act = sy-subrc quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = sy-dbcnt exp = 15 quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = lt_actual exp = lt_expected quit = if_aunit_constants=>no ).

    " check the result of get_next_moves
    data lv_mate type abap_bool.
    data lt_moves type cl_demo_sql_chess=>gtt_moves.
    data lt_expected_moves type cl_demo_sql_chess=>gtt_moves.
    lt_expected_moves = corresponding #( lt_expected ).
    lv_mate = lo_object->get_next_moves( importing et_moves = lt_moves ).
    cl_aunit_assert=>assert_equals( act = lv_mate exp = abap_false quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = lt_moves exp = lt_expected_moves quit = if_aunit_constants=>no ).

    lo_object->delete( ).
  endmethod.

  method test_stage5_rook_002. " test rook black
    data lo_object type ref to cl_demo_sql_chess.
    types begin of lty_expected.
    types color type demo_chess_color.
    types chessman type demo_chess_chessman.
    types from_x type demo_chess_xpos.
    types from_y type demo_chess_xpos.
    types to_x type demo_chess_xpos.
    types to_y type demo_chess_xpos.
    types end of lty_expected.
    data lt_expected type sorted table of lty_expected with unique key from_x from_y to_x to_y.
    data lt_actual type sorted table of lty_expected with unique key from_x from_y to_x to_y.
    data lt_positions type cl_demo_sql_chess=>gtt_positions.
    lt_positions = value #(
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king   x = 5 y = 1 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king   x = 5 y = 8 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_rook   x = 5 y = 4 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_pawn   x = 3 y = 4 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_pawn   x = 7 y = 4 )
    ).
    lt_expected = value #(
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_pawn   from_x = 3 from_y = 4 to_x = 3 to_y = 3 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_rook   from_x = 5 from_y = 4 to_x = 4 to_y = 4 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_rook   from_x = 5 from_y = 4 to_x = 5 to_y = 1 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_rook   from_x = 5 from_y = 4 to_x = 5 to_y = 2 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_rook   from_x = 5 from_y = 4 to_x = 5 to_y = 3 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_rook   from_x = 5 from_y = 4 to_x = 5 to_y = 5 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_rook   from_x = 5 from_y = 4 to_x = 5 to_y = 6 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_rook   from_x = 5 from_y = 4 to_x = 5 to_y = 7 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_rook   from_x = 5 from_y = 4 to_x = 6 to_y = 4 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_rook   from_x = 5 from_y = 4 to_x = 7 to_y = 4 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king   from_x = 5 from_y = 8 to_x = 4 to_y = 7 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king   from_x = 5 from_y = 8 to_x = 4 to_y = 8 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king   from_x = 5 from_y = 8 to_x = 5 to_y = 7 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king   from_x = 5 from_y = 8 to_x = 6 to_y = 7 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king   from_x = 5 from_y = 8 to_x = 6 to_y = 8 )
    ).
    lo_object = cl_demo_sql_chess=>factory_from_position( is_settings  = value #( color = cl_demo_sql_chess=>c_color_black )
                                                          it_positions = lt_positions ).
    select * from demo_chess_v_stage5
      where gameuuid = @lo_object->gv_gameuuid
      order by from_x, from_y, to_x, to_y
      into corresponding fields of table @lt_actual.
    cl_aunit_assert=>assert_subrc( act = sy-subrc quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = sy-dbcnt exp = 15 quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = lt_actual exp = lt_expected quit = if_aunit_constants=>no ).

    " check the result of get_next_moves
    data lv_mate type abap_bool.
    data lt_moves type cl_demo_sql_chess=>gtt_moves.
    data lt_expected_moves type cl_demo_sql_chess=>gtt_moves.
    lt_expected_moves = corresponding #( lt_expected ).
    lv_mate = lo_object->get_next_moves( importing et_moves = lt_moves ).
    cl_aunit_assert=>assert_equals( act = lv_mate exp = abap_false quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = lt_moves exp = lt_expected_moves quit = if_aunit_constants=>no ).

    lo_object->delete( ).
  endmethod.

  method test_stage5_knight_001. " test knight white
    data lo_object type ref to cl_demo_sql_chess.
    types begin of lty_expected.
    types color type demo_chess_color.
    types chessman type demo_chess_chessman.
    types from_x type demo_chess_xpos.
    types from_y type demo_chess_xpos.
    types to_x type demo_chess_xpos.
    types to_y type demo_chess_xpos.
    types end of lty_expected.
    data lt_expected type sorted table of lty_expected with unique key from_x from_y to_x to_y.
    data lt_actual type sorted table of lty_expected with unique key from_x from_y to_x to_y.
    data lt_positions type cl_demo_sql_chess=>gtt_positions.
    lt_positions = value #( " unrealisitc scenario ;-)
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king   x = 5 y = 1 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king   x = 5 y = 8 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_knight x = 5 y = 4 )

      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_pawn   x = 4 y = 3 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_pawn   x = 4 y = 4 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_pawn   x = 4 y = 5 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_pawn   x = 5 y = 3 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_pawn   x = 5 y = 5 )

      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_pawn   x = 6 y = 3 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_pawn   x = 6 y = 4 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_pawn   x = 6 y = 5 )

      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_pawn   x = 4 y = 6 )
    ).
    lt_expected = value #(
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_pawn   from_x = 4 from_y = 6 to_x = 4 to_y = 7 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king   from_x = 5 from_y = 1 to_x = 4 to_y = 1 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king   from_x = 5 from_y = 1 to_x = 4 to_y = 2 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king   from_x = 5 from_y = 1 to_x = 5 to_y = 2 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king   from_x = 5 from_y = 1 to_x = 6 to_y = 1 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king   from_x = 5 from_y = 1 to_x = 6 to_y = 2 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_knight from_x = 5 from_y = 4 to_x = 3 to_y = 3 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_knight from_x = 5 from_y = 4 to_x = 3 to_y = 5 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_knight from_x = 5 from_y = 4 to_x = 4 to_y = 2 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_knight from_x = 5 from_y = 4 to_x = 6 to_y = 2 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_knight from_x = 5 from_y = 4 to_x = 6 to_y = 6 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_knight from_x = 5 from_y = 4 to_x = 7 to_y = 3 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_knight from_x = 5 from_y = 4 to_x = 7 to_y = 5 )
    ).
    lo_object = cl_demo_sql_chess=>factory_from_position( is_settings  = value #( color = cl_demo_sql_chess=>c_color_white )
                                                          it_positions = lt_positions ).
    select * from demo_chess_v_stage5
      where gameuuid = @lo_object->gv_gameuuid
      order by from_x, from_y, to_x, to_y
      into corresponding fields of table @lt_actual.
    cl_aunit_assert=>assert_subrc( act = sy-subrc quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = sy-dbcnt exp = 13 quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = lt_actual exp = lt_expected quit = if_aunit_constants=>no ).

    " check the result of get_next_moves
    data lv_mate type abap_bool.
    data lt_moves type cl_demo_sql_chess=>gtt_moves.
    data lt_expected_moves type cl_demo_sql_chess=>gtt_moves.
    lt_expected_moves = corresponding #( lt_expected ).
    lt_expected_moves = value #(
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_pawn   from_x = 4 from_y = 6 to_x = 4 to_y = 7 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king   from_x = 5 from_y = 1 to_x = 4 to_y = 1 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king   from_x = 5 from_y = 1 to_x = 6 to_y = 1 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_knight from_x = 5 from_y = 4 to_x = 3 to_y = 3 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_knight from_x = 5 from_y = 4 to_x = 3 to_y = 5 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_knight from_x = 5 from_y = 4 to_x = 4 to_y = 2 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_knight from_x = 5 from_y = 4 to_x = 6 to_y = 2 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_knight from_x = 5 from_y = 4 to_x = 6 to_y = 6 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_knight from_x = 5 from_y = 4 to_x = 7 to_y = 3 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_knight from_x = 5 from_y = 4 to_x = 7 to_y = 5 )
    ).
    lv_mate = lo_object->get_next_moves( importing et_moves = lt_moves ).
    cl_aunit_assert=>assert_equals( act = lv_mate exp = abap_false quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = lt_moves exp = lt_expected_moves quit = if_aunit_constants=>no ).

    lo_object->delete( ).
  endmethod.

  method test_stage5_knight_002. " test knight black
    data lo_object type ref to cl_demo_sql_chess.
    types begin of lty_expected.
    types color type demo_chess_color.
    types chessman type demo_chess_chessman.
    types from_x type demo_chess_xpos.
    types from_y type demo_chess_xpos.
    types to_x type demo_chess_xpos.
    types to_y type demo_chess_xpos.
    types end of lty_expected.
    data lt_expected type sorted table of lty_expected with unique key from_x from_y to_x to_y.
    data lt_actual type sorted table of lty_expected with unique key from_x from_y to_x to_y.
    data lt_positions type cl_demo_sql_chess=>gtt_positions.
    lt_positions = value #( " unrealisitc scenario ;-)
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king   x = 5 y = 1 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king   x = 5 y = 8 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_knight x = 5 y = 4 )

      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_pawn   x = 4 y = 3 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_pawn   x = 4 y = 4 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_pawn   x = 4 y = 5 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_pawn   x = 5 y = 3 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_pawn   x = 5 y = 5 )

      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_pawn   x = 6 y = 3 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_pawn   x = 6 y = 4 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_pawn   x = 6 y = 5 )

      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_pawn   x = 4 y = 6 )
    ).
    lt_expected = value #(
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_pawn   from_x = 4 from_y = 6 to_x = 5 to_y = 5 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_knight from_x = 5 from_y = 4 to_x = 3 to_y = 3 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_knight from_x = 5 from_y = 4 to_x = 3 to_y = 5 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_knight from_x = 5 from_y = 4 to_x = 4 to_y = 2 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_knight from_x = 5 from_y = 4 to_x = 6 to_y = 2 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_knight from_x = 5 from_y = 4 to_x = 6 to_y = 6 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_knight from_x = 5 from_y = 4 to_x = 7 to_y = 3 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_knight from_x = 5 from_y = 4 to_x = 7 to_y = 5 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king   from_x = 5 from_y = 8 to_x = 4 to_y = 7 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king   from_x = 5 from_y = 8 to_x = 4 to_y = 8 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king   from_x = 5 from_y = 8 to_x = 5 to_y = 7 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king   from_x = 5 from_y = 8 to_x = 6 to_y = 7 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king   from_x = 5 from_y = 8 to_x = 6 to_y = 8 )
    ).
    lo_object = cl_demo_sql_chess=>factory_from_position( is_settings  = value #( color = cl_demo_sql_chess=>c_color_black )
                                                          it_positions = lt_positions ).
    select * from demo_chess_v_stage5
      where gameuuid = @lo_object->gv_gameuuid
      order by from_x, from_y, to_x, to_y
      into corresponding fields of table @lt_actual.
    cl_aunit_assert=>assert_subrc( act = sy-subrc quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = sy-dbcnt exp = 13 quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = lt_actual exp = lt_expected quit = if_aunit_constants=>no ).

    " check the result of get_next_moves
    data lv_mate type abap_bool.
    data lt_moves type cl_demo_sql_chess=>gtt_moves.
    data lt_expected_moves type cl_demo_sql_chess=>gtt_moves.
    lt_expected_moves = corresponding #( lt_expected ).
    lv_mate = lo_object->get_next_moves( importing et_moves = lt_moves ).
    cl_aunit_assert=>assert_equals( act = lv_mate exp = abap_false quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = lt_moves exp = lt_expected_moves quit = if_aunit_constants=>no ).

    lo_object->delete( ).
  endmethod.

  method test_stage5_king_001. " test king white
    data lo_object type ref to cl_demo_sql_chess.
    types begin of lty_expected.
    types color type demo_chess_color.
    types chessman type demo_chess_chessman.
    types from_x type demo_chess_xpos.
    types from_y type demo_chess_xpos.
    types to_x type demo_chess_xpos.
    types to_y type demo_chess_xpos.
    types castling_white_long type abap_bool.
    types castling_white_short type abap_bool.
    types castling_black_long type abap_bool.
    types castling_black_short type abap_bool.
    types end of lty_expected.
    data lt_expected type sorted table of lty_expected with unique key from_x from_y to_x to_y.
    data lt_actual type sorted table of lty_expected with unique key from_x from_y to_x to_y.
    data lt_positions type cl_demo_sql_chess=>gtt_positions.
    lt_positions = value #(
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_pawn   x = 4 y = 2 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king   x = 5 y = 1 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king   x = 5 y = 8 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_pawn   x = 6 y = 2 )
    ).
    lt_expected = value #(
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_pawn   from_x = 4 from_y = 2 to_x = 4 to_y = 3 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_pawn   from_x = 4 from_y = 2 to_x = 4 to_y = 4 )
( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king   from_x = 5 from_y = 1 to_x = 4 to_y = 1 castling_white_long = abap_true castling_white_short = abap_true )
( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king   from_x = 5 from_y = 1 to_x = 5 to_y = 2 castling_white_long = abap_true castling_white_short = abap_true )
( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king   from_x = 5 from_y = 1 to_x = 6 to_y = 1 castling_white_long = abap_true castling_white_short = abap_true )
( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king   from_x = 5 from_y = 1 to_x = 6 to_y = 2 castling_white_long = abap_true castling_white_short = abap_true )
).
    lo_object = cl_demo_sql_chess=>factory_from_position( is_settings  = value #( color = cl_demo_sql_chess=>c_color_white )
                                                          it_positions = lt_positions ).
    select * from demo_chess_v_stage5
      where gameuuid = @lo_object->gv_gameuuid
      order by from_x, from_y, to_x, to_y
      into corresponding fields of table @lt_actual.
    cl_aunit_assert=>assert_subrc( act = sy-subrc quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = sy-dbcnt exp = 6 quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = lt_actual exp = lt_expected quit = if_aunit_constants=>no ).

    " check the result of get_next_moves
    data lv_mate type abap_bool.
    data lt_moves type cl_demo_sql_chess=>gtt_moves.
    data lt_expected_moves type cl_demo_sql_chess=>gtt_moves.
    lt_expected_moves = corresponding #( lt_expected ).
    delete lt_expected_moves where chessman = cl_demo_sql_chess=>c_chessman_pawn. " king is in chess!
    lv_mate = lo_object->get_next_moves( importing et_moves = lt_moves ).
    cl_aunit_assert=>assert_equals( act = lv_mate exp = abap_false quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = lt_moves exp = lt_expected_moves quit = if_aunit_constants=>no ).

    lo_object->delete( ).
  endmethod.

  method test_stage5_king_002. " test king black
    data lo_object type ref to cl_demo_sql_chess.
    types begin of lty_expected.
    types color type demo_chess_color.
    types chessman type demo_chess_chessman.
    types from_x type demo_chess_xpos.
    types from_y type demo_chess_xpos.
    types to_x type demo_chess_xpos.
    types to_y type demo_chess_xpos.
    types castling_white_long type abap_bool.
    types castling_white_short type abap_bool.
    types castling_black_long type abap_bool.
    types castling_black_short type abap_bool.
    types end of lty_expected.
    data lt_expected type sorted table of lty_expected with unique key from_x from_y to_x to_y.
    data lt_actual type sorted table of lty_expected with unique key from_x from_y to_x to_y.
    data lt_positions type cl_demo_sql_chess=>gtt_positions.
    lt_positions = value #(
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_pawn   x = 4 y = 2 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king   x = 4 y = 7 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king   x = 5 y = 8 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_pawn   x = 6 y = 7 )
    ).
    lt_expected = value #(
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_pawn   from_x = 6 from_y = 7 to_x = 6 to_y = 6 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_pawn   from_x = 6 from_y = 7 to_x = 6 to_y = 5 )
( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king   from_x = 5 from_y = 8 to_x = 4 to_y = 8 castling_black_long = abap_true castling_black_short = abap_true )
( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king   from_x = 5 from_y = 8 to_x = 4 to_y = 7 castling_black_long = abap_true castling_black_short = abap_true )
( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king   from_x = 5 from_y = 8 to_x = 5 to_y = 7 castling_black_long = abap_true castling_black_short = abap_true )
( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king   from_x = 5 from_y = 8 to_x = 6 to_y = 8 castling_black_long = abap_true castling_black_short = abap_true )
).
    lo_object = cl_demo_sql_chess=>factory_from_position( is_settings  = value #( color = cl_demo_sql_chess=>c_color_black  )
                                                          it_positions = lt_positions ).
    select * from demo_chess_v_stage5
      where gameuuid = @lo_object->gv_gameuuid
      order by from_x, from_y, to_x, to_y
      into corresponding fields of table @lt_actual.
    cl_aunit_assert=>assert_subrc( act = sy-subrc quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = sy-dbcnt exp = 6 quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = lt_actual exp = lt_expected quit = if_aunit_constants=>no ).

    " check the result of get_next_moves; note that this chess position is totally stupid and crap and can never happen before!
    data lv_mate type abap_bool.
    data lt_moves type cl_demo_sql_chess=>gtt_moves.
    data lt_expected_moves type cl_demo_sql_chess=>gtt_moves.
    lt_expected_moves = value #(
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king   from_x = 5 from_y = 8 to_x = 4 to_y = 7 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king   from_x = 5 from_y = 8 to_x = 6 to_y = 8 )
    ).
    lv_mate = lo_object->get_next_moves( importing et_moves = lt_moves ).
    cl_aunit_assert=>assert_equals( act = lv_mate exp = abap_false quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = lt_moves exp = lt_expected_moves quit = if_aunit_constants=>no ).

    lo_object->delete( ).
  endmethod.
  method test_stage6_castling_001.
    data lo_object type ref to cl_demo_sql_chess.
    types begin of lty_expected.
    types color type demo_chess_color.
    types chessman type demo_chess_chessman.
    types from_x type demo_chess_xpos.
    types from_y type demo_chess_xpos.
    types to_x type demo_chess_xpos.
    types to_y type demo_chess_xpos.
    types castling_white_long type abap_bool.
    types castling_white_short type abap_bool.
    types castling_black_long type abap_bool.
    types castling_black_short type abap_bool.
    types special_flag type demo_chess_special_flag.
    types color_dep type demo_chess_color.
    types chessman_dep type demo_chess_chessman.
    types from_x_dep type demo_chess_xpos.
    types from_y_dep type demo_chess_ypos.
    types to_x_dep type demo_chess_xpos.
    types to_y_dep type demo_chess_ypos.
    types end of lty_expected.
    data lt_expected type sorted table of lty_expected with unique key from_x from_y to_x to_y.
    data lt_actual type sorted table of lty_expected with unique key from_x from_y to_x to_y.
    data lt_positions type cl_demo_sql_chess=>gtt_positions.
    lt_positions = value #(
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king   x = 5 y = 1 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king   x = 5 y = 8 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_rook   x = 1 y = 1 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_pawn   x = 1 y = 3 )
    ).
    lt_expected = value #(
( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_rook  from_x = 1 from_y = 1 to_x = 1 to_y = 2 castling_white_long = abap_true castling_white_short = abap_false )
( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_rook  from_x = 1 from_y = 1 to_x = 2 to_y = 1 castling_white_long = abap_true castling_white_short = abap_false )
( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_rook  from_x = 1 from_y = 1 to_x = 3 to_y = 1 castling_white_long = abap_true castling_white_short = abap_false )
( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_rook  from_x = 1 from_y = 1 to_x = 4 to_y = 1 castling_white_long = abap_true castling_white_short = abap_false )
( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_pawn  from_x = 1 from_y = 3 to_x = 1 to_y = 4 special_flag = 'E' )
( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 1 to_x = 3 to_y = 1
castling_white_long = abap_true castling_white_short = abap_true color_dep = cl_demo_sql_chess=>c_color_white
chessman_dep = cl_demo_sql_chess=>c_chessman_rook from_x_dep = 1 from_y_dep = 1 to_x_dep = 4 to_y_dep = 1 special_flag = 'C' )
( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 1 to_x = 4 to_y = 1
castling_white_long = abap_true castling_white_short = abap_true )
( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 1 to_x = 4 to_y = 2
castling_white_long = abap_true castling_white_short = abap_true )
( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 1 to_x = 5 to_y = 2
castling_white_long = abap_true castling_white_short = abap_true )
( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 1 to_x = 6 to_y = 1
castling_white_long = abap_true castling_white_short = abap_true )
( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 1 to_x = 6 to_y = 2
castling_white_long = abap_true castling_white_short = abap_true )
).
    lo_object = cl_demo_sql_chess=>factory_from_position( is_settings  = value #( color = cl_demo_sql_chess=>c_color_white  )
                                                          it_positions = lt_positions ).
    select * from demo_chess_v_stage6
      where gameuuid = @lo_object->gv_gameuuid
      order by from_x, from_y, to_x, to_y
      into corresponding fields of table @lt_actual.
    cl_aunit_assert=>assert_subrc( act = sy-subrc quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = sy-dbcnt exp = 11 quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = lt_actual exp = lt_expected quit = if_aunit_constants=>no ).

    " check the result of get_next_moves
    data lv_mate type abap_bool.
    data lt_moves type cl_demo_sql_chess=>gtt_moves.
    data lt_expected_moves type cl_demo_sql_chess=>gtt_moves.
    lt_expected_moves = value #(
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_rook  from_x = 1 from_y = 1 to_x = 1 to_y = 2 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_rook  from_x = 1 from_y = 1 to_x = 2 to_y = 1 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_rook  from_x = 1 from_y = 1 to_x = 3 to_y = 1 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_rook  from_x = 1 from_y = 1 to_x = 4 to_y = 1 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_pawn  from_x = 1 from_y = 3 to_x = 1 to_y = 4 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 1 to_x = 3 to_y = 1
        is_castling_white_long = abap_true )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 1 to_x = 4 to_y = 1 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 1 to_x = 4 to_y = 2 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 1 to_x = 5 to_y = 2 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 1 to_x = 6 to_y = 1  )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 1 to_x = 6 to_y = 2 )
    ).
    lv_mate = lo_object->get_next_moves( importing et_moves = lt_moves ).
    cl_aunit_assert=>assert_equals( act = lv_mate exp = abap_false quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = lt_moves exp = lt_expected_moves quit = if_aunit_constants=>no ).

    lo_object->delete( ).
  endmethod.

  method test_stage6_castling_002.
    data lo_object type ref to cl_demo_sql_chess.
    types begin of lty_expected.
    types color type demo_chess_color.
    types chessman type demo_chess_chessman.
    types from_x type demo_chess_xpos.
    types from_y type demo_chess_xpos.
    types to_x type demo_chess_xpos.
    types to_y type demo_chess_xpos.
    types castling_white_long type abap_bool.
    types castling_white_short type abap_bool.
    types castling_black_long type abap_bool.
    types castling_black_short type abap_bool.
    types special_flag type demo_chess_special_flag.
    types color_dep type demo_chess_color.
    types chessman_dep type demo_chess_chessman.
    types from_x_dep type demo_chess_xpos.
    types from_y_dep type demo_chess_ypos.
    types to_x_dep type demo_chess_xpos.
    types to_y_dep type demo_chess_ypos.
    types end of lty_expected.
    data lt_expected type sorted table of lty_expected with unique key from_x from_y to_x to_y.
    data lt_actual type sorted table of lty_expected with unique key from_x from_y to_x to_y.
    data lt_positions type cl_demo_sql_chess=>gtt_positions.
    lt_positions = value #(
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king   x = 5 y = 1 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king   x = 5 y = 8 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_rook   x = 1 y = 1 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_rook   x = 2 y = 1 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_pawn   x = 1 y = 3 )
    ).
    lt_expected = value #(
( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_rook  from_x = 1 from_y = 1 to_x = 1 to_y = 2 castling_white_long = abap_true castling_white_short = abap_false )
( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_rook  from_x = 1 from_y = 1 to_x = 2 to_y = 1 castling_white_long = abap_true castling_white_short = abap_false )
( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_pawn  from_x = 1 from_y = 3 to_x = 1 to_y = 4 special_flag = 'E' )
( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 1 to_x = 4 to_y = 1
castling_white_long = abap_true castling_white_short = abap_true )
( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 1 to_x = 4 to_y = 2
castling_white_long = abap_true castling_white_short = abap_true )
( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 1 to_x = 5 to_y = 2
castling_white_long = abap_true castling_white_short = abap_true )
( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 1 to_x = 6 to_y = 1
castling_white_long = abap_true castling_white_short = abap_true )
( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 1 to_x = 6 to_y = 2
castling_white_long = abap_true castling_white_short = abap_true )
).
    lo_object = cl_demo_sql_chess=>factory_from_position( is_settings  = value #( color = cl_demo_sql_chess=>c_color_white  )
                                                          it_positions = lt_positions ).
    select * from demo_chess_v_stage6
      where gameuuid = @lo_object->gv_gameuuid
      order by from_x, from_y, to_x, to_y
      into corresponding fields of table @lt_actual.
    cl_aunit_assert=>assert_subrc( act = sy-subrc quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = sy-dbcnt exp = 8 quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = lt_actual exp = lt_expected quit = if_aunit_constants=>no ).

    " check the result of get_next_moves
    data lv_mate type abap_bool.
    data lt_moves type cl_demo_sql_chess=>gtt_moves.
    data lt_expected_moves type cl_demo_sql_chess=>gtt_moves.
    lt_expected_moves = value #(
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_rook  from_x = 1 from_y = 1 to_x = 2 to_y = 1 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 1 to_x = 4 to_y = 2 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 1 to_x = 5 to_y = 2 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 1 to_x = 6 to_y = 2 )
    ).
    lv_mate = lo_object->get_next_moves( importing et_moves = lt_moves ).
    cl_aunit_assert=>assert_equals( act = lv_mate exp = abap_false quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = lt_moves exp = lt_expected_moves quit = if_aunit_constants=>no ).

    lo_object->delete( ).
  endmethod.

  method test_stage6_castling_003.
    data lo_object type ref to cl_demo_sql_chess.
    types begin of lty_expected.
    types color type demo_chess_color.
    types chessman type demo_chess_chessman.
    types from_x type demo_chess_xpos.
    types from_y type demo_chess_xpos.
    types to_x type demo_chess_xpos.
    types to_y type demo_chess_xpos.
    types castling_white_long type abap_bool.
    types castling_white_short type abap_bool.
    types castling_black_long type abap_bool.
    types castling_black_short type abap_bool.
    types special_flag type demo_chess_special_flag.
    types color_dep type demo_chess_color.
    types chessman_dep type demo_chess_chessman.
    types from_x_dep type demo_chess_xpos.
    types from_y_dep type demo_chess_ypos.
    types to_x_dep type demo_chess_xpos.
    types to_y_dep type demo_chess_ypos.
    types end of lty_expected.
    data lt_expected type sorted table of lty_expected with unique key from_x from_y to_x to_y.
    data lt_actual type sorted table of lty_expected with unique key from_x from_y to_x to_y.
    data lt_positions type cl_demo_sql_chess=>gtt_positions.
    lt_positions = value #(
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king   x = 5 y = 1 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king   x = 5 y = 8 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_rook   x = 1 y = 1 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_knight x = 2 y = 1 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_pawn   x = 1 y = 3 )
    ).
    lt_expected = value #(
( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_rook   from_x = 1 from_y = 1 to_x = 1 to_y = 2 castling_white_long = abap_true castling_white_short = abap_false )
( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_pawn   from_x = 1 from_y = 3 to_x = 1 to_y = 4 special_flag = 'E' )
( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_knight from_x = 2 from_y = 1 to_x = 3 to_y = 3 )
( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_knight from_x = 2 from_y = 1 to_x = 4 to_y = 2 )
( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 1 to_x = 4 to_y = 1
castling_white_long = abap_true castling_white_short = abap_true )
( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 1 to_x = 4 to_y = 2
castling_white_long = abap_true castling_white_short = abap_true )
( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 1 to_x = 5 to_y = 2
castling_white_long = abap_true castling_white_short = abap_true )
( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 1 to_x = 6 to_y = 1
castling_white_long = abap_true castling_white_short = abap_true )
( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 1 to_x = 6 to_y = 2
castling_white_long = abap_true castling_white_short = abap_true )
).
    lo_object = cl_demo_sql_chess=>factory_from_position( is_settings  = value #( color = cl_demo_sql_chess=>c_color_white  )
                                                          it_positions = lt_positions ).
    select * from demo_chess_v_stage6
      where gameuuid = @lo_object->gv_gameuuid
      order by from_x, from_y, to_x, to_y
      into corresponding fields of table @lt_actual.
    cl_aunit_assert=>assert_subrc( act = sy-subrc quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = sy-dbcnt exp = 9 quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = lt_actual exp = lt_expected quit = if_aunit_constants=>no ).

    " check the result of get_next_moves
    data lv_mate type abap_bool.
    data lt_moves type cl_demo_sql_chess=>gtt_moves.
    data lt_expected_moves type cl_demo_sql_chess=>gtt_moves.
    lt_expected_moves = corresponding #( lt_expected ).
    lv_mate = lo_object->get_next_moves( importing et_moves = lt_moves ).
    cl_aunit_assert=>assert_equals( act = lv_mate exp = abap_false quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = lt_moves exp = lt_expected_moves quit = if_aunit_constants=>no ).

    lo_object->delete( ).
  endmethod.

  method test_stage6_castling_004.
    data lo_object type ref to cl_demo_sql_chess.
    types begin of lty_expected.
    types color type demo_chess_color.
    types chessman type demo_chess_chessman.
    types from_x type demo_chess_xpos.
    types from_y type demo_chess_xpos.
    types to_x type demo_chess_xpos.
    types to_y type demo_chess_xpos.
    types castling_white_long type abap_bool.
    types castling_white_short type abap_bool.
    types castling_black_long type abap_bool.
    types castling_black_short type abap_bool.
    types special_flag type demo_chess_special_flag.
    types color_dep type demo_chess_color.
    types chessman_dep type demo_chess_chessman.
    types from_x_dep type demo_chess_xpos.
    types from_y_dep type demo_chess_ypos.
    types to_x_dep type demo_chess_xpos.
    types to_y_dep type demo_chess_ypos.
    types end of lty_expected.
    data lt_expected type sorted table of lty_expected with unique key from_x from_y to_x to_y.
    data lt_actual type sorted table of lty_expected with unique key from_x from_y to_x to_y.
    data lt_positions type cl_demo_sql_chess=>gtt_positions.
    lt_positions = value #(
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king   x = 5 y = 1 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king   x = 5 y = 8 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_rook   x = 1 y = 8 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_pawn   x = 1 y = 6 )
    ).
    lt_expected = value #(
( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_rook  from_x = 1 from_y = 8 to_x = 1 to_y = 7 castling_black_long = abap_true castling_black_short = abap_false )
( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_rook  from_x = 1 from_y = 8 to_x = 2 to_y = 8 castling_black_long = abap_true castling_black_short = abap_false )
( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_rook  from_x = 1 from_y = 8 to_x = 3 to_y = 8 castling_black_long = abap_true castling_black_short = abap_false )
( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_rook  from_x = 1 from_y = 8 to_x = 4 to_y = 8 castling_black_long = abap_true castling_black_short = abap_false )
( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_pawn  from_x = 1 from_y = 6 to_x = 1 to_y = 5 special_flag = 'E' )
( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 8 to_x = 3 to_y = 8
castling_black_long = abap_true castling_black_short = abap_true color_dep = cl_demo_sql_chess=>c_color_black
chessman_dep = cl_demo_sql_chess=>c_chessman_rook from_x_dep = 1 from_y_dep = 8 to_x_dep = 4 to_y_dep = 8 special_flag = 'C' )
( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 8 to_x = 4 to_y = 8
castling_black_long = abap_true castling_black_short = abap_true )
( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 8 to_x = 4 to_y = 7
castling_black_long = abap_true castling_black_short = abap_true )
( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 8 to_x = 5 to_y = 7
castling_black_long = abap_true castling_black_short = abap_true )
( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 8 to_x = 6 to_y = 8
castling_black_long = abap_true castling_black_short = abap_true )
( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 8 to_x = 6 to_y = 7
castling_black_long = abap_true castling_black_short = abap_true )
).
    lo_object = cl_demo_sql_chess=>factory_from_position( is_settings  = value #( color = cl_demo_sql_chess=>c_color_black  )
                                                          it_positions = lt_positions ).
    select * from demo_chess_v_stage6
      where gameuuid = @lo_object->gv_gameuuid
      order by from_x, from_y, to_x, to_y
      into corresponding fields of table @lt_actual.
    cl_aunit_assert=>assert_subrc( act = sy-subrc quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = sy-dbcnt exp = 11 quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = lt_actual exp = lt_expected quit = if_aunit_constants=>no ).

    " check the result of get_next_moves
    data lv_mate type abap_bool.
    data lt_moves type cl_demo_sql_chess=>gtt_moves.
    data lt_expected_moves type cl_demo_sql_chess=>gtt_moves.
    lt_expected_moves = value #(
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_rook  from_x = 1 from_y = 8 to_x = 1 to_y = 7  )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_rook  from_x = 1 from_y = 8 to_x = 2 to_y = 8  )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_rook  from_x = 1 from_y = 8 to_x = 3 to_y = 8  )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_rook  from_x = 1 from_y = 8 to_x = 4 to_y = 8  )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_pawn  from_x = 1 from_y = 6 to_x = 1 to_y = 5  )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 8 to_x = 3 to_y = 8
        is_castling_black_long = abap_true )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 8 to_x = 4 to_y = 8 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 8 to_x = 4 to_y = 7 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 8 to_x = 5 to_y = 7 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 8 to_x = 6 to_y = 8 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 8 to_x = 6 to_y = 7 )
    ).
    lv_mate = lo_object->get_next_moves( importing et_moves = lt_moves ).
    cl_aunit_assert=>assert_equals( act = lv_mate exp = abap_false quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = lt_moves exp = lt_expected_moves quit = if_aunit_constants=>no ).

    lo_object->delete( ).
  endmethod.

  method test_stage6_castling_005.
    data lo_object type ref to cl_demo_sql_chess.
    types begin of lty_expected.
    types color type demo_chess_color.
    types chessman type demo_chess_chessman.
    types from_x type demo_chess_xpos.
    types from_y type demo_chess_xpos.
    types to_x type demo_chess_xpos.
    types to_y type demo_chess_xpos.
    types castling_white_long type abap_bool.
    types castling_white_short type abap_bool.
    types castling_black_long type abap_bool.
    types castling_black_short type abap_bool.
    types special_flag type demo_chess_special_flag.
    types color_dep type demo_chess_color.
    types chessman_dep type demo_chess_chessman.
    types from_x_dep type demo_chess_xpos.
    types from_y_dep type demo_chess_ypos.
    types to_x_dep type demo_chess_xpos.
    types to_y_dep type demo_chess_ypos.
    types end of lty_expected.
    data lt_expected type sorted table of lty_expected with unique key from_x from_y to_x to_y.
    data lt_actual type sorted table of lty_expected with unique key from_x from_y to_x to_y.
    data lt_positions type cl_demo_sql_chess=>gtt_positions.
    lt_positions = value #(
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king   x = 5 y = 1 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king   x = 5 y = 8 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_rook   x = 1 y = 8 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_rook   x = 2 y = 8 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_pawn   x = 1 y = 6 )
    ).
    lt_expected = value #(
( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_rook  from_x = 1 from_y = 8 to_x = 1 to_y = 7 castling_black_long = abap_true castling_black_short = abap_false )
( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_rook  from_x = 1 from_y = 8 to_x = 2 to_y = 8 castling_black_long = abap_true castling_black_short = abap_false )
( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_pawn  from_x = 1 from_y = 6 to_x = 1 to_y = 5 special_flag = 'E' )
( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 8 to_x = 4 to_y = 8
castling_black_long = abap_true castling_black_short = abap_true )
( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 8 to_x = 4 to_y = 7
castling_black_long = abap_true castling_black_short = abap_true )
( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 8 to_x = 5 to_y = 7
castling_black_long = abap_true castling_black_short = abap_true )
( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 8 to_x = 6 to_y = 8
castling_black_long = abap_true castling_black_short = abap_true )
( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 8 to_x = 6 to_y = 7
castling_black_long = abap_true castling_black_short = abap_true )
).
    lo_object = cl_demo_sql_chess=>factory_from_position( is_settings  = value #( color = cl_demo_sql_chess=>c_color_black  )
                                                          it_positions = lt_positions ).
    select * from demo_chess_v_stage6
      where gameuuid = @lo_object->gv_gameuuid
      order by from_x, from_y, to_x, to_y
      into corresponding fields of table @lt_actual.
    cl_aunit_assert=>assert_subrc( act = sy-subrc quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = sy-dbcnt exp = 8 quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = lt_actual exp = lt_expected quit = if_aunit_constants=>no ).

    " check the result of get_next_moves
    data lv_mate type abap_bool.
    data lt_moves type cl_demo_sql_chess=>gtt_moves.
    data lt_expected_moves type cl_demo_sql_chess=>gtt_moves.
    lt_expected_moves = value #(
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_rook  from_x = 1 from_y = 8 to_x = 2 to_y = 8 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 8 to_x = 4 to_y = 7 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 8 to_x = 5 to_y = 7 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 8 to_x = 6 to_y = 7 )
    ).
    lv_mate = lo_object->get_next_moves( importing et_moves = lt_moves ).
    cl_aunit_assert=>assert_equals( act = lv_mate exp = abap_false quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = lt_moves exp = lt_expected_moves quit = if_aunit_constants=>no ).

    lo_object->delete( ).
  endmethod.

  method test_stage6_castling_006.
    data lo_object type ref to cl_demo_sql_chess.
    types begin of lty_expected.
    types color type demo_chess_color.
    types chessman type demo_chess_chessman.
    types from_x type demo_chess_xpos.
    types from_y type demo_chess_xpos.
    types to_x type demo_chess_xpos.
    types to_y type demo_chess_xpos.
    types castling_white_long type abap_bool.
    types castling_white_short type abap_bool.
    types castling_black_long type abap_bool.
    types castling_black_short type abap_bool.
    types special_flag type demo_chess_special_flag.
    types color_dep type demo_chess_color.
    types chessman_dep type demo_chess_chessman.
    types from_x_dep type demo_chess_xpos.
    types from_y_dep type demo_chess_ypos.
    types to_x_dep type demo_chess_xpos.
    types to_y_dep type demo_chess_ypos.
    types end of lty_expected.
    data lt_expected type sorted table of lty_expected with unique key from_x from_y to_x to_y.
    data lt_actual type sorted table of lty_expected with unique key from_x from_y to_x to_y.
    data lt_positions type cl_demo_sql_chess=>gtt_positions.
    lt_positions = value #(
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king   x = 5 y = 1 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king   x = 5 y = 8 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_rook   x = 1 y = 8 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_knight x = 2 y = 8 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_pawn   x = 1 y = 6 )
    ).
    lt_expected = value #(
( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_rook   from_x = 1 from_y = 8 to_x = 1 to_y = 7 castling_black_long = abap_true castling_black_short = abap_false )
( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_pawn   from_x = 1 from_y = 6 to_x = 1 to_y = 5 special_flag = 'E' )
( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_knight from_x = 2 from_y = 8 to_x = 3 to_y = 6 )
( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_knight from_x = 2 from_y = 8 to_x = 4 to_y = 7 )
( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 8 to_x = 4 to_y = 8
castling_black_long = abap_true castling_black_short = abap_true )
( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 8 to_x = 4 to_y = 7
castling_black_long = abap_true castling_black_short = abap_true )
( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 8 to_x = 5 to_y = 7
castling_black_long = abap_true castling_black_short = abap_true )
( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 8 to_x = 6 to_y = 8
castling_black_long = abap_true castling_black_short = abap_true )
( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 8 to_x = 6 to_y = 7
castling_black_long = abap_true castling_black_short = abap_true )
).
    lo_object = cl_demo_sql_chess=>factory_from_position( is_settings  = value #( color = cl_demo_sql_chess=>c_color_black  )
                                                          it_positions = lt_positions ).
    select * from demo_chess_v_stage6
      where gameuuid = @lo_object->gv_gameuuid
      order by from_x, from_y, to_x, to_y
      into corresponding fields of table @lt_actual.
    cl_aunit_assert=>assert_subrc( act = sy-subrc quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = sy-dbcnt exp = 9 quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = lt_actual exp = lt_expected quit = if_aunit_constants=>no ).

    " check the result of get_next_moves
    data lv_mate type abap_bool.
    data lt_moves type cl_demo_sql_chess=>gtt_moves.
    data lt_expected_moves type cl_demo_sql_chess=>gtt_moves.
    lt_expected_moves = corresponding #( lt_expected ).
    lv_mate = lo_object->get_next_moves( importing et_moves = lt_moves ).
    cl_aunit_assert=>assert_equals( act = lv_mate exp = abap_false quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = lt_moves exp = lt_expected_moves quit = if_aunit_constants=>no ).

    lo_object->delete( ).
  endmethod.
  method test_stage6_castling_007.
    data lo_object type ref to cl_demo_sql_chess.
    types begin of lty_expected.
    types color type demo_chess_color.
    types chessman type demo_chess_chessman.
    types from_x type demo_chess_xpos.
    types from_y type demo_chess_xpos.
    types to_x type demo_chess_xpos.
    types to_y type demo_chess_xpos.
    types castling_white_long type abap_bool.
    types castling_white_short type abap_bool.
    types castling_black_long type abap_bool.
    types castling_black_short type abap_bool.
    types special_flag type demo_chess_special_flag.
    types color_dep type demo_chess_color.
    types chessman_dep type demo_chess_chessman.
    types from_x_dep type demo_chess_xpos.
    types from_y_dep type demo_chess_ypos.
    types to_x_dep type demo_chess_xpos.
    types to_y_dep type demo_chess_ypos.
    types end of lty_expected.
    data lt_expected type sorted table of lty_expected with unique key from_x from_y to_x to_y.
    data lt_actual type sorted table of lty_expected with unique key from_x from_y to_x to_y.
    data lt_positions type cl_demo_sql_chess=>gtt_positions.
    lt_positions = value #(
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king   x = 5 y = 1 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king   x = 5 y = 8 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_rook   x = 8 y = 1 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_pawn   x = 8 y = 3 )
    ).
    lt_expected = value #(
( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_rook  from_x = 8 from_y = 1 to_x = 8 to_y = 2 castling_white_long = abap_false castling_white_short = abap_true )
( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_rook  from_x = 8 from_y = 1 to_x = 7 to_y = 1 castling_white_long = abap_false castling_white_short = abap_true )
( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_rook  from_x = 8 from_y = 1 to_x = 6 to_y = 1 castling_white_long = abap_false castling_white_short = abap_true )
( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_pawn  from_x = 8 from_y = 3 to_x = 8 to_y = 4 special_flag = 'E' )
( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 1 to_x = 7 to_y = 1
castling_white_long = abap_true castling_white_short = abap_true color_dep = cl_demo_sql_chess=>c_color_white
chessman_dep = cl_demo_sql_chess=>c_chessman_rook from_x_dep = 8 from_y_dep = 1 to_x_dep = 6 to_y_dep = 1 special_flag = 'C' )
( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 1 to_x = 4 to_y = 1
castling_white_long = abap_true castling_white_short = abap_true )
( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 1 to_x = 4 to_y = 2
castling_white_long = abap_true castling_white_short = abap_true )
( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 1 to_x = 5 to_y = 2
castling_white_long = abap_true castling_white_short = abap_true )
( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 1 to_x = 6 to_y = 1
castling_white_long = abap_true castling_white_short = abap_true )
( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 1 to_x = 6 to_y = 2
castling_white_long = abap_true castling_white_short = abap_true )
).
    lo_object = cl_demo_sql_chess=>factory_from_position( is_settings  = value #( color = cl_demo_sql_chess=>c_color_white  )
                                                          it_positions = lt_positions ).
    select * from demo_chess_v_stage6
      where gameuuid = @lo_object->gv_gameuuid
      order by from_x, from_y, to_x, to_y
      into corresponding fields of table @lt_actual.
    cl_aunit_assert=>assert_subrc( act = sy-subrc quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = sy-dbcnt exp = 10 quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = lt_actual exp = lt_expected quit = if_aunit_constants=>no ).

    " check the result of get_next_moves
    data lv_mate type abap_bool.
    data lt_moves type cl_demo_sql_chess=>gtt_moves.
    data lt_expected_moves type cl_demo_sql_chess=>gtt_moves.
    lt_expected_moves = value #(
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_rook  from_x = 8 from_y = 1 to_x = 8 to_y = 2 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_rook  from_x = 8 from_y = 1 to_x = 7 to_y = 1 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_rook  from_x = 8 from_y = 1 to_x = 6 to_y = 1 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_pawn  from_x = 8 from_y = 3 to_x = 8 to_y = 4 )
( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 1 to_x = 7 to_y = 1 is_castling_white_short = abap_true )
( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 1 to_x = 4 to_y = 1 )
( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 1 to_x = 4 to_y = 2 )
( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 1 to_x = 5 to_y = 2 )
( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 1 to_x = 6 to_y = 1 )
( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 1 to_x = 6 to_y = 2 )
).
    lv_mate = lo_object->get_next_moves( importing et_moves = lt_moves ).
    cl_aunit_assert=>assert_equals( act = lv_mate exp = abap_false quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = lt_moves exp = lt_expected_moves quit = if_aunit_constants=>no ).

    lo_object->delete( ).
  endmethod.

  method test_stage6_castling_008.
    data lo_object type ref to cl_demo_sql_chess.
    types begin of lty_expected.
    types color type demo_chess_color.
    types chessman type demo_chess_chessman.
    types from_x type demo_chess_xpos.
    types from_y type demo_chess_xpos.
    types to_x type demo_chess_xpos.
    types to_y type demo_chess_xpos.
    types castling_white_long type abap_bool.
    types castling_white_short type abap_bool.
    types castling_black_long type abap_bool.
    types castling_black_short type abap_bool.
    types special_flag type demo_chess_special_flag.
    types color_dep type demo_chess_color.
    types chessman_dep type demo_chess_chessman.
    types from_x_dep type demo_chess_xpos.
    types from_y_dep type demo_chess_ypos.
    types to_x_dep type demo_chess_xpos.
    types to_y_dep type demo_chess_ypos.
    types end of lty_expected.
    data lt_expected type sorted table of lty_expected with unique key from_x from_y to_x to_y.
    data lt_actual type sorted table of lty_expected with unique key from_x from_y to_x to_y.
    data lt_positions type cl_demo_sql_chess=>gtt_positions.
    lt_positions = value #(
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king   x = 5 y = 1 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king   x = 5 y = 8 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_rook   x = 8 y = 1 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_rook   x = 7 y = 1 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_pawn   x = 8 y = 3 )
    ).
    lt_expected = value #(
( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_rook  from_x = 8 from_y = 1 to_x = 8 to_y = 2 castling_white_long = abap_false castling_white_short = abap_true )
( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_rook  from_x = 8 from_y = 1 to_x = 7 to_y = 1 castling_white_long = abap_false castling_white_short = abap_true )
( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_pawn  from_x = 8 from_y = 3 to_x = 8 to_y = 4 special_flag = 'E' )
( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 1 to_x = 4 to_y = 1
castling_white_long = abap_true castling_white_short = abap_true )
( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 1 to_x = 4 to_y = 2
castling_white_long = abap_true castling_white_short = abap_true )
( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 1 to_x = 5 to_y = 2
castling_white_long = abap_true castling_white_short = abap_true )
( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 1 to_x = 6 to_y = 1
castling_white_long = abap_true castling_white_short = abap_true )
( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 1 to_x = 6 to_y = 2
castling_white_long = abap_true castling_white_short = abap_true )
).
    lo_object = cl_demo_sql_chess=>factory_from_position( is_settings  = value #( color = cl_demo_sql_chess=>c_color_white  )
                                                          it_positions = lt_positions ).
    select * from demo_chess_v_stage6
      where gameuuid = @lo_object->gv_gameuuid
      order by from_x, from_y, to_x, to_y
      into corresponding fields of table @lt_actual.
    cl_aunit_assert=>assert_subrc( act = sy-subrc quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = sy-dbcnt exp = 8 quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = lt_actual exp = lt_expected quit = if_aunit_constants=>no ).

    " check the result of get_next_moves
    data lv_mate type abap_bool.
    data lt_moves type cl_demo_sql_chess=>gtt_moves.
    data lt_expected_moves type cl_demo_sql_chess=>gtt_moves.
    lt_expected_moves = value #(
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_rook  from_x = 8 from_y = 1 to_x = 7 to_y = 1 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 1 to_x = 4 to_y = 2 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 1 to_x = 5 to_y = 2 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 1 to_x = 6 to_y = 2 )
    ).
    lv_mate = lo_object->get_next_moves( importing et_moves = lt_moves ).
    cl_aunit_assert=>assert_equals( act = lv_mate exp = abap_false quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = lt_moves exp = lt_expected_moves quit = if_aunit_constants=>no ).

    lo_object->delete( ).
  endmethod.

  method test_stage6_castling_009.
    data lo_object type ref to cl_demo_sql_chess.
    types begin of lty_expected.
    types color type demo_chess_color.
    types chessman type demo_chess_chessman.
    types from_x type demo_chess_xpos.
    types from_y type demo_chess_xpos.
    types to_x type demo_chess_xpos.
    types to_y type demo_chess_xpos.
    types castling_white_long type abap_bool.
    types castling_white_short type abap_bool.
    types castling_black_long type abap_bool.
    types castling_black_short type abap_bool.
    types special_flag type demo_chess_special_flag.
    types color_dep type demo_chess_color.
    types chessman_dep type demo_chess_chessman.
    types from_x_dep type demo_chess_xpos.
    types from_y_dep type demo_chess_ypos.
    types to_x_dep type demo_chess_xpos.
    types to_y_dep type demo_chess_ypos.
    types end of lty_expected.
    data lt_expected type sorted table of lty_expected with unique key from_x from_y to_x to_y.
    data lt_actual type sorted table of lty_expected with unique key from_x from_y to_x to_y.
    data lt_positions type cl_demo_sql_chess=>gtt_positions.
    lt_positions = value #(
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king   x = 5 y = 1 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king   x = 5 y = 8 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_rook   x = 8 y = 1 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_knight x = 7 y = 1 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_pawn   x = 8 y = 3 )
    ).
    lt_expected = value #(
( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_rook  from_x = 8 from_y = 1 to_x = 8 to_y = 2 castling_white_long = abap_false castling_white_short = abap_true )
( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_knight from_x = 7 from_y = 1 to_x = 6 to_y = 3 )
( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_knight from_x = 7 from_y = 1 to_x = 5 to_y = 2 )
( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_pawn  from_x = 8 from_y = 3 to_x = 8 to_y = 4 special_flag = 'E' )
( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 1 to_x = 4 to_y = 1
castling_white_long = abap_true castling_white_short = abap_true )
( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 1 to_x = 4 to_y = 2
castling_white_long = abap_true castling_white_short = abap_true )
( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 1 to_x = 5 to_y = 2
castling_white_long = abap_true castling_white_short = abap_true )
( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 1 to_x = 6 to_y = 1
castling_white_long = abap_true castling_white_short = abap_true )
( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 1 to_x = 6 to_y = 2
castling_white_long = abap_true castling_white_short = abap_true )
).
    lo_object = cl_demo_sql_chess=>factory_from_position( is_settings  = value #( color = cl_demo_sql_chess=>c_color_white  )
                                                          it_positions = lt_positions ).
    select * from demo_chess_v_stage6
      where gameuuid = @lo_object->gv_gameuuid
      order by from_x, from_y, to_x, to_y
      into corresponding fields of table @lt_actual.
    cl_aunit_assert=>assert_subrc( act = sy-subrc quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = sy-dbcnt exp = 9 quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = lt_actual exp = lt_expected quit = if_aunit_constants=>no ).

    " check the result of get_next_moves
    data lv_mate type abap_bool.
    data lt_moves type cl_demo_sql_chess=>gtt_moves.
    data lt_expected_moves type cl_demo_sql_chess=>gtt_moves.
    lt_expected_moves = corresponding #( lt_expected ).
    lv_mate = lo_object->get_next_moves( importing et_moves = lt_moves ).
    cl_aunit_assert=>assert_equals( act = lv_mate exp = abap_false quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = lt_moves exp = lt_expected_moves quit = if_aunit_constants=>no ).

    lo_object->delete( ).
  endmethod.
  method test_stage6_castling_010.
    data lo_object type ref to cl_demo_sql_chess.
    types begin of lty_expected.
    types color type demo_chess_color.
    types chessman type demo_chess_chessman.
    types from_x type demo_chess_xpos.
    types from_y type demo_chess_xpos.
    types to_x type demo_chess_xpos.
    types to_y type demo_chess_xpos.
    types castling_white_long type abap_bool.
    types castling_white_short type abap_bool.
    types castling_black_long type abap_bool.
    types castling_black_short type abap_bool.
    types special_flag type demo_chess_special_flag.
    types color_dep type demo_chess_color.
    types chessman_dep type demo_chess_chessman.
    types from_x_dep type demo_chess_xpos.
    types from_y_dep type demo_chess_ypos.
    types to_x_dep type demo_chess_xpos.
    types to_y_dep type demo_chess_ypos.
    types end of lty_expected.
    data lt_expected type sorted table of lty_expected with unique key from_x from_y to_x to_y.
    data lt_actual type sorted table of lty_expected with unique key from_x from_y to_x to_y.
    data lt_positions type cl_demo_sql_chess=>gtt_positions.
    lt_positions = value #(
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king   x = 5 y = 1 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king   x = 5 y = 8 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_rook   x = 8 y = 8 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_pawn   x = 8 y = 6 )
    ).
    lt_expected = value #(
( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_rook  from_x = 8 from_y = 8 to_x = 8 to_y = 7 castling_black_long = abap_false castling_black_short = abap_true )
( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_rook  from_x = 8 from_y = 8 to_x = 7 to_y = 8 castling_black_long = abap_false castling_black_short = abap_true )
( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_rook  from_x = 8 from_y = 8 to_x = 6 to_y = 8 castling_black_long = abap_false castling_black_short = abap_true )
( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_pawn  from_x = 8 from_y = 6 to_x = 8 to_y = 5 special_flag = 'E' )
( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 8 to_x = 7 to_y = 8
castling_black_long = abap_true castling_black_short = abap_true color_dep = cl_demo_sql_chess=>c_color_black
chessman_dep = cl_demo_sql_chess=>c_chessman_rook from_x_dep = 8 from_y_dep = 8 to_x_dep = 6 to_y_dep = 8 special_flag = 'C' )
( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 8 to_x = 4 to_y = 8
castling_black_long = abap_true castling_black_short = abap_true )
( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 8 to_x = 4 to_y = 7
castling_black_long = abap_true castling_black_short = abap_true )
( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 8 to_x = 5 to_y = 7
castling_black_long = abap_true castling_black_short = abap_true )
( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 8 to_x = 6 to_y = 8
castling_black_long = abap_true castling_black_short = abap_true )
( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 8 to_x = 6 to_y = 7
castling_black_long = abap_true castling_black_short = abap_true )
).
    lo_object = cl_demo_sql_chess=>factory_from_position( is_settings  = value #( color = cl_demo_sql_chess=>c_color_black  )
                                                          it_positions = lt_positions ).
    select * from demo_chess_v_stage6
      where gameuuid = @lo_object->gv_gameuuid
      order by from_x, from_y, to_x, to_y
      into corresponding fields of table @lt_actual.
    cl_aunit_assert=>assert_subrc( act = sy-subrc quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = sy-dbcnt exp = 10 quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = lt_actual exp = lt_expected quit = if_aunit_constants=>no ).

    " check the result of get_next_moves
    data lv_mate type abap_bool.
    data lt_moves type cl_demo_sql_chess=>gtt_moves.
    data lt_expected_moves type cl_demo_sql_chess=>gtt_moves.
    lt_expected_moves = value #(
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_rook  from_x = 8 from_y = 8 to_x = 8 to_y = 7 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_rook  from_x = 8 from_y = 8 to_x = 7 to_y = 8 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_rook  from_x = 8 from_y = 8 to_x = 6 to_y = 8 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_pawn  from_x = 8 from_y = 6 to_x = 8 to_y = 5  )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 8 to_x = 7 to_y = 8
        is_castling_black_short = abap_true )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 8 to_x = 4 to_y = 8 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 8 to_x = 4 to_y = 7 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 8 to_x = 5 to_y = 7 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 8 to_x = 6 to_y = 8 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 8 to_x = 6 to_y = 7 )
    ).
    lv_mate = lo_object->get_next_moves( importing et_moves = lt_moves ).
    cl_aunit_assert=>assert_equals( act = lv_mate exp = abap_false quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = lt_moves exp = lt_expected_moves quit = if_aunit_constants=>no ).

    lo_object->delete( ).
  endmethod.

  method test_stage6_castling_011.
    data lo_object type ref to cl_demo_sql_chess.
    types begin of lty_expected.
    types color type demo_chess_color.
    types chessman type demo_chess_chessman.
    types from_x type demo_chess_xpos.
    types from_y type demo_chess_xpos.
    types to_x type demo_chess_xpos.
    types to_y type demo_chess_xpos.
    types castling_white_long type abap_bool.
    types castling_white_short type abap_bool.
    types castling_black_long type abap_bool.
    types castling_black_short type abap_bool.
    types special_flag type demo_chess_special_flag.
    types color_dep type demo_chess_color.
    types chessman_dep type demo_chess_chessman.
    types from_x_dep type demo_chess_xpos.
    types from_y_dep type demo_chess_ypos.
    types to_x_dep type demo_chess_xpos.
    types to_y_dep type demo_chess_ypos.
    types end of lty_expected.
    data lt_expected type sorted table of lty_expected with unique key from_x from_y to_x to_y.
    data lt_actual type sorted table of lty_expected with unique key from_x from_y to_x to_y.
    data lt_positions type cl_demo_sql_chess=>gtt_positions.
    lt_positions = value #(
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king   x = 5 y = 1 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king   x = 5 y = 8 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_rook   x = 8 y = 8 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_rook   x = 7 y = 8 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_pawn   x = 8 y = 6 )
    ).
    lt_expected = value #(
( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_rook  from_x = 8 from_y = 8 to_x = 8 to_y = 7 castling_black_long = abap_false castling_black_short = abap_true )
( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_rook  from_x = 8 from_y = 8 to_x = 7 to_y = 8 castling_black_long = abap_false castling_black_short = abap_true )
( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_pawn  from_x = 8 from_y = 6 to_x = 8 to_y = 5 special_flag = 'E' )
( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 8 to_x = 4 to_y = 8
castling_black_long = abap_true castling_black_short = abap_true )
( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 8 to_x = 4 to_y = 7
castling_black_long = abap_true castling_black_short = abap_true )
( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 8 to_x = 5 to_y = 7
castling_black_long = abap_true castling_black_short = abap_true )
( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 8 to_x = 6 to_y = 8
castling_black_long = abap_true castling_black_short = abap_true )
( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 8 to_x = 6 to_y = 7
castling_black_long = abap_true castling_black_short = abap_true )
).
    lo_object = cl_demo_sql_chess=>factory_from_position( is_settings  = value #( color = cl_demo_sql_chess=>c_color_black  )
                                                          it_positions = lt_positions ).
    select * from demo_chess_v_stage6
      where gameuuid = @lo_object->gv_gameuuid
      order by from_x, from_y, to_x, to_y
      into corresponding fields of table @lt_actual.
    cl_aunit_assert=>assert_subrc( act = sy-subrc quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = sy-dbcnt exp = 8 quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = lt_actual exp = lt_expected quit = if_aunit_constants=>no ).

    " check the result of get_next_moves
    data lv_mate type abap_bool.
    data lt_moves type cl_demo_sql_chess=>gtt_moves.
    data lt_expected_moves type cl_demo_sql_chess=>gtt_moves.
    lt_expected_moves = value #(
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_rook  from_x = 8 from_y = 8 to_x = 7 to_y = 8 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 8 to_x = 4 to_y = 7 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 8 to_x = 5 to_y = 7 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 8 to_x = 6 to_y = 7 )
    ).
    lv_mate = lo_object->get_next_moves( importing et_moves = lt_moves ).
    cl_aunit_assert=>assert_equals( act = lv_mate exp = abap_false quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = lt_moves exp = lt_expected_moves quit = if_aunit_constants=>no ).

    lo_object->delete( ).
  endmethod.

  method test_stage6_castling_012.
    data lo_object type ref to cl_demo_sql_chess.
    types begin of lty_expected.
    types color type demo_chess_color.
    types chessman type demo_chess_chessman.
    types from_x type demo_chess_xpos.
    types from_y type demo_chess_xpos.
    types to_x type demo_chess_xpos.
    types to_y type demo_chess_xpos.
    types castling_white_long type abap_bool.
    types castling_white_short type abap_bool.
    types castling_black_long type abap_bool.
    types castling_black_short type abap_bool.
    types special_flag type demo_chess_special_flag.
    types color_dep type demo_chess_color.
    types chessman_dep type demo_chess_chessman.
    types from_x_dep type demo_chess_xpos.
    types from_y_dep type demo_chess_ypos.
    types to_x_dep type demo_chess_xpos.
    types to_y_dep type demo_chess_ypos.
    types end of lty_expected.
    data lt_expected type sorted table of lty_expected with unique key from_x from_y to_x to_y.
    data lt_actual type sorted table of lty_expected with unique key from_x from_y to_x to_y.
    data lt_positions type cl_demo_sql_chess=>gtt_positions.
    lt_positions = value #(
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king   x = 5 y = 1 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king   x = 5 y = 8 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_rook   x = 8 y = 8 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_knight x = 7 y = 8 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_pawn   x = 8 y = 6 )
    ).
    lt_expected = value #(
( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_rook  from_x = 8 from_y = 8 to_x = 8 to_y = 7 castling_black_long = abap_false castling_black_short = abap_true )
( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_knight from_x = 7 from_y = 8 to_x = 6 to_y = 6 )
( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_knight from_x = 7 from_y = 8 to_x = 5 to_y = 7 )
( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_pawn  from_x = 8 from_y = 6 to_x = 8 to_y = 5 special_flag = 'E' )
( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 8 to_x = 4 to_y = 8
castling_black_long = abap_true castling_black_short = abap_true )
( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 8 to_x = 4 to_y = 7
castling_black_long = abap_true castling_black_short = abap_true )
( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 8 to_x = 5 to_y = 7
castling_black_long = abap_true castling_black_short = abap_true )
( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 8 to_x = 6 to_y = 8
castling_black_long = abap_true castling_black_short = abap_true )
( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 8 to_x = 6 to_y = 7
castling_black_long = abap_true castling_black_short = abap_true )
).
    lo_object = cl_demo_sql_chess=>factory_from_position( is_settings  = value #( color = cl_demo_sql_chess=>c_color_black  )
                                                          it_positions = lt_positions ).
    select * from demo_chess_v_stage6
      where gameuuid = @lo_object->gv_gameuuid
      order by from_x, from_y, to_x, to_y
      into corresponding fields of table @lt_actual.
    cl_aunit_assert=>assert_subrc( act = sy-subrc quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = sy-dbcnt exp = 9 quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = lt_actual exp = lt_expected quit = if_aunit_constants=>no ).

    " check the result of get_next_moves
    data lv_mate type abap_bool.
    data lt_moves type cl_demo_sql_chess=>gtt_moves.
    data lt_expected_moves type cl_demo_sql_chess=>gtt_moves.
    lt_expected_moves = corresponding #( lt_expected ).
    lv_mate = lo_object->get_next_moves( importing et_moves = lt_moves ).
    cl_aunit_assert=>assert_equals( act = lv_mate exp = abap_false quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = lt_moves exp = lt_expected_moves quit = if_aunit_constants=>no ).

    lo_object->delete( ).
  endmethod.

  method test_stage7_001.
    data lo_object type ref to cl_demo_sql_chess.
    types begin of lty_expected.
    types move_color type demo_chess_color.
    types move_chessman type demo_chess_chessman.
    types move_from_x type demo_chess_xpos.
    types move_from_y type demo_chess_xpos.
    types move_to_x type demo_chess_xpos.
    types move_to_y type demo_chess_xpos.
    types castling_white_long type abap_bool.
    types castling_white_short type abap_bool.
    types castling_black_long type abap_bool.
    types castling_black_short type abap_bool.
    types special_flag type demo_chess_special_flag.
    types color type demo_chess_color.
    types chessman type demo_chess_chessman.
    types x type demo_chess_xpos.
    types y type demo_chess_ypos.
    types before_x type demo_chess_xpos.
    types before_y type demo_chess_ypos.
    types moved_flag type abap_bool.
    types end of lty_expected.
    data lt_expected type sorted table of lty_expected with unique key move_from_x move_from_y move_to_x move_to_y color chessman x y .
    data lt_actual type sorted table of lty_expected with unique key move_from_x move_from_y move_to_x move_to_y color chessman x y .
    data lt_positions type cl_demo_sql_chess=>gtt_positions.
    lt_positions = value #(
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king   x = 5 y = 1 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king   x = 5 y = 8 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_rook   x = 8 y = 8 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_pawn   x = 8 y = 6 )
    ).
    lt_expected = value #(
      ( move_color = cl_demo_sql_chess=>c_color_black move_chessman = cl_demo_sql_chess=>c_chessman_king
        move_from_x = 5 move_from_y = 8 move_to_x = 7 move_to_y = 8
        castling_black_long = abap_true castling_black_short = abap_true
        color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king x = 5 y = 1 before_x = 5 before_y = 1 )
      ( move_color = cl_demo_sql_chess=>c_color_black move_chessman = cl_demo_sql_chess=>c_chessman_king
        move_from_x = 5 move_from_y = 8 move_to_x = 7 move_to_y = 8
        castling_black_long = abap_true castling_black_short = abap_true
color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king x = 7 y = 8 before_x = 5 before_y = 8 moved_flag = abap_true  )
( move_color = cl_demo_sql_chess=>c_color_black move_chessman = cl_demo_sql_chess=>c_chessman_king
move_from_x = 5 move_from_y = 8 move_to_x = 7 move_to_y = 8
castling_black_long = abap_true castling_black_short = abap_true
color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_rook x = 6 y = 8 before_x = 8 before_y = 8 moved_flag = abap_true  )
( move_color = cl_demo_sql_chess=>c_color_black move_chessman = cl_demo_sql_chess=>c_chessman_king
move_from_x = 5 move_from_y = 8 move_to_x = 7 move_to_y = 8
castling_black_long = abap_true castling_black_short = abap_true
color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_pawn x = 8 y = 6 before_x = 8 before_y = 6 )
).
    lo_object = cl_demo_sql_chess=>factory_from_position( is_settings  = value #( color = cl_demo_sql_chess=>c_color_black  )
                                                          it_positions = lt_positions ).
    select * from demo_chess_v_stage7
      where gameuuid      = @lo_object->gv_gameuuid             and
            movecnt       = 0                                   and
            move_color    = @cl_demo_sql_chess=>c_color_black   and
            move_chessman = @cl_demo_sql_chess=>c_chessman_king and
            move_from_x   = 5 and
            move_from_y   = 8 and
            move_to_x     = 7 and
            move_to_y     = 8
      order by move_from_x, move_from_y, move_to_x, move_to_y
      into corresponding fields of table @lt_actual.
    cl_aunit_assert=>assert_subrc( act = sy-subrc quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = sy-dbcnt exp = 4 quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = lt_actual exp = lt_expected quit = if_aunit_constants=>no ).
    lo_object->delete( ).
  endmethod.

  method test_stage7_002. " capture: rook takes pawn
    data lo_object type ref to cl_demo_sql_chess.
    types begin of lty_expected.
    types move_color type demo_chess_color.
    types move_chessman type demo_chess_chessman.
    types move_from_x type demo_chess_xpos.
    types move_from_y type demo_chess_xpos.
    types move_to_x type demo_chess_xpos.
    types move_to_y type demo_chess_xpos.
    types castling_white_long type abap_bool.
    types castling_white_short type abap_bool.
    types castling_black_long type abap_bool.
    types castling_black_short type abap_bool.
    types special_flag type demo_chess_special_flag.
    types color type demo_chess_color.
    types chessman type demo_chess_chessman.
    types x type demo_chess_xpos.
    types y type demo_chess_ypos.
    types before_x type demo_chess_xpos.
    types before_y type demo_chess_ypos.
    types moved_flag type abap_bool.
    types end of lty_expected.
    data lt_expected type sorted table of lty_expected with unique key move_from_x move_from_y move_to_x move_to_y color chessman x y .
    data lt_actual type sorted table of lty_expected with unique key move_from_x move_from_y move_to_x move_to_y color chessman x y .
    data lt_positions type cl_demo_sql_chess=>gtt_positions.
    lt_positions = value #(
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king   x = 5 y = 1 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king   x = 5 y = 8 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_rook   x = 8 y = 8 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_pawn   x = 8 y = 6 )
    ).
    lt_expected = value #(
      ( move_color = cl_demo_sql_chess=>c_color_black move_chessman = cl_demo_sql_chess=>c_chessman_rook
        move_from_x = 8 move_from_y = 8 move_to_x = 8 move_to_y = 6
        castling_black_long = abap_false castling_black_short = abap_true
        color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king x = 5 y = 1 before_x = 5 before_y = 1 )
      ( move_color = cl_demo_sql_chess=>c_color_black move_chessman = cl_demo_sql_chess=>c_chessman_rook
        move_from_x = 8 move_from_y = 8 move_to_x = 8 move_to_y = 6
        castling_black_long = abap_false castling_black_short = abap_true
color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king x = 5 y = 8 before_x = 5 before_y = 8 moved_flag = abap_false  )
( move_color = cl_demo_sql_chess=>c_color_black move_chessman = cl_demo_sql_chess=>c_chessman_rook
move_from_x = 8 move_from_y = 8 move_to_x = 8 move_to_y = 6
castling_black_long = abap_false castling_black_short = abap_true
color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_rook x = 8 y = 6 before_x = 8 before_y = 8 moved_flag = abap_true  )
).
    lo_object = cl_demo_sql_chess=>factory_from_position( is_settings  = value #( color = cl_demo_sql_chess=>c_color_black  )
                                                          it_positions = lt_positions ).
    select * from demo_chess_v_stage7
      where gameuuid      = @lo_object->gv_gameuuid             and
            movecnt       = 0                                   and
            move_color    = @cl_demo_sql_chess=>c_color_black   and
            move_chessman = @cl_demo_sql_chess=>c_chessman_rook and
            move_from_x   = 8 and
            move_from_y   = 8 and
            move_to_x     = 8 and
            move_to_y     = 6
      order by move_from_x, move_from_y, move_to_x, move_to_y
      into corresponding fields of table @lt_actual.
    cl_aunit_assert=>assert_subrc( act = sy-subrc quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = sy-dbcnt exp = 3 quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = lt_actual exp = lt_expected quit = if_aunit_constants=>no ).
    lo_object->delete( ).
  endmethod.

  method test_stage7_003. " pawn transforms into queen
    data lo_object type ref to cl_demo_sql_chess.
    types begin of lty_expected.
    types move_color type demo_chess_color.
    types move_chessman type demo_chess_chessman.
    types move_from_x type demo_chess_xpos.
    types move_from_y type demo_chess_xpos.
    types move_to_x type demo_chess_xpos.
    types move_to_y type demo_chess_xpos.
    types castling_white_long type abap_bool.
    types castling_white_short type abap_bool.
    types castling_black_long type abap_bool.
    types castling_black_short type abap_bool.
    types special_flag type demo_chess_special_flag.
    types color type demo_chess_color.
    types chessman type demo_chess_chessman.
    types x type demo_chess_xpos.
    types y type demo_chess_ypos.
    types before_x type demo_chess_xpos.
    types before_y type demo_chess_ypos.
    types moved_flag type abap_bool.
    types end of lty_expected.
    data lt_expected type sorted table of lty_expected with unique key move_from_x move_from_y move_to_x move_to_y color chessman x y .
    data lt_actual type sorted table of lty_expected with unique key move_from_x move_from_y move_to_x move_to_y color chessman x y .
    data lt_positions type cl_demo_sql_chess=>gtt_positions.
    lt_positions = value #(
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king   x = 5 y = 1 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king   x = 5 y = 8 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_pawn   x = 8 y = 2 )
    ).
    lt_expected = value #(
      ( move_color = cl_demo_sql_chess=>c_color_black move_chessman = cl_demo_sql_chess=>c_chessman_pawn
        move_from_x = 8 move_from_y = 2 move_to_x = 8 move_to_y = 1
        castling_black_long = abap_false castling_black_short = abap_false
        color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king x = 5 y = 1 before_x = 5 before_y = 1 )
      ( move_color = cl_demo_sql_chess=>c_color_black move_chessman = cl_demo_sql_chess=>c_chessman_pawn
        move_from_x = 8 move_from_y = 2 move_to_x = 8 move_to_y = 1
        castling_black_long = abap_false castling_black_short = abap_false
color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king x = 5 y = 8 before_x = 5 before_y = 8 moved_flag = abap_false  )
( move_color = cl_demo_sql_chess=>c_color_black move_chessman = cl_demo_sql_chess=>c_chessman_pawn
move_from_x = 8 move_from_y = 2 move_to_x = 8 move_to_y = 1
castling_black_long = abap_false castling_black_short = abap_false
color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_queen x = 8 y = 1 before_x = 8 before_y = 2 moved_flag = abap_true  )
).
    lo_object = cl_demo_sql_chess=>factory_from_position( is_settings  = value #( color = cl_demo_sql_chess=>c_color_black  )
                                                          it_positions = lt_positions ).
    select * from demo_chess_v_stage7
      where gameuuid      = @lo_object->gv_gameuuid             and
            movecnt       = 0                                   and
            move_color    = @cl_demo_sql_chess=>c_color_black   and
            move_chessman = @cl_demo_sql_chess=>c_chessman_pawn and
            move_from_x   = 8 and
            move_from_y   = 2 and
            move_to_x     = 8 and
            move_to_y     = 1
      order by move_from_x, move_from_y, move_to_x, move_to_y
      into corresponding fields of table @lt_actual.
    cl_aunit_assert=>assert_subrc( act = sy-subrc quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = sy-dbcnt exp = 3 quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = lt_actual exp = lt_expected quit = if_aunit_constants=>no ).
    lo_object->delete( ).
  endmethod.

  method test_stage7_004. " en passant capture
    data lo_object type ref to cl_demo_sql_chess.
    types begin of lty_expected.
    types move_color type demo_chess_color.
    types move_chessman type demo_chess_chessman.
    types move_from_x type demo_chess_xpos.
    types move_from_y type demo_chess_xpos.
    types move_to_x type demo_chess_xpos.
    types move_to_y type demo_chess_xpos.
    types castling_white_long type abap_bool.
    types castling_white_short type abap_bool.
    types castling_black_long type abap_bool.
    types castling_black_short type abap_bool.
    types special_flag type demo_chess_special_flag.
    types color type demo_chess_color.
    types chessman type demo_chess_chessman.
    types x type demo_chess_xpos.
    types y type demo_chess_ypos.
    types before_x type demo_chess_xpos.
    types before_y type demo_chess_ypos.
    types moved_flag type abap_bool.
    types end of lty_expected.
    data lt_expected type sorted table of lty_expected with unique key move_from_x move_from_y move_to_x move_to_y color chessman x y .
    data lt_actual type sorted table of lty_expected with unique key move_from_x move_from_y move_to_x move_to_y color chessman x y .
    data lt_positions type cl_demo_sql_chess=>gtt_positions.
    lt_positions = value #(
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king  x = 5 y = 1 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king  x = 5 y = 8 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_pawn  x = 2 y = 4 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_pawn  x = 1 y = 4 before_x = 1 before_y = 2 )
    ).
    lt_expected = value #(
      ( move_color = cl_demo_sql_chess=>c_color_black move_chessman = cl_demo_sql_chess=>c_chessman_pawn
        move_from_x = 2 move_from_y = 4 move_to_x = 1 move_to_y = 3
        castling_black_long = abap_false castling_black_short = abap_false
        color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king x = 5 y = 1 before_x = 5 before_y = 1 )
      ( move_color = cl_demo_sql_chess=>c_color_black move_chessman = cl_demo_sql_chess=>c_chessman_pawn
        move_from_x = 2 move_from_y = 4 move_to_x = 1 move_to_y = 3
        castling_black_long = abap_false castling_black_short = abap_false
color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king x = 5 y = 8 before_x = 5 before_y = 8 moved_flag = abap_false  )
( move_color = cl_demo_sql_chess=>c_color_black move_chessman = cl_demo_sql_chess=>c_chessman_pawn
move_from_x = 2 move_from_y = 4 move_to_x = 1 move_to_y = 3
castling_black_long = abap_false castling_black_short = abap_false
color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_pawn x = 1 y = 3 before_x = 2 before_y = 4 moved_flag = abap_true  )
).
    lo_object = cl_demo_sql_chess=>factory_from_position( is_settings  = value #( color = cl_demo_sql_chess=>c_color_black  )
                                                          it_positions = lt_positions ).
    select * from demo_chess_v_stage7
      where gameuuid      = @lo_object->gv_gameuuid             and
            movecnt       = 0                                   and
            move_color    = @cl_demo_sql_chess=>c_color_black   and
            move_chessman = @cl_demo_sql_chess=>c_chessman_pawn and
            move_from_x   = 2 and
            move_from_y   = 4 and
            move_to_x     = 1 and
            move_to_y     = 3
      order by move_from_x, move_from_y, move_to_x, move_to_y
      into corresponding fields of table @lt_actual.
    cl_aunit_assert=>assert_subrc( act = sy-subrc quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = sy-dbcnt exp = 3 quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = lt_actual exp = lt_expected quit = if_aunit_constants=>no ).
    lo_object->delete( ).
  endmethod.

  method test_stage7_005. " en passant not possible
    data lo_object type ref to cl_demo_sql_chess.
    types begin of lty_expected.
    types move_color type demo_chess_color.
    types move_chessman type demo_chess_chessman.
    types move_from_x type demo_chess_xpos.
    types move_from_y type demo_chess_xpos.
    types move_to_x type demo_chess_xpos.
    types move_to_y type demo_chess_xpos.
    types castling_white_long type abap_bool.
    types castling_white_short type abap_bool.
    types castling_black_long type abap_bool.
    types castling_black_short type abap_bool.
    types special_flag type demo_chess_special_flag.
    types color type demo_chess_color.
    types chessman type demo_chess_chessman.
    types x type demo_chess_xpos.
    types y type demo_chess_ypos.
    types before_x type demo_chess_xpos.
    types before_y type demo_chess_ypos.
    types moved_flag type abap_bool.
    types end of lty_expected.
    data lt_expected type sorted table of lty_expected with unique key move_from_x move_from_y move_to_x move_to_y color chessman x y .
    data lt_actual type sorted table of lty_expected with unique key move_from_x move_from_y move_to_x move_to_y color chessman x y .
    data lt_positions type cl_demo_sql_chess=>gtt_positions.
    lt_positions = value #(
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king  x = 5 y = 1 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king  x = 5 y = 8 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_pawn  x = 2 y = 4 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_pawn  x = 1 y = 4 before_x = 1 before_y = 3 )
    ).
    lo_object = cl_demo_sql_chess=>factory_from_position( is_settings  = value #( color = cl_demo_sql_chess=>c_color_black  )
                                                          it_positions = lt_positions ).
    select * from demo_chess_v_stage7
      where gameuuid      = @lo_object->gv_gameuuid             and
            movecnt       = 0                                   and
            move_color    = @cl_demo_sql_chess=>c_color_black   and
            move_chessman = @cl_demo_sql_chess=>c_chessman_pawn and
            move_from_x   = 2 and
            move_from_y   = 4 and
            move_to_x     = 1 and
            move_to_y     = 3
      order by move_from_x, move_from_y, move_to_x, move_to_y
      into corresponding fields of table @lt_actual.
    cl_aunit_assert=>assert_subrc( act = sy-subrc exp = 4 quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = sy-dbcnt exp = 0 quit = if_aunit_constants=>no ).
    lo_object->delete( ).
  endmethod.

  method test_stage13_kings.
    data lo_object type ref to cl_demo_sql_chess.
    types begin of lty_expected.
    types color type demo_chess_color.
    types chessman type demo_chess_chessman.
    types from_x type demo_chess_xpos.
    types from_y type demo_chess_xpos.
    types to_x type demo_chess_xpos.
    types to_y type demo_chess_xpos.
    types castling_white_long type abap_bool.
    types castling_white_short type abap_bool.
    types castling_black_long type abap_bool.
    types castling_black_short type abap_bool.
    types special_flag type demo_chess_special_flag.
    types color_dep type demo_chess_color.
    types chessman_dep type demo_chess_chessman.
    types from_x_dep type demo_chess_xpos.
    types from_y_dep type demo_chess_ypos.
    types to_x_dep type demo_chess_xpos.
    types to_y_dep type demo_chess_ypos.
    types end of lty_expected.
    data lt_expected type sorted table of lty_expected with unique key from_x from_y to_x to_y.
    data lt_actual type sorted table of lty_expected with unique key from_x from_y to_x to_y.
    data lt_positions type cl_demo_sql_chess=>gtt_positions.
    lt_positions = value #(
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king   x = 5 y = 1 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king   x = 7 y = 1 )
    ).
    lt_expected = value #(
( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 1 to_x = 4 to_y = 1 castling_white_long = abap_true castling_white_short = abap_true )
( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 1 to_x = 4 to_y = 2 castling_white_long = abap_true castling_white_short = abap_true )
( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 1 to_x = 5 to_y = 2 castling_white_long = abap_true castling_white_short = abap_true )
).
    lo_object = cl_demo_sql_chess=>factory_from_position( is_settings  = value #( color = cl_demo_sql_chess=>c_color_white  )
                                                          it_positions = lt_positions ).

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
           allowed~gameuuid = @lo_object->gv_gameuuid and
           allowed~movecnt = @lo_object->gv_movecnt
    ).
    select * from demo_chess_v_stage13
      where gameuuid = @lo_object->gv_gameuuid
      order by from_x, from_y, to_x, to_y
      into corresponding fields of table @lt_actual.
    cl_aunit_assert=>assert_subrc( act = sy-subrc quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = sy-dbcnt exp = 3 quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = lt_actual exp = lt_expected quit = if_aunit_constants=>no ).

    " check the result of get_next_moves
    data lv_mate type abap_bool.
    data lt_moves type cl_demo_sql_chess=>gtt_moves.
    data lt_expected_moves type cl_demo_sql_chess=>gtt_moves.
    lt_expected_moves = corresponding #( lt_expected ).
    lv_mate = lo_object->get_next_moves( importing et_moves = lt_moves ).
    cl_aunit_assert=>assert_equals( act = lv_mate exp = abap_false quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = lt_moves exp = lt_expected_moves quit = if_aunit_constants=>no ).

    lo_object->delete( ).
  endmethod.

  method test_stage13_kings_2.
    data lo_object type ref to cl_demo_sql_chess.
    types begin of lty_expected.
    types color type demo_chess_color.
    types chessman type demo_chess_chessman.
    types from_x type demo_chess_xpos.
    types from_y type demo_chess_xpos.
    types to_x type demo_chess_xpos.
    types to_y type demo_chess_xpos.
    types castling_white_long type abap_bool.
    types castling_white_short type abap_bool.
    types castling_black_long type abap_bool.
    types castling_black_short type abap_bool.
    types special_flag type demo_chess_special_flag.
    types color_dep type demo_chess_color.
    types chessman_dep type demo_chess_chessman.
    types from_x_dep type demo_chess_xpos.
    types from_y_dep type demo_chess_ypos.
    types to_x_dep type demo_chess_xpos.
    types to_y_dep type demo_chess_ypos.
    types end of lty_expected.
    data lt_expected type sorted table of lty_expected with unique key from_x from_y to_x to_y.
    data lt_actual type sorted table of lty_expected with unique key from_x from_y to_x to_y.
    data lt_positions type cl_demo_sql_chess=>gtt_positions.
    lt_positions = value #(
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king   x = 5 y = 8 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king   x = 7 y = 8 )
    ).
    lt_expected = value #(
( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 8 to_x = 4 to_y = 8 castling_black_long = abap_true castling_black_short = abap_true )
( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 8 to_x = 4 to_y = 7 castling_black_long = abap_true castling_black_short = abap_true )
( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 8 to_x = 5 to_y = 7 castling_black_long = abap_true castling_black_short = abap_true )
).
    lo_object = cl_demo_sql_chess=>factory_from_position( is_settings  = value #( color = cl_demo_sql_chess=>c_color_black  )
                                                          it_positions = lt_positions ).
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
           allowed~gameuuid = @lo_object->gv_gameuuid and
           allowed~movecnt = @lo_object->gv_movecnt
    ).
    select * from demo_chess_v_stage13
      where gameuuid = @lo_object->gv_gameuuid
      order by from_x, from_y, to_x, to_y
      into corresponding fields of table @lt_actual.
    cl_aunit_assert=>assert_subrc( act = sy-subrc quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = sy-dbcnt exp = 3 quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = lt_actual exp = lt_expected quit = if_aunit_constants=>no ).

    " check the result of get_next_moves
    data lv_mate type abap_bool.
    data lt_moves type cl_demo_sql_chess=>gtt_moves.
    data lt_expected_moves type cl_demo_sql_chess=>gtt_moves.
    lt_expected_moves = corresponding #( lt_expected ).
    lv_mate = lo_object->get_next_moves( importing et_moves = lt_moves ).
    cl_aunit_assert=>assert_equals( act = lv_mate exp = abap_false quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = lt_moves exp = lt_expected_moves quit = if_aunit_constants=>no ).

    lo_object->delete( ).
  endmethod.

  method test_stage13_mate.
    data lo_object type ref to cl_demo_sql_chess.
    types begin of lty_expected.
    types color type demo_chess_color.
    types chessman type demo_chess_chessman.
    types from_x type demo_chess_xpos.
    types from_y type demo_chess_xpos.
    types to_x type demo_chess_xpos.
    types to_y type demo_chess_xpos.
    types castling_white_long type abap_bool.
    types castling_white_short type abap_bool.
    types castling_black_long type abap_bool.
    types castling_black_short type abap_bool.
    types special_flag type demo_chess_special_flag.
    types color_dep type demo_chess_color.
    types chessman_dep type demo_chess_chessman.
    types from_x_dep type demo_chess_xpos.
    types from_y_dep type demo_chess_ypos.
    types to_x_dep type demo_chess_xpos.
    types to_y_dep type demo_chess_ypos.
    types end of lty_expected.
    data lt_expected type sorted table of lty_expected with unique key from_x from_y to_x to_y.
    data lt_actual type sorted table of lty_expected with unique key from_x from_y to_x to_y.
    data lt_positions type cl_demo_sql_chess=>gtt_positions.
    lt_positions = value #(
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king   x = 5 y = 8 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king   x = 5 y = 1 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_queen  x = 1 y = 1 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_queen  x = 1 y = 2 )
    ).
    lo_object = cl_demo_sql_chess=>factory_from_position( is_settings  = value #( color = cl_demo_sql_chess=>c_color_white  )
                                                          it_positions = lt_positions ).

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
           allowed~gameuuid = @lo_object->gv_gameuuid and
           allowed~movecnt = @lo_object->gv_movecnt
    ).
    select * from demo_chess_v_stage13
      where gameuuid = @lo_object->gv_gameuuid
      order by from_x, from_y, to_x, to_y
      into corresponding fields of table @lt_actual.
    cl_aunit_assert=>assert_subrc( act = sy-subrc exp = 4 quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = sy-dbcnt exp = 0 quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = lt_actual exp = lt_expected quit = if_aunit_constants=>no ).

    " check the result of get_next_moves
    data lv_mate type abap_bool.
    data lt_moves type cl_demo_sql_chess=>gtt_moves.
    data lt_expected_moves type cl_demo_sql_chess=>gtt_moves.
    lv_mate = lo_object->get_next_moves( importing et_moves = lt_moves ).
    cl_aunit_assert=>assert_equals( act = lv_mate exp = abap_true quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = lt_moves exp = lt_expected_moves quit = if_aunit_constants=>no ).

    lo_object->delete( ).
  endmethod.

  method test_stage13_mate_2.
    data lo_object type ref to cl_demo_sql_chess.
    types begin of lty_expected.
    types color type demo_chess_color.
    types chessman type demo_chess_chessman.
    types from_x type demo_chess_xpos.
    types from_y type demo_chess_xpos.
    types to_x type demo_chess_xpos.
    types to_y type demo_chess_xpos.
    types castling_white_long type abap_bool.
    types castling_white_short type abap_bool.
    types castling_black_long type abap_bool.
    types castling_black_short type abap_bool.
    types special_flag type demo_chess_special_flag.
    types color_dep type demo_chess_color.
    types chessman_dep type demo_chess_chessman.
    types from_x_dep type demo_chess_xpos.
    types from_y_dep type demo_chess_ypos.
    types to_x_dep type demo_chess_xpos.
    types to_y_dep type demo_chess_ypos.
    types end of lty_expected.
    data lt_expected type sorted table of lty_expected with unique key from_x from_y to_x to_y.
    data lt_actual type sorted table of lty_expected with unique key from_x from_y to_x to_y.
    data lt_positions type cl_demo_sql_chess=>gtt_positions.
    lt_positions = value #(
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king   x = 5 y = 8 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king   x = 5 y = 1 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_queen  x = 1 y = 8 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_queen  x = 1 y = 7 )
    ).
    lo_object = cl_demo_sql_chess=>factory_from_position( is_settings  = value #( color = cl_demo_sql_chess=>c_color_black  )
                                                          it_positions = lt_positions ).
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
           allowed~gameuuid = @lo_object->gv_gameuuid and
           allowed~movecnt = @lo_object->gv_movecnt
    ).
    select * from demo_chess_v_stage13
      where gameuuid = @lo_object->gv_gameuuid
      order by from_x, from_y, to_x, to_y
      into corresponding fields of table @lt_actual.
    cl_aunit_assert=>assert_subrc( act = sy-subrc exp = 4 quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = sy-dbcnt exp = 0 quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = lt_actual exp = lt_expected quit = if_aunit_constants=>no ).

    " check the result of get_next_moves
    data lv_mate type abap_bool.
    data lt_moves type cl_demo_sql_chess=>gtt_moves.
    data lt_expected_moves type cl_demo_sql_chess=>gtt_moves.
    lv_mate = lo_object->get_next_moves( importing et_moves = lt_moves ).
    cl_aunit_assert=>assert_equals( act = lv_mate exp = abap_true quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = lt_moves exp = lt_expected_moves quit = if_aunit_constants=>no ).

    lo_object->delete( ).
  endmethod.

  method test_stage13_not_mate.
    data lo_object type ref to cl_demo_sql_chess.
    types begin of lty_expected.
    types color type demo_chess_color.
    types chessman type demo_chess_chessman.
    types from_x type demo_chess_xpos.
    types from_y type demo_chess_xpos.
    types to_x type demo_chess_xpos.
    types to_y type demo_chess_xpos.
    types castling_white_long type abap_bool.
    types castling_white_short type abap_bool.
    types castling_black_long type abap_bool.
    types castling_black_short type abap_bool.
    types special_flag type demo_chess_special_flag.
    types color_dep type demo_chess_color.
    types chessman_dep type demo_chess_chessman.
    types from_x_dep type demo_chess_xpos.
    types from_y_dep type demo_chess_ypos.
    types to_x_dep type demo_chess_xpos.
    types to_y_dep type demo_chess_ypos.
    types end of lty_expected.
    data lt_expected type sorted table of lty_expected with unique key from_x from_y to_x to_y.
    data lt_actual type sorted table of lty_expected with unique key from_x from_y to_x to_y.
    data lt_positions type cl_demo_sql_chess=>gtt_positions.
    lt_positions = value #(
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king   x = 5 y = 8  )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king   x = 5 y = 1  )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_queen  x = 5 y = 7 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_queen  x = 4 y = 2 )
    ).
    lt_expected = value #(
( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_queen from_x = 4 from_y = 2 to_x = 5 to_y = 2 )
( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_queen from_x = 4 from_y = 2 to_x = 5 to_y = 3 )
( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king from_x = 5 from_y = 1 to_x = 4 to_y = 1 castling_white_long = abap_true castling_white_short = abap_true )
( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king from_x = 5 from_y = 1 to_x = 6 to_y = 1 castling_white_long = abap_true castling_white_short = abap_true )
( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king from_x = 5 from_y = 1 to_x = 6 to_y = 2 castling_white_long = abap_true castling_white_short = abap_true )
).
    lo_object = cl_demo_sql_chess=>factory_from_position( is_settings  = value #( color = cl_demo_sql_chess=>c_color_white  )
                                                          it_positions = lt_positions ).
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
           allowed~gameuuid = @lo_object->gv_gameuuid and
           allowed~movecnt = @lo_object->gv_movecnt
    ).
    select * from demo_chess_v_stage13
      where gameuuid = @lo_object->gv_gameuuid
      order by from_x, from_y, to_x, to_y
      into corresponding fields of table @lt_actual.
    cl_aunit_assert=>assert_subrc( act = sy-subrc quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = sy-dbcnt exp = 5 quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = lt_actual exp = lt_expected quit = if_aunit_constants=>no ).

    " check the result of get_next_moves
    data lv_mate type abap_bool.
    data lt_moves type cl_demo_sql_chess=>gtt_moves.
    data lt_expected_moves type cl_demo_sql_chess=>gtt_moves.
    lt_expected_moves = corresponding #( lt_expected ).
    lv_mate = lo_object->get_next_moves( importing et_moves = lt_moves ).
    cl_aunit_assert=>assert_equals( act = lv_mate exp = abap_false quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = lt_moves exp = lt_expected_moves quit = if_aunit_constants=>no ).

    lo_object->delete( ).
  endmethod.

  method test_stage13_not_mate_2.
    data lo_object type ref to cl_demo_sql_chess.
    types begin of lty_expected.
    types color type demo_chess_color.
    types chessman type demo_chess_chessman.
    types from_x type demo_chess_xpos.
    types from_y type demo_chess_xpos.
    types to_x type demo_chess_xpos.
    types to_y type demo_chess_xpos.
    types castling_white_long type abap_bool.
    types castling_white_short type abap_bool.
    types castling_black_long type abap_bool.
    types castling_black_short type abap_bool.
    types special_flag type demo_chess_special_flag.
    types color_dep type demo_chess_color.
    types chessman_dep type demo_chess_chessman.
    types from_x_dep type demo_chess_xpos.
    types from_y_dep type demo_chess_ypos.
    types to_x_dep type demo_chess_xpos.
    types to_y_dep type demo_chess_ypos.
    types end of lty_expected.
    data lt_expected type sorted table of lty_expected with unique key from_x from_y to_x to_y.
    data lt_actual type sorted table of lty_expected with unique key from_x from_y to_x to_y.
    data lt_positions type cl_demo_sql_chess=>gtt_positions.

    lt_positions = value #(
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king   x = 5 y = 8  )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king   x = 5 y = 1 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_queen  x = 5 y = 2 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_queen  x = 4 y = 7 )
    ).
    lt_expected = value #(
( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_queen from_x = 4 from_y = 7 to_x = 5 to_y = 7 )
( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_queen from_x = 4 from_y = 7 to_x = 5 to_y = 6 )
( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 8 to_x = 4 to_y = 8 castling_black_long = abap_true castling_black_short = abap_true )
( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 8 to_x = 6 to_y = 8 castling_black_long = abap_true castling_black_short = abap_true )
( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 8 to_x = 6 to_y = 7 castling_black_long = abap_true castling_black_short = abap_true )
).
    lo_object = cl_demo_sql_chess=>factory_from_position( is_settings  = value #( color = cl_demo_sql_chess=>c_color_black  )
                                                          it_positions = lt_positions ).
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
           allowed~gameuuid = @lo_object->gv_gameuuid and
           allowed~movecnt = @lo_object->gv_movecnt
    ).
    select * from demo_chess_v_stage13
      where gameuuid = @lo_object->gv_gameuuid
      order by from_x, from_y, to_x, to_y
      into corresponding fields of table @lt_actual.
    cl_aunit_assert=>assert_subrc( act = sy-subrc quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = sy-dbcnt exp = 5 quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = lt_actual exp = lt_expected quit = if_aunit_constants=>no ).

    " check the result of get_next_moves
    data lv_mate type abap_bool.
    data lt_moves type cl_demo_sql_chess=>gtt_moves.
    data lt_expected_moves type cl_demo_sql_chess=>gtt_moves.
    lt_expected_moves = corresponding #( lt_expected ).
    lv_mate = lo_object->get_next_moves( importing et_moves = lt_moves ).
    cl_aunit_assert=>assert_equals( act = lv_mate exp = abap_false quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = lt_moves exp = lt_expected_moves quit = if_aunit_constants=>no ).

    lo_object->delete( ).
  endmethod.

  method test_next_move_mate_cst_001.
    data lv_mate type abap_bool.
    data lt_moves type cl_demo_sql_chess=>gtt_moves.
    data lt_expected_moves type cl_demo_sql_chess=>gtt_moves.
    data lt_positions type cl_demo_sql_chess=>gtt_positions.
    data lo_object type ref to cl_demo_sql_chess.
    lt_positions = value #(
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king x = 5 y = 8 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king x = 5 y = 1 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_rook x = 1 y = 1 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_pawn x = 1 y = 2 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_rook x = 5 y = 4 )
    ).
    lt_expected_moves = value #( " no castling allowed => king is in chess!
( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 1 to_x = 4 to_y = 1 )
( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 1 to_x = 6 to_y = 1 )
( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 1 to_x = 4 to_y = 2 )
( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 1 to_x = 6 to_y = 2 )
).
    lo_object = cl_demo_sql_chess=>factory_from_position( is_settings  = value #( color = cl_demo_sql_chess=>c_color_white  )
                                                          it_positions = lt_positions ).
    lv_mate = lo_object->get_next_moves( importing et_moves = lt_moves ).
    cl_aunit_assert=>assert_equals( act = lv_mate exp = abap_false quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = lt_moves exp = lt_expected_moves quit = if_aunit_constants=>no ).
    lo_object->delete( ).
  endmethod.

  method test_next_move_mate_cst_002.
    data lv_mate type abap_bool.
    data lt_moves type cl_demo_sql_chess=>gtt_moves.
    data lt_expected_moves type cl_demo_sql_chess=>gtt_moves.
    data lt_positions type cl_demo_sql_chess=>gtt_positions.
    data lo_object type ref to cl_demo_sql_chess.
    lt_positions = value #(
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king x = 5 y = 8 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king x = 5 y = 1 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_rook x = 1 y = 1 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_pawn x = 1 y = 2 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_rook x = 4 y = 4 )
    ).
    lt_expected_moves = value #( " no castling allowed => king is in chess!
( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_rook  from_x = 1 from_y = 1 to_x = 2 to_y = 1 )
( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_rook  from_x = 1 from_y = 1 to_x = 3 to_y = 1 )
( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_rook  from_x = 1 from_y = 1 to_x = 4 to_y = 1 )

( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_pawn  from_x = 1 from_y = 2 to_x = 1 to_y = 3 )
( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_pawn  from_x = 1 from_y = 2 to_x = 1 to_y = 4 )

( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 1 to_x = 5 to_y = 2 )
( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 1 to_x = 6 to_y = 1 )
( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 1 to_x = 6 to_y = 2 )
).
    lo_object = cl_demo_sql_chess=>factory_from_position( is_settings  = value #( color = cl_demo_sql_chess=>c_color_white  )
                                                          it_positions = lt_positions ).
    lv_mate = lo_object->get_next_moves( importing et_moves = lt_moves ).
    cl_aunit_assert=>assert_equals( act = lv_mate exp = abap_false quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = lt_moves exp = lt_expected_moves quit = if_aunit_constants=>no ).
    lo_object->delete( ).
  endmethod.

  method test_next_move_mate_cst_003.
    data lv_mate type abap_bool.
    data lt_moves type cl_demo_sql_chess=>gtt_moves.
    data lt_expected_moves type cl_demo_sql_chess=>gtt_moves.
    data lt_positions type cl_demo_sql_chess=>gtt_positions.
    data lo_object type ref to cl_demo_sql_chess.
    lt_positions = value #(
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king x = 5 y = 8 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king x = 5 y = 1 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_rook x = 1 y = 1 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_pawn x = 1 y = 2 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_rook x = 3 y = 4 )
    ).
    lt_expected_moves = value #( " no castling allowed => king is in chess!
( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_rook  from_x = 1 from_y = 1 to_x = 2 to_y = 1 )
( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_rook  from_x = 1 from_y = 1 to_x = 3 to_y = 1 )
( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_rook  from_x = 1 from_y = 1 to_x = 4 to_y = 1 )

( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_pawn  from_x = 1 from_y = 2 to_x = 1 to_y = 3 )
( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_pawn  from_x = 1 from_y = 2 to_x = 1 to_y = 4 )

( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 1 to_x = 4 to_y = 1 )
( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 1 to_x = 4 to_y = 2 )
( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 1 to_x = 5 to_y = 2 )
( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 1 to_x = 6 to_y = 1 )
( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 1 to_x = 6 to_y = 2 )
).
    lo_object = cl_demo_sql_chess=>factory_from_position( is_settings  = value #( color = cl_demo_sql_chess=>c_color_white  )
                                                          it_positions = lt_positions ).
    lv_mate = lo_object->get_next_moves( importing et_moves = lt_moves ).
    cl_aunit_assert=>assert_equals( act = lv_mate exp = abap_false quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = lt_moves exp = lt_expected_moves quit = if_aunit_constants=>no ).
    lo_object->delete( ).
  endmethod.

  method test_next_move_mate_cst_004.
    data lv_mate type abap_bool.
    data lt_moves type cl_demo_sql_chess=>gtt_moves.
    data lt_expected_moves type cl_demo_sql_chess=>gtt_moves.
    data lt_positions type cl_demo_sql_chess=>gtt_positions.
    data lo_object type ref to cl_demo_sql_chess.
    lt_positions = value #(
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king x = 5 y = 8 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king x = 5 y = 1 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_rook x = 1 y = 1 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_pawn x = 1 y = 2 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_rook x = 2 y = 4 )
    ).
    lt_expected_moves = value #( " no castling allowed => king is in chess!
( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_rook  from_x = 1 from_y = 1 to_x = 2 to_y = 1 )
( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_rook  from_x = 1 from_y = 1 to_x = 3 to_y = 1 )
( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_rook  from_x = 1 from_y = 1 to_x = 4 to_y = 1 )

( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_pawn  from_x = 1 from_y = 2 to_x = 1 to_y = 3 )
( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_pawn  from_x = 1 from_y = 2 to_x = 1 to_y = 4 )

( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 1 to_x = 3 to_y = 1
is_castling_white_long = abap_true ) " castling is allowed!
( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 1 to_x = 4 to_y = 1 )
( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 1 to_x = 4 to_y = 2 )
( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 1 to_x = 5 to_y = 2 )
( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 1 to_x = 6 to_y = 1 )
( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 1 to_x = 6 to_y = 2 )
).
    lo_object = cl_demo_sql_chess=>factory_from_position( is_settings  = value #( color = cl_demo_sql_chess=>c_color_white  )
                                                          it_positions = lt_positions ).
    lv_mate = lo_object->get_next_moves( importing et_moves = lt_moves ).
    cl_aunit_assert=>assert_equals( act = lv_mate exp = abap_false quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = lt_moves exp = lt_expected_moves quit = if_aunit_constants=>no ).
    lo_object->delete( ).
  endmethod.

  method test_next_move_mate_cst_005.
    data lv_mate type abap_bool.
    data lt_moves type cl_demo_sql_chess=>gtt_moves.
    data lt_expected_moves type cl_demo_sql_chess=>gtt_moves.
    data lt_positions type cl_demo_sql_chess=>gtt_positions.
    data lo_object type ref to cl_demo_sql_chess.
    lt_positions = value #(
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king x = 5 y = 8 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king x = 5 y = 1 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_rook x = 1 y = 8 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_pawn x = 1 y = 7 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_rook x = 5 y = 4 )
    ).
    lt_expected_moves = value #( " no castling allowed => king is in chess!
( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 8 to_x = 4 to_y = 8 )
( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 8 to_x = 6 to_y = 8 )
( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 8 to_x = 4 to_y = 7 )
( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 8 to_x = 6 to_y = 7 )
).
    lo_object = cl_demo_sql_chess=>factory_from_position( is_settings  = value #( color = cl_demo_sql_chess=>c_color_black  )
                                                          it_positions = lt_positions ).
    lv_mate = lo_object->get_next_moves( importing et_moves = lt_moves ).
    cl_aunit_assert=>assert_equals( act = lv_mate exp = abap_false quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = lt_moves exp = lt_expected_moves quit = if_aunit_constants=>no ).
    lo_object->delete( ).
  endmethod.

  method test_next_move_mate_cst_006.
    data lv_mate type abap_bool.
    data lt_moves type cl_demo_sql_chess=>gtt_moves.
    data lt_expected_moves type cl_demo_sql_chess=>gtt_moves.
    data lt_positions type cl_demo_sql_chess=>gtt_positions.
    data lo_object type ref to cl_demo_sql_chess.
    lt_positions = value #(
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king x = 5 y = 8 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king x = 5 y = 1 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_rook x = 1 y = 8 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_pawn x = 1 y = 7 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_rook x = 4 y = 4 )
    ).
    lt_expected_moves = value #( " no castling allowed => king is in chess!
( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_rook  from_x = 1 from_y = 8 to_x = 2 to_y = 8 )
( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_rook  from_x = 1 from_y = 8 to_x = 3 to_y = 8 )
( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_rook  from_x = 1 from_y = 8 to_x = 4 to_y = 8 )

( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_pawn  from_x = 1 from_y = 7 to_x = 1 to_y = 6 )
( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_pawn  from_x = 1 from_y = 7 to_x = 1 to_y = 5 )

( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 8 to_x = 5 to_y = 7 )
( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 8 to_x = 6 to_y = 8 )
( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 8 to_x = 6 to_y = 7 )
).
    lo_object = cl_demo_sql_chess=>factory_from_position( is_settings  = value #( color = cl_demo_sql_chess=>c_color_black  )
                                                          it_positions = lt_positions ).
    lv_mate = lo_object->get_next_moves( importing et_moves = lt_moves ).
    cl_aunit_assert=>assert_equals( act = lv_mate exp = abap_false quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = lt_moves exp = lt_expected_moves quit = if_aunit_constants=>no ).
    lo_object->delete( ).
  endmethod.

  method test_next_move_mate_cst_007.
    data lv_mate type abap_bool.
    data lt_moves type cl_demo_sql_chess=>gtt_moves.
    data lt_expected_moves type cl_demo_sql_chess=>gtt_moves.
    data lt_positions type cl_demo_sql_chess=>gtt_positions.
    data lo_object type ref to cl_demo_sql_chess.
    lt_positions = value #(
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king x = 5 y = 8 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king x = 5 y = 1 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_rook x = 1 y = 8 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_pawn x = 1 y = 7 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_rook x = 3 y = 4 )
    ).
    lt_expected_moves = value #( " no castling allowed => king is in chess!
( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_rook  from_x = 1 from_y = 8 to_x = 2 to_y = 8 )
( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_rook  from_x = 1 from_y = 8 to_x = 3 to_y = 8 )
( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_rook  from_x = 1 from_y = 8 to_x = 4 to_y = 8 )

( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_pawn  from_x = 1 from_y = 7 to_x = 1 to_y = 6 )
( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_pawn  from_x = 1 from_y = 7 to_x = 1 to_y = 5 )

( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 8 to_x = 4 to_y = 8 )
( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 8 to_x = 4 to_y = 7 )
( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 8 to_x = 5 to_y = 7 )
( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 8 to_x = 6 to_y = 8 )
( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 8 to_x = 6 to_y = 7 )
).
    lo_object = cl_demo_sql_chess=>factory_from_position( is_settings  = value #( color = cl_demo_sql_chess=>c_color_black  )
                                                          it_positions = lt_positions ).
    lv_mate = lo_object->get_next_moves( importing et_moves = lt_moves ).
    cl_aunit_assert=>assert_equals( act = lv_mate exp = abap_false quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = lt_moves exp = lt_expected_moves quit = if_aunit_constants=>no ).
    lo_object->delete( ).
  endmethod.

  method test_next_move_mate_cst_008.
    data lv_mate type abap_bool.
    data lt_moves type cl_demo_sql_chess=>gtt_moves.
    data lt_expected_moves type cl_demo_sql_chess=>gtt_moves.
    data lt_positions type cl_demo_sql_chess=>gtt_positions.
    data lo_object type ref to cl_demo_sql_chess.
    lt_positions = value #(
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king x = 5 y = 8 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king x = 5 y = 1 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_rook x = 1 y = 8 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_pawn x = 1 y = 7 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_rook x = 2 y = 4 )
    ).
    lt_expected_moves = value #( " no castling allowed => king is in chess!
( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_rook  from_x = 1 from_y = 8 to_x = 2 to_y = 8 )
( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_rook  from_x = 1 from_y = 8 to_x = 3 to_y = 8 )
( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_rook  from_x = 1 from_y = 8 to_x = 4 to_y = 8 )

( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_pawn  from_x = 1 from_y = 7 to_x = 1 to_y = 6 )
( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_pawn  from_x = 1 from_y = 7 to_x = 1 to_y = 5 )

( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 8 to_x = 3 to_y = 8 is_castling_black_long = abap_true ) " castling is allowed!
( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 8 to_x = 4 to_y = 8 )
( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 8 to_x = 4 to_y = 7 )
( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 8 to_x = 5 to_y = 7 )
( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 8 to_x = 6 to_y = 8 )
( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 8 to_x = 6 to_y = 7 )
).
    lo_object = cl_demo_sql_chess=>factory_from_position( is_settings  = value #( color = cl_demo_sql_chess=>c_color_black  )
                                                          it_positions = lt_positions ).
    lv_mate = lo_object->get_next_moves( importing et_moves = lt_moves ).
    cl_aunit_assert=>assert_equals( act = lv_mate exp = abap_false quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = lt_moves exp = lt_expected_moves quit = if_aunit_constants=>no ).
    lo_object->delete( ).
  endmethod.

  method test_next_move_mate_cst_009.
    data lv_mate type abap_bool.
    data lt_moves type cl_demo_sql_chess=>gtt_moves.
    data lt_expected_moves type cl_demo_sql_chess=>gtt_moves.
    data lt_positions type cl_demo_sql_chess=>gtt_positions.
    data lo_object type ref to cl_demo_sql_chess.
    lt_positions = value #(
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king x = 5 y = 8 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king x = 5 y = 1 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_rook x = 8 y = 1 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_pawn x = 8 y = 2 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_rook x = 5 y = 4 )
    ).
    lt_expected_moves = value #( " no castling allowed => king is in chess!
( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 1 to_x = 4 to_y = 1 )
( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 1 to_x = 6 to_y = 1 )
( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 1 to_x = 4 to_y = 2 )
( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 1 to_x = 6 to_y = 2 )
).
    lo_object = cl_demo_sql_chess=>factory_from_position( is_settings  = value #( color = cl_demo_sql_chess=>c_color_white  )
                                                          it_positions = lt_positions ).
    lv_mate = lo_object->get_next_moves( importing et_moves = lt_moves ).
    cl_aunit_assert=>assert_equals( act = lv_mate exp = abap_false quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = lt_moves exp = lt_expected_moves quit = if_aunit_constants=>no ).
    lo_object->delete( ).
  endmethod.

  method test_next_move_mate_cst_010.
    data lv_mate type abap_bool.
    data lt_moves type cl_demo_sql_chess=>gtt_moves.
    data lt_expected_moves type cl_demo_sql_chess=>gtt_moves.
    data lt_positions type cl_demo_sql_chess=>gtt_positions.
    data lo_object type ref to cl_demo_sql_chess.
    lt_positions = value #(
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king x = 5 y = 8 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king x = 5 y = 1 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_rook x = 8 y = 1 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_pawn x = 8 y = 2 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_rook x = 6 y = 4 )
    ).
    lt_expected_moves = value #(
( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_rook  from_x = 8 from_y = 1 to_x = 7 to_y = 1 )
( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_rook  from_x = 8 from_y = 1 to_x = 6 to_y = 1 )

( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_pawn  from_x = 8 from_y = 2 to_x = 8 to_y = 3 )
( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_pawn  from_x = 8 from_y = 2 to_x = 8 to_y = 4 )

( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 1 to_x = 5 to_y = 2 )
( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 1 to_x = 4 to_y = 1 )
( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 1 to_x = 4 to_y = 2 )
).
    lo_object = cl_demo_sql_chess=>factory_from_position( is_settings  = value #( color = cl_demo_sql_chess=>c_color_white  )
                                                          it_positions = lt_positions ).
    lv_mate = lo_object->get_next_moves( importing et_moves = lt_moves ).
    cl_aunit_assert=>assert_equals( act = lv_mate exp = abap_false quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = lt_moves exp = lt_expected_moves quit = if_aunit_constants=>no ).
    lo_object->delete( ).
  endmethod.

  method test_next_move_mate_cst_011.
    data lv_mate type abap_bool.
    data lt_moves type cl_demo_sql_chess=>gtt_moves.
    data lt_expected_moves type cl_demo_sql_chess=>gtt_moves.
    data lt_positions type cl_demo_sql_chess=>gtt_positions.
    data lo_object type ref to cl_demo_sql_chess.
    lt_positions = value #(
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king x = 5 y = 8 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king x = 5 y = 1 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_rook x = 8 y = 1 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_pawn x = 8 y = 2 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_rook x = 7 y = 4 )
    ).
    lt_expected_moves = value #(
( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_rook  from_x = 8 from_y = 1 to_x = 7 to_y = 1 )
( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_rook  from_x = 8 from_y = 1 to_x = 6 to_y = 1 )

( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_pawn  from_x = 8 from_y = 2 to_x = 8 to_y = 3 )
( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_pawn  from_x = 8 from_y = 2 to_x = 8 to_y = 4 )

( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 1 to_x = 5 to_y = 2 )
( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 1 to_x = 4 to_y = 1 )
( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 1 to_x = 6 to_y = 1 )
( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 1 to_x = 4 to_y = 2 )
( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 1 to_x = 6 to_y = 2 )
).
    lo_object = cl_demo_sql_chess=>factory_from_position( is_settings  = value #( color = cl_demo_sql_chess=>c_color_white  )
                                                          it_positions = lt_positions ).
    lv_mate = lo_object->get_next_moves( importing et_moves = lt_moves ).
    cl_aunit_assert=>assert_equals( act = lv_mate exp = abap_false quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = lt_moves exp = lt_expected_moves quit = if_aunit_constants=>no ).
    lo_object->delete( ).
  endmethod.

  method test_next_move_mate_cst_012.
    data lv_mate type abap_bool.
    data lt_moves type cl_demo_sql_chess=>gtt_moves.
    data lt_expected_moves type cl_demo_sql_chess=>gtt_moves.
    data lt_positions type cl_demo_sql_chess=>gtt_positions.
    data lo_object type ref to cl_demo_sql_chess.
    lt_positions = value #(
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king x = 5 y = 8 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king x = 5 y = 1 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_rook x = 8 y = 1 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_pawn x = 8 y = 2 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_rook x = 8 y = 4 )
    ).
    lt_expected_moves = value #(
( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_rook  from_x = 8 from_y = 1 to_x = 7 to_y = 1 )
( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_rook  from_x = 8 from_y = 1 to_x = 6 to_y = 1 )

( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_pawn  from_x = 8 from_y = 2 to_x = 8 to_y = 3 )

( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 1 to_x = 7 to_y = 1 is_castling_white_short = abap_true )
( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 1 to_x = 5 to_y = 2 )
( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 1 to_x = 4 to_y = 1 )
( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 1 to_x = 6 to_y = 1 )
( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 1 to_x = 4 to_y = 2 )
( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 1 to_x = 6 to_y = 2 )
).
    lo_object = cl_demo_sql_chess=>factory_from_position( is_settings  = value #( color = cl_demo_sql_chess=>c_color_white  )
                                                          it_positions = lt_positions ).
    lv_mate = lo_object->get_next_moves( importing et_moves = lt_moves ).
    cl_aunit_assert=>assert_equals( act = lv_mate exp = abap_false quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = lt_moves exp = lt_expected_moves quit = if_aunit_constants=>no ).
    lo_object->delete( ).
  endmethod.

  method test_next_move_mate_cst_013.
    data lv_mate type abap_bool.
    data lt_moves type cl_demo_sql_chess=>gtt_moves.
    data lt_expected_moves type cl_demo_sql_chess=>gtt_moves.
    data lt_positions type cl_demo_sql_chess=>gtt_positions.
    data lo_object type ref to cl_demo_sql_chess.
    lt_positions = value #(
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king x = 5 y = 8 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king x = 5 y = 1 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_rook x = 8 y = 8 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_pawn x = 8 y = 7 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_rook x = 5 y = 4 )
    ).
    lt_expected_moves = value #( " no castling allowed => king is in chess!
( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 8 to_x = 4 to_y = 8 )
( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 8 to_x = 6 to_y = 8 )
( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 8 to_x = 4 to_y = 7 )
( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 8 to_x = 6 to_y = 7 )
).
    lo_object = cl_demo_sql_chess=>factory_from_position( is_settings  = value #( color = cl_demo_sql_chess=>c_color_black  )
                                                          it_positions = lt_positions ).
    lv_mate = lo_object->get_next_moves( importing et_moves = lt_moves ).
    cl_aunit_assert=>assert_equals( act = lv_mate exp = abap_false quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = lt_moves exp = lt_expected_moves quit = if_aunit_constants=>no ).
    lo_object->delete( ).
  endmethod.

  method test_next_move_mate_cst_014.
    data lv_mate type abap_bool.
    data lt_moves type cl_demo_sql_chess=>gtt_moves.
    data lt_expected_moves type cl_demo_sql_chess=>gtt_moves.
    data lt_positions type cl_demo_sql_chess=>gtt_positions.
    data lo_object type ref to cl_demo_sql_chess.
    lt_positions = value #(
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king x = 5 y = 8 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king x = 5 y = 1 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_rook x = 8 y = 8 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_pawn x = 8 y = 7 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_rook x = 6 y = 4 )
    ).
    lt_expected_moves = value #(
( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_rook  from_x = 8 from_y = 8 to_x = 7 to_y = 8 )
( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_rook  from_x = 8 from_y = 8 to_x = 6 to_y = 8 )

( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_pawn  from_x = 8 from_y = 7 to_x = 8 to_y = 6 )
( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_pawn  from_x = 8 from_y = 7 to_x = 8 to_y = 5 )

( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 8 to_x = 5 to_y = 7 )
( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 8 to_x = 4 to_y = 8 )
( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 8 to_x = 4 to_y = 7 )
).
    lo_object = cl_demo_sql_chess=>factory_from_position( is_settings  = value #( color = cl_demo_sql_chess=>c_color_black  )
                                                          it_positions = lt_positions ).
    lv_mate = lo_object->get_next_moves( importing et_moves = lt_moves ).
    cl_aunit_assert=>assert_equals( act = lv_mate exp = abap_false quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = lt_moves exp = lt_expected_moves quit = if_aunit_constants=>no ).
    lo_object->delete( ).
  endmethod.

  method test_next_move_mate_cst_015.
    data lv_mate type abap_bool.
    data lt_moves type cl_demo_sql_chess=>gtt_moves.
    data lt_expected_moves type cl_demo_sql_chess=>gtt_moves.
    data lt_positions type cl_demo_sql_chess=>gtt_positions.
    data lo_object type ref to cl_demo_sql_chess.
    lt_positions = value #(
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king x = 5 y = 8 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king x = 5 y = 1 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_rook x = 8 y = 8 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_pawn x = 8 y = 7 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_rook x = 7 y = 4 )
    ).
    lt_expected_moves = value #(
( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_rook  from_x = 8 from_y = 8 to_x = 7 to_y = 8 )
( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_rook  from_x = 8 from_y = 8 to_x = 6 to_y = 8 )

( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_pawn  from_x = 8 from_y = 7 to_x = 8 to_y = 6 )
( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_pawn  from_x = 8 from_y = 7 to_x = 8 to_y = 5 )

( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 8 to_x = 5 to_y = 7 )
( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 8 to_x = 4 to_y = 8 )
( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 8 to_x = 6 to_y = 8 )
( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 8 to_x = 4 to_y = 7 )
( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 8 to_x = 6 to_y = 7 )
).
    lo_object = cl_demo_sql_chess=>factory_from_position( is_settings  = value #( color = cl_demo_sql_chess=>c_color_black  )
                                                          it_positions = lt_positions ).
    lv_mate = lo_object->get_next_moves( importing et_moves = lt_moves ).
    cl_aunit_assert=>assert_equals( act = lv_mate exp = abap_false quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = lt_moves exp = lt_expected_moves quit = if_aunit_constants=>no ).
    lo_object->delete( ).
  endmethod.

  method test_next_move_mate_cst_016.
    data lv_mate type abap_bool.
    data lt_moves type cl_demo_sql_chess=>gtt_moves.
    data lt_expected_moves type cl_demo_sql_chess=>gtt_moves.
    data lt_positions type cl_demo_sql_chess=>gtt_positions.
    data lo_object type ref to cl_demo_sql_chess.
    lt_positions = value #(
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king x = 5 y = 8 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king x = 5 y = 1 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_rook x = 8 y = 8 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_pawn x = 8 y = 7 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_rook x = 8 y = 4 )
    ).
    lt_expected_moves = value #(
( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_rook  from_x = 8 from_y = 8 to_x = 7 to_y = 8 )
( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_rook  from_x = 8 from_y = 8 to_x = 6 to_y = 8 )

( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_pawn  from_x = 8 from_y = 7 to_x = 8 to_y = 6 )
( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_pawn  from_x = 8 from_y = 7 to_x = 8 to_y = 5 )

( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 8 to_x = 7 to_y = 8 is_castling_black_short = abap_true )
( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 8 to_x = 5 to_y = 7 )
( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 8 to_x = 4 to_y = 8 )
( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 8 to_x = 6 to_y = 8 )
( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 8 to_x = 4 to_y = 7 )
( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king  from_x = 5 from_y = 8 to_x = 6 to_y = 7 )
).
    lo_object = cl_demo_sql_chess=>factory_from_position( is_settings  = value #( color = cl_demo_sql_chess=>c_color_black  )
                                                          it_positions = lt_positions ).
    lv_mate = lo_object->get_next_moves( importing et_moves = lt_moves ).
    cl_aunit_assert=>assert_equals( act = lv_mate exp = abap_false quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = lt_moves exp = lt_expected_moves quit = if_aunit_constants=>no ).
    lo_object->delete( ).
  endmethod.

  method test_next_move_released.
    data lt_moves type cl_demo_sql_chess=>gtt_moves.
    data lt_positions type cl_demo_sql_chess=>gtt_positions.
    data lo_object type ref to cl_demo_sql_chess.
    data lo_exc type ref to cx_demo_sql_chess.
    data lv_catched type abap_bool.
    lt_positions = value #(
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king x = 5 y = 8 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king x = 5 y = 1 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_rook x = 8 y = 8 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_pawn x = 8 y = 7 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_rook x = 8 y = 4 )
    ).
    lo_object = cl_demo_sql_chess=>factory_from_position( is_settings  = value #( color = cl_demo_sql_chess=>c_color_black  )
                                                          it_positions = lt_positions ).
    lo_object->release( ).
    try.
        lo_object->get_next_moves( importing et_moves = lt_moves ).
      catch cx_demo_sql_chess into lo_exc.
        if lo_exc->if_t100_message~t100key = cx_demo_sql_chess=>instance_is_released.
          lv_catched = abap_true.
        endif.
    endtry.
    cl_aunit_assert=>assert_equals( act = lv_catched exp = abap_true quit = if_aunit_constants=>no ).
    lo_object = lo_object->factory( iv_uuid = lo_object->gv_gameuuid ).
    lo_object->delete( ).
  endmethod.

  method test_move_released.
    data lt_moves type cl_demo_sql_chess=>gtt_moves.
    data lt_positions type cl_demo_sql_chess=>gtt_positions.
    data lo_object type ref to cl_demo_sql_chess.
    data lo_exc type ref to cx_demo_sql_chess.
    data lv_catched type abap_bool.
    lt_positions = value #(
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king x = 5 y = 8 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king x = 5 y = 1 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_rook x = 8 y = 8 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_pawn x = 8 y = 7 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_rook x = 8 y = 4 )
    ).
    lo_object = cl_demo_sql_chess=>factory_from_position( is_settings  = value #( color = cl_demo_sql_chess=>c_color_black  )
                                                          it_positions = lt_positions ).
    lo_object->release( ).
    try.
        lo_object->move( exporting iv_chessman = cl_demo_sql_chess=>c_chessman_king
                                   iv_color    = cl_demo_sql_chess=>c_color_white
                                   iv_from_x   = 5
                                   iv_from_y   = 1
                                   iv_to_x     = 6
                                   iv_to_y     = 1 ).
      catch cx_demo_sql_chess into lo_exc.
        if lo_exc->if_t100_message~t100key = cx_demo_sql_chess=>instance_is_released.
          lv_catched = abap_true.
        endif.
    endtry.
    cl_aunit_assert=>assert_equals( act = lv_catched exp = abap_true quit = if_aunit_constants=>no ).
    lo_object = lo_object->factory( iv_uuid = lo_object->gv_gameuuid ).
    lo_object->delete( ).
  endmethod.

  method test_move_001.
    data lt_moves type cl_demo_sql_chess=>gtt_moves.
    data lt_positions type cl_demo_sql_chess=>gtt_positions.
    data lo_object type ref to cl_demo_sql_chess.
    data lo_exc type ref to cx_demo_sql_chess.
    data lv_flg_success type abap_bool.
    data lt_pos_expected type sorted table of demo_chess_pos with unique key gameuuid movecnt color chessman x y.
    data lt_pos type sorted table of demo_chess_pos with unique key gameuuid movecnt color chessman x y.

    lt_positions = value #(
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king x = 5 y = 8 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king x = 5 y = 1 )
    ).
    lo_object = cl_demo_sql_chess=>factory_from_position( is_settings  = value #( color = cl_demo_sql_chess=>c_color_white  )
                                                          it_positions = lt_positions ).
    lv_flg_success = lo_object->move( exporting iv_chessman = cl_demo_sql_chess=>c_chessman_king
                                                iv_color    = cl_demo_sql_chess=>c_color_white
                                                iv_from_x   = 5
                                                iv_from_y   = 1
                                                iv_to_x     = 6
                                                iv_to_y     = 1 ).
    cl_aunit_assert=>assert_equals( act = lv_flg_success exp = abap_true quit = if_aunit_constants=>no ).

    select single * from demo_chess_game
      where gameuuid = @lo_object->gv_gameuuid
      into @data(ls_game).

    cl_aunit_assert=>assert_equals( act = ls_game-movecnt exp = 1 quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_game-color exp = cl_demo_sql_chess=>c_color_black quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_game-castling_black_long exp = abap_false quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_game-castling_black_short exp = abap_false quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_game-castling_white_long exp = abap_true quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_game-castling_white_short exp = abap_true quit = if_aunit_constants=>no ).

    lv_flg_success = lo_object->move( exporting iv_chessman = cl_demo_sql_chess=>c_chessman_king
                                                iv_color    = cl_demo_sql_chess=>c_color_black
                                                iv_from_x   = 5
                                                iv_from_y   = 8
                                                iv_to_x     = 6
                                                iv_to_y     = 8 ).
    cl_aunit_assert=>assert_equals( act = lv_flg_success exp = abap_true quit = if_aunit_constants=>no ).

    select single * from demo_chess_game
      where gameuuid = @lo_object->gv_gameuuid
      into @ls_game.

    cl_aunit_assert=>assert_equals( act = ls_game-movecnt exp = 2 quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_game-color exp = cl_demo_sql_chess=>c_color_white quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_game-castling_black_long exp = abap_true quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_game-castling_black_short exp = abap_true quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_game-castling_white_long exp = abap_true quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_game-castling_white_short exp = abap_true quit = if_aunit_constants=>no ).

    lo_object->release( ).
    lo_object = lo_object->factory( iv_uuid = lo_object->gv_gameuuid ).

    lv_flg_success = lo_object->move( exporting iv_chessman = cl_demo_sql_chess=>c_chessman_king
                                                iv_color    = cl_demo_sql_chess=>c_color_white
                                                iv_from_x   = 6
                                                iv_from_y   = 1
                                                iv_to_x     = 7
                                                iv_to_y     = 1 ).
    cl_aunit_assert=>assert_equals( act = lv_flg_success exp = abap_true quit = if_aunit_constants=>no ).

    select single * from demo_chess_game
      where gameuuid = @lo_object->gv_gameuuid
      into @ls_game.

    cl_aunit_assert=>assert_equals( act = ls_game-movecnt exp = 3 quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_game-color exp = cl_demo_sql_chess=>c_color_black quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_game-castling_black_long exp = abap_true quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_game-castling_black_short exp = abap_true quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_game-castling_white_long exp = abap_true quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_game-castling_white_short exp = abap_true quit = if_aunit_constants=>no ).

    lt_pos_expected = value #( ( client = sy-mandt gameuuid = ls_game-gameuuid movecnt = 3 chessman = cl_demo_sql_chess=>c_chessman_king color = cl_demo_sql_chess=>c_color_black x = 6 y = 8
                                 before_x = 6 before_y = 8 )
                               ( client = sy-mandt gameuuid = ls_game-gameuuid movecnt = 3 chessman = cl_demo_sql_chess=>c_chessman_king color = cl_demo_sql_chess=>c_color_white x = 7 y = 1
                                 before_x = 6 before_y = 1 )
                               ( client = sy-mandt gameuuid = ls_game-gameuuid movecnt = 2 chessman = cl_demo_sql_chess=>c_chessman_king color = cl_demo_sql_chess=>c_color_black x = 6 y = 8
                                 before_x = 5 before_y = 8 )
                               ( client = sy-mandt gameuuid = ls_game-gameuuid movecnt = 2 chessman = cl_demo_sql_chess=>c_chessman_king color = cl_demo_sql_chess=>c_color_white x = 6 y = 1
                                 before_x = 6 before_y = 1 )
                               ( client = sy-mandt gameuuid = ls_game-gameuuid movecnt = 1 chessman = cl_demo_sql_chess=>c_chessman_king color = cl_demo_sql_chess=>c_color_black x = 5 y = 8
                                 before_x = 5 before_y = 8 )
                               ( client = sy-mandt gameuuid = ls_game-gameuuid movecnt = 1 chessman = cl_demo_sql_chess=>c_chessman_king color = cl_demo_sql_chess=>c_color_white x = 6 y = 1
                                 before_x = 5 before_y = 1 )
                               ( client = sy-mandt gameuuid = ls_game-gameuuid movecnt = 0 chessman = cl_demo_sql_chess=>c_chessman_king color = cl_demo_sql_chess=>c_color_black x = 5 y = 8
                                 before_x = 5 before_y = 8 )
                               ( client = sy-mandt gameuuid = ls_game-gameuuid movecnt = 0 chessman = cl_demo_sql_chess=>c_chessman_king color = cl_demo_sql_chess=>c_color_white x = 5 y = 1
                                 before_x = 5 before_y = 1 )
                             ).

    select * from demo_chess_pos
      where gameuuid = @lo_object->gv_gameuuid
      into table @lt_pos.

    cl_aunit_assert=>assert_equals( act = lt_pos exp = lt_pos_expected quit = if_aunit_constants=>no ).

    lo_object->delete( ).
  endmethod.

  method test_move_fail.
    data lt_moves type cl_demo_sql_chess=>gtt_moves.
    data lt_positions type cl_demo_sql_chess=>gtt_positions.
    data lo_object type ref to cl_demo_sql_chess.
    data lo_exc type ref to cx_demo_sql_chess.
    data lv_flg_success type abap_bool.
    data lt_pos_expected type sorted table of demo_chess_pos with unique key gameuuid movecnt color chessman x y.
    data lt_pos type sorted table of demo_chess_pos with unique key gameuuid movecnt color chessman x y.

    lt_positions = value #(
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king x = 5 y = 8 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king x = 5 y = 1 )
    ).

    lo_object = cl_demo_sql_chess=>factory_from_position( is_settings  = value #( color = cl_demo_sql_chess=>c_color_white  )
                                                          it_positions = lt_positions ).
    lv_flg_success = lo_object->move( exporting iv_chessman = cl_demo_sql_chess=>c_chessman_king
                                                iv_color    = cl_demo_sql_chess=>c_color_black
                                                iv_from_x   = 5
                                                iv_from_y   = 8
                                                iv_to_x     = 6
                                                iv_to_y     = 8 ).
    cl_aunit_assert=>assert_equals( act = lv_flg_success exp = abap_false quit = if_aunit_constants=>no ).

    select single * from demo_chess_game
      where gameuuid = @lo_object->gv_gameuuid
      into @data(ls_game).

    cl_aunit_assert=>assert_equals( act = ls_game-movecnt exp = 0 quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_game-color exp = cl_demo_sql_chess=>c_color_white quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_game-castling_black_long exp = abap_false quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_game-castling_black_short exp = abap_false quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_game-castling_white_long exp = abap_false quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_game-castling_white_short exp = abap_false quit = if_aunit_constants=>no ).

    lt_pos_expected = value #( ( client = sy-mandt gameuuid = ls_game-gameuuid movecnt = 0 chessman = cl_demo_sql_chess=>c_chessman_king color = cl_demo_sql_chess=>c_color_black x = 5 y = 8
                                 before_x = 5 before_y = 8 )
                               ( client = sy-mandt gameuuid = ls_game-gameuuid movecnt = 0 chessman = cl_demo_sql_chess=>c_chessman_king color = cl_demo_sql_chess=>c_color_white x = 5 y = 1
                                 before_x = 5 before_y = 1 )
                             ).

    select * from demo_chess_pos
      where gameuuid = @lo_object->gv_gameuuid
      into table @lt_pos.

    cl_aunit_assert=>assert_equals( act = lt_pos exp = lt_pos_expected quit = if_aunit_constants=>no ).

    lo_object->delete( ).
  endmethod.

  method test_move_002.
    data lt_moves type cl_demo_sql_chess=>gtt_moves.
    data lt_positions type cl_demo_sql_chess=>gtt_positions.
    data lo_object type ref to cl_demo_sql_chess.
    data lo_exc type ref to cx_demo_sql_chess.
    data lv_flg_success type abap_bool.
    data lt_pos_expected type sorted table of demo_chess_pos with unique key gameuuid movecnt color chessman x y.
    data lt_pos type sorted table of demo_chess_pos with unique key gameuuid movecnt color chessman x y.

    lt_positions = value #(
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king x = 5 y = 8 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king x = 5 y = 1 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_rook x = 1 y = 1 )
    ).
    lo_object = cl_demo_sql_chess=>factory_from_position( is_settings  = value #( color = cl_demo_sql_chess=>c_color_white  )
                                                          it_positions = lt_positions ).
    lv_flg_success = lo_object->move( exporting iv_chessman = cl_demo_sql_chess=>c_chessman_rook
                                                iv_color    = cl_demo_sql_chess=>c_color_white
                                                iv_from_x   = 1
                                                iv_from_y   = 1
                                                iv_to_x     = 1
                                                iv_to_y     = 2 ).
    cl_aunit_assert=>assert_equals( act = lv_flg_success exp = abap_true quit = if_aunit_constants=>no ).

    select single * from demo_chess_game
      where gameuuid = @lo_object->gv_gameuuid
      into @data(ls_game).

    cl_aunit_assert=>assert_equals( act = ls_game-movecnt exp = 1 quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_game-color exp = cl_demo_sql_chess=>c_color_black quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_game-castling_black_long exp = abap_false quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_game-castling_black_short exp = abap_false quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_game-castling_white_long exp = abap_true quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_game-castling_white_short exp = abap_false quit = if_aunit_constants=>no ).

    lo_object->delete( ).
  endmethod.

  method test_move_003.
    data lt_moves type cl_demo_sql_chess=>gtt_moves.
    data lt_positions type cl_demo_sql_chess=>gtt_positions.
    data lo_object type ref to cl_demo_sql_chess.
    data lo_exc type ref to cx_demo_sql_chess.
    data lv_flg_success type abap_bool.
    data lt_pos_expected type sorted table of demo_chess_pos with unique key gameuuid movecnt color chessman x y.
    data lt_pos type sorted table of demo_chess_pos with unique key gameuuid movecnt color chessman x y.

    lt_positions = value #(
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king x = 5 y = 8 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king x = 5 y = 1 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_rook x = 8 y = 1 )
    ).
    lo_object = cl_demo_sql_chess=>factory_from_position( is_settings  = value #( color = cl_demo_sql_chess=>c_color_white  )
                                                          it_positions = lt_positions ).
    lv_flg_success = lo_object->move( exporting iv_chessman = cl_demo_sql_chess=>c_chessman_rook
                                                iv_color    = cl_demo_sql_chess=>c_color_white
                                                iv_from_x   = 8
                                                iv_from_y   = 1
                                                iv_to_x     = 8
                                                iv_to_y     = 2 ).
    cl_aunit_assert=>assert_equals( act = lv_flg_success exp = abap_true quit = if_aunit_constants=>no ).

    select single * from demo_chess_game
      where gameuuid = @lo_object->gv_gameuuid
      into @data(ls_game).

    cl_aunit_assert=>assert_equals( act = ls_game-movecnt exp = 1 quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_game-color exp = cl_demo_sql_chess=>c_color_black quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_game-castling_black_long exp = abap_false quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_game-castling_black_short exp = abap_false quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_game-castling_white_long exp = abap_false quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_game-castling_white_short exp = abap_true quit = if_aunit_constants=>no ).

    lo_object->delete( ).
  endmethod.

  method test_move_004.
    data lt_moves type cl_demo_sql_chess=>gtt_moves.
    data lt_positions type cl_demo_sql_chess=>gtt_positions.
    data lo_object type ref to cl_demo_sql_chess.
    data lo_exc type ref to cx_demo_sql_chess.
    data lv_flg_success type abap_bool.
    data lt_pos_expected type sorted table of demo_chess_pos with unique key gameuuid movecnt color chessman x y.
    data lt_pos type sorted table of demo_chess_pos with unique key gameuuid movecnt color chessman x y.

    lt_positions = value #(
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king x = 5 y = 8 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king x = 5 y = 1 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_rook x = 1 y = 8 )
    ).
    lo_object = cl_demo_sql_chess=>factory_from_position( is_settings  = value #( color = cl_demo_sql_chess=>c_color_black  )
                                                          it_positions = lt_positions ).
    lv_flg_success = lo_object->move( exporting iv_chessman = cl_demo_sql_chess=>c_chessman_rook
                                                iv_color    = cl_demo_sql_chess=>c_color_black
                                                iv_from_x   = 1
                                                iv_from_y   = 8
                                                iv_to_x     = 2
                                                iv_to_y     = 8 ).
    cl_aunit_assert=>assert_equals( act = lv_flg_success exp = abap_true quit = if_aunit_constants=>no ).

    select single * from demo_chess_game
      where gameuuid = @lo_object->gv_gameuuid
      into @data(ls_game).

    cl_aunit_assert=>assert_equals( act = ls_game-movecnt exp = 1 quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_game-color exp = cl_demo_sql_chess=>c_color_white quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_game-castling_black_long exp = abap_true quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_game-castling_black_short exp = abap_false quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_game-castling_white_long exp = abap_false quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_game-castling_white_short exp = abap_false quit = if_aunit_constants=>no ).

    lo_object->delete( ).
  endmethod.

  method test_move_005.
    data lt_moves type cl_demo_sql_chess=>gtt_moves.
    data lt_positions type cl_demo_sql_chess=>gtt_positions.
    data lo_object type ref to cl_demo_sql_chess.
    data lo_exc type ref to cx_demo_sql_chess.
    data lv_flg_success type abap_bool.
    data lt_pos_expected type sorted table of demo_chess_pos with unique key gameuuid movecnt color chessman x y.
    data lt_pos type sorted table of demo_chess_pos with unique key gameuuid movecnt color chessman x y.

    lt_positions = value #(
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king x = 5 y = 8 )
      ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king x = 5 y = 1 )
      ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_rook x = 8 y = 8 )
    ).
    lo_object = cl_demo_sql_chess=>factory_from_position( is_settings  = value #( color = cl_demo_sql_chess=>c_color_black  )
                                                          it_positions = lt_positions ).
    lv_flg_success = lo_object->move( exporting iv_chessman = cl_demo_sql_chess=>c_chessman_rook
                                                iv_color    = cl_demo_sql_chess=>c_color_black
                                                iv_from_x   = 8
                                                iv_from_y   = 8
                                                iv_to_x     = 7
                                                iv_to_y     = 8 ).
    cl_aunit_assert=>assert_equals( act = lv_flg_success exp = abap_true quit = if_aunit_constants=>no ).

    select single * from demo_chess_game
      where gameuuid = @lo_object->gv_gameuuid
      into @data(ls_game).

    cl_aunit_assert=>assert_equals( act = ls_game-movecnt exp = 1 quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_game-color exp = cl_demo_sql_chess=>c_color_white quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_game-castling_black_long exp = abap_false quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_game-castling_black_short exp = abap_true quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_game-castling_white_long exp = abap_false quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_game-castling_white_short exp = abap_false quit = if_aunit_constants=>no ).

    lo_object->delete( ).
  endmethod.

  method test_move_006.
    data lt_moves type cl_demo_sql_chess=>gtt_moves.
    data lt_positions type cl_demo_sql_chess=>gtt_positions.
    data lo_object type ref to cl_demo_sql_chess.
    data lo_exc type ref to cx_demo_sql_chess.
    data lv_flg_success type abap_bool.
    data lt_pos_expected type sorted table of demo_chess_pos with unique key gameuuid movecnt color chessman x y.
    data lt_pos type sorted table of demo_chess_pos with unique key gameuuid movecnt color chessman x y.

    lt_positions = value #(
     ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king x = 5 y = 8 )
     ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king x = 5 y = 1 )
     ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_rook x = 8 y = 8 )
     ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_rook x = 1 y = 8 )
   ).
    lo_object = cl_demo_sql_chess=>factory_from_position( is_settings  = value #( color = cl_demo_sql_chess=>c_color_black  )
                                                          it_positions = lt_positions ).

    lv_flg_success = lo_object->move( exporting iv_chessman = cl_demo_sql_chess=>c_chessman_rook
                                                iv_color    = cl_demo_sql_chess=>c_color_black
                                                iv_from_x   = 8
                                                iv_from_y   = 8
                                                iv_to_x     = 7
                                                iv_to_y     = 8 ).
    cl_aunit_assert=>assert_equals( act = lv_flg_success exp = abap_true quit = if_aunit_constants=>no ).

    lv_flg_success = lo_object->move( exporting iv_chessman = cl_demo_sql_chess=>c_chessman_king
                                                iv_color    = cl_demo_sql_chess=>c_color_white
                                                iv_from_x   = 5
                                                iv_from_y   = 1
                                                iv_to_x     = 6
                                                iv_to_y     = 1 ).
    cl_aunit_assert=>assert_equals( act = lv_flg_success exp = abap_true quit = if_aunit_constants=>no ).

    lv_flg_success = lo_object->move( exporting iv_chessman = cl_demo_sql_chess=>c_chessman_rook
                                                iv_color    = cl_demo_sql_chess=>c_color_black
                                                iv_from_x   = 7
                                                iv_from_y   = 8
                                                iv_to_x     = 8
                                                iv_to_y     = 8 ).
    cl_aunit_assert=>assert_equals( act = lv_flg_success exp = abap_true quit = if_aunit_constants=>no ).

    lv_flg_success = lo_object->move( exporting iv_chessman = cl_demo_sql_chess=>c_chessman_king
                                                iv_color    = cl_demo_sql_chess=>c_color_white
                                                iv_from_x   = 6
                                                iv_from_y   = 1
                                                iv_to_x     = 5
                                                iv_to_y     = 1 ).
    cl_aunit_assert=>assert_equals( act = lv_flg_success exp = abap_true quit = if_aunit_constants=>no ).

    " no castling possible anymore in this direction!
    lv_flg_success = lo_object->move( exporting iv_chessman = cl_demo_sql_chess=>c_chessman_king
                                                iv_color    = cl_demo_sql_chess=>c_color_black
                                                iv_from_x   = 5
                                                iv_from_y   = 8
                                                iv_to_x     = 7
                                                iv_to_y     = 8 ).
    cl_aunit_assert=>assert_equals( act = lv_flg_success exp = abap_false quit = if_aunit_constants=>no ).

    " castling in other direction possible
    lv_flg_success = lo_object->move( exporting iv_chessman = cl_demo_sql_chess=>c_chessman_king
                                                iv_color    = cl_demo_sql_chess=>c_color_black
                                                iv_from_x   = 5
                                                iv_from_y   = 8
                                                iv_to_x     = 3
                                                iv_to_y     = 8 ).
    cl_aunit_assert=>assert_equals( act = lv_flg_success exp = abap_true quit = if_aunit_constants=>no ).

    lo_object->delete( ).
  endmethod.

  method test_move_007.
    data lt_moves type cl_demo_sql_chess=>gtt_moves.
    data lt_positions type cl_demo_sql_chess=>gtt_positions.
    data lo_object type ref to cl_demo_sql_chess.
    data lo_exc type ref to cx_demo_sql_chess.
    data lv_flg_success type abap_bool.
    data lt_pos_expected type sorted table of demo_chess_pos with unique key gameuuid movecnt color chessman x y.
    data lt_pos type sorted table of demo_chess_pos with unique key gameuuid movecnt color chessman x y.

    lt_positions = value #(
     ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king x = 5 y = 8 )
     ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king x = 5 y = 1 )
     ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_rook x = 8 y = 8 )
     ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_rook x = 1 y = 8 )
   ).
    lo_object = cl_demo_sql_chess=>factory_from_position( is_settings  = value #( color = cl_demo_sql_chess=>c_color_black  )
                                                          it_positions = lt_positions ).

    lv_flg_success = lo_object->move( exporting iv_chessman = cl_demo_sql_chess=>c_chessman_rook
                                                iv_color    = cl_demo_sql_chess=>c_color_black
                                                iv_from_x   = 1
                                                iv_from_y   = 8
                                                iv_to_x     = 2
                                                iv_to_y     = 8 ).
    cl_aunit_assert=>assert_equals( act = lv_flg_success exp = abap_true quit = if_aunit_constants=>no ).

    lv_flg_success = lo_object->move( exporting iv_chessman = cl_demo_sql_chess=>c_chessman_king
                                                iv_color    = cl_demo_sql_chess=>c_color_white
                                                iv_from_x   = 5
                                                iv_from_y   = 1
                                                iv_to_x     = 6
                                                iv_to_y     = 1 ).
    cl_aunit_assert=>assert_equals( act = lv_flg_success exp = abap_true quit = if_aunit_constants=>no ).

    lv_flg_success = lo_object->move( exporting iv_chessman = cl_demo_sql_chess=>c_chessman_rook
                                                iv_color    = cl_demo_sql_chess=>c_color_black
                                                iv_from_x   = 2
                                                iv_from_y   = 8
                                                iv_to_x     = 1
                                                iv_to_y     = 8 ).
    cl_aunit_assert=>assert_equals( act = lv_flg_success exp = abap_true quit = if_aunit_constants=>no ).

    lv_flg_success = lo_object->move( exporting iv_chessman = cl_demo_sql_chess=>c_chessman_king
                                                iv_color    = cl_demo_sql_chess=>c_color_white
                                                iv_from_x   = 6
                                                iv_from_y   = 1
                                                iv_to_x     = 5
                                                iv_to_y     = 1 ).
    cl_aunit_assert=>assert_equals( act = lv_flg_success exp = abap_true quit = if_aunit_constants=>no ).

    " no castling possible anymore in this direction!
    lv_flg_success = lo_object->move( exporting iv_chessman = cl_demo_sql_chess=>c_chessman_king
                                                iv_color    = cl_demo_sql_chess=>c_color_black
                                                iv_from_x   = 5
                                                iv_from_y   = 8
                                                iv_to_x     = 3
                                                iv_to_y     = 8 ).
    cl_aunit_assert=>assert_equals( act = lv_flg_success exp = abap_false quit = if_aunit_constants=>no ).

    " castling in other direction possible
    lv_flg_success = lo_object->move( exporting iv_chessman = cl_demo_sql_chess=>c_chessman_king
                                                iv_color    = cl_demo_sql_chess=>c_color_black
                                                iv_from_x   = 5
                                                iv_from_y   = 8
                                                iv_to_x     = 7
                                                iv_to_y     = 8 ).
    cl_aunit_assert=>assert_equals( act = lv_flg_success exp = abap_true quit = if_aunit_constants=>no ).

    lo_object->delete( ).
  endmethod.

  method test_move_008.
    data lt_moves type cl_demo_sql_chess=>gtt_moves.
    data lt_positions type cl_demo_sql_chess=>gtt_positions.
    data lo_object type ref to cl_demo_sql_chess.
    data lo_exc type ref to cx_demo_sql_chess.
    data lv_flg_success type abap_bool.
    data lt_pos_expected type sorted table of demo_chess_pos with unique key gameuuid movecnt color chessman x y.
    data lt_pos type sorted table of demo_chess_pos with unique key gameuuid movecnt color chessman x y.

    lt_positions = value #(
     ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king x = 5 y = 8 )
     ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king x = 5 y = 1 )
     ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_rook x = 8 y = 1 )
     ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_rook x = 1 y = 1 )
   ).
    lo_object = cl_demo_sql_chess=>factory_from_position( is_settings  = value #( color = cl_demo_sql_chess=>c_color_white  )
                                                          it_positions = lt_positions ).

    lv_flg_success = lo_object->move( exporting iv_chessman = cl_demo_sql_chess=>c_chessman_rook
                                                iv_color    = cl_demo_sql_chess=>c_color_white
                                                iv_from_x   = 1
                                                iv_from_y   = 1
                                                iv_to_x     = 2
                                                iv_to_y     = 1 ).
    cl_aunit_assert=>assert_equals( act = lv_flg_success exp = abap_true quit = if_aunit_constants=>no ).


    lv_flg_success = lo_object->move( exporting iv_chessman = cl_demo_sql_chess=>c_chessman_king
                                                iv_color    = cl_demo_sql_chess=>c_color_black
                                                iv_from_x   = 5
                                                iv_from_y   = 8
                                                iv_to_x     = 6
                                                iv_to_y     = 8 ).
    cl_aunit_assert=>assert_equals( act = lv_flg_success exp = abap_true quit = if_aunit_constants=>no ).

    lv_flg_success = lo_object->move( exporting iv_chessman = cl_demo_sql_chess=>c_chessman_rook
                                                iv_color    = cl_demo_sql_chess=>c_color_white
                                                iv_from_x   = 2
                                                iv_from_y   = 1
                                                iv_to_x     = 1
                                                iv_to_y     = 1 ).
    cl_aunit_assert=>assert_equals( act = lv_flg_success exp = abap_true quit = if_aunit_constants=>no ).

    lv_flg_success = lo_object->move( exporting iv_chessman = cl_demo_sql_chess=>c_chessman_king
                                                iv_color    = cl_demo_sql_chess=>c_color_black
                                                iv_from_x   = 6
                                                iv_from_y   = 8
                                                iv_to_x     = 5
                                                iv_to_y     = 8 ).
    cl_aunit_assert=>assert_equals( act = lv_flg_success exp = abap_true quit = if_aunit_constants=>no ).

    " now is no castling possible in this direction
    lv_flg_success = lo_object->move( exporting iv_chessman = cl_demo_sql_chess=>c_chessman_king
                                                iv_color    = cl_demo_sql_chess=>c_color_white
                                                iv_from_x   = 5
                                                iv_from_y   = 1
                                                iv_to_x     = 3
                                                iv_to_y     = 1 ).
    cl_aunit_assert=>assert_equals( act = lv_flg_success exp = abap_false quit = if_aunit_constants=>no ).

    " other direcrtion possible
    lv_flg_success = lo_object->move( exporting iv_chessman = cl_demo_sql_chess=>c_chessman_king
                                                iv_color    = cl_demo_sql_chess=>c_color_white
                                                iv_from_x   = 5
                                                iv_from_y   = 1
                                                iv_to_x     = 7
                                                iv_to_y     = 1 ).
    cl_aunit_assert=>assert_equals( act = lv_flg_success exp = abap_true quit = if_aunit_constants=>no ).

    lo_object->delete( ).
  endmethod.

  method test_move_009.
    data lt_moves type cl_demo_sql_chess=>gtt_moves.
    data lt_positions type cl_demo_sql_chess=>gtt_positions.
    data lo_object type ref to cl_demo_sql_chess.
    data lo_exc type ref to cx_demo_sql_chess.
    data lv_flg_success type abap_bool.
    data lt_pos_expected type sorted table of demo_chess_pos with unique key gameuuid movecnt color chessman x y.
    data lt_pos type sorted table of demo_chess_pos with unique key gameuuid movecnt color chessman x y.

    lt_positions = value #(
     ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king x = 5 y = 8 )
     ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king x = 5 y = 1 )
     ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_rook x = 8 y = 1 )
     ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_rook x = 1 y = 1 )
   ).
    lo_object = cl_demo_sql_chess=>factory_from_position( is_settings  = value #( color = cl_demo_sql_chess=>c_color_white  )
                                                          it_positions = lt_positions ).

    lv_flg_success = lo_object->move( exporting iv_chessman = cl_demo_sql_chess=>c_chessman_rook
                                                iv_color    = cl_demo_sql_chess=>c_color_white
                                                iv_from_x   = 8
                                                iv_from_y   = 1
                                                iv_to_x     = 7
                                                iv_to_y     = 1 ).
    cl_aunit_assert=>assert_equals( act = lv_flg_success exp = abap_true quit = if_aunit_constants=>no ).


    lv_flg_success = lo_object->move( exporting iv_chessman = cl_demo_sql_chess=>c_chessman_king
                                                iv_color    = cl_demo_sql_chess=>c_color_black
                                                iv_from_x   = 5
                                                iv_from_y   = 8
                                                iv_to_x     = 6
                                                iv_to_y     = 8 ).
    cl_aunit_assert=>assert_equals( act = lv_flg_success exp = abap_true quit = if_aunit_constants=>no ).

    lv_flg_success = lo_object->move( exporting iv_chessman = cl_demo_sql_chess=>c_chessman_rook
                                                iv_color    = cl_demo_sql_chess=>c_color_white
                                                iv_from_x   = 7
                                                iv_from_y   = 1
                                                iv_to_x     = 8
                                                iv_to_y     = 1 ).
    cl_aunit_assert=>assert_equals( act = lv_flg_success exp = abap_true quit = if_aunit_constants=>no ).

    lv_flg_success = lo_object->move( exporting iv_chessman = cl_demo_sql_chess=>c_chessman_king
                                                iv_color    = cl_demo_sql_chess=>c_color_black
                                                iv_from_x   = 6
                                                iv_from_y   = 8
                                                iv_to_x     = 5
                                                iv_to_y     = 8 ).
    cl_aunit_assert=>assert_equals( act = lv_flg_success exp = abap_true quit = if_aunit_constants=>no ).

    " now is no castling possible in this direction
    lv_flg_success = lo_object->move( exporting iv_chessman = cl_demo_sql_chess=>c_chessman_king
                                                iv_color    = cl_demo_sql_chess=>c_color_white
                                                iv_from_x   = 5
                                                iv_from_y   = 1
                                                iv_to_x     = 7
                                                iv_to_y     = 1 ).
    cl_aunit_assert=>assert_equals( act = lv_flg_success exp = abap_false quit = if_aunit_constants=>no ).

    " other direcrtion possible
    lv_flg_success = lo_object->move( exporting iv_chessman = cl_demo_sql_chess=>c_chessman_king
                                                iv_color    = cl_demo_sql_chess=>c_color_white
                                                iv_from_x   = 5
                                                iv_from_y   = 1
                                                iv_to_x     = 3
                                                iv_to_y     = 1 ).
    cl_aunit_assert=>assert_equals( act = lv_flg_success exp = abap_true quit = if_aunit_constants=>no ).

    lt_pos_expected = value #(
                               ( client = sy-mandt gameuuid = lo_object->gv_gameuuid movecnt = 5
         chessman = cl_demo_sql_chess=>c_chessman_king color = cl_demo_sql_chess=>c_color_black x = 5 y = 8
         before_x = 5 before_y = 8 )
       ( client = sy-mandt gameuuid = lo_object->gv_gameuuid movecnt = 5
         chessman = cl_demo_sql_chess=>c_chessman_king color = cl_demo_sql_chess=>c_color_white x = 3 y = 1
         before_x = 5 before_y = 1 )
       ( client = sy-mandt gameuuid = lo_object->gv_gameuuid movecnt = 5
         chessman = cl_demo_sql_chess=>c_chessman_rook color = cl_demo_sql_chess=>c_color_white x = 8 y = 1
         before_x = 8 before_y = 1 )
       ( client = sy-mandt gameuuid = lo_object->gv_gameuuid movecnt = 5
         chessman = cl_demo_sql_chess=>c_chessman_rook color = cl_demo_sql_chess=>c_color_white x = 4 y = 1
         before_x = 1 before_y = 1 )

       ( client = sy-mandt gameuuid = lo_object->gv_gameuuid movecnt = 4
         chessman = cl_demo_sql_chess=>c_chessman_king color = cl_demo_sql_chess=>c_color_black x = 5 y = 8
         before_x = 6 before_y = 8 )
       ( client = sy-mandt gameuuid = lo_object->gv_gameuuid movecnt = 4
         chessman = cl_demo_sql_chess=>c_chessman_king color = cl_demo_sql_chess=>c_color_white x = 5 y = 1
         before_x = 5 before_y = 1 )
       ( client = sy-mandt gameuuid = lo_object->gv_gameuuid movecnt = 4
         chessman = cl_demo_sql_chess=>c_chessman_rook color = cl_demo_sql_chess=>c_color_white x = 8 y = 1
         before_x = 8 before_y = 1 )
       ( client = sy-mandt gameuuid = lo_object->gv_gameuuid movecnt = 4
         chessman = cl_demo_sql_chess=>c_chessman_rook color = cl_demo_sql_chess=>c_color_white x = 1 y = 1
         before_x = 1 before_y = 1 )


       ( client = sy-mandt gameuuid = lo_object->gv_gameuuid movecnt = 3
         chessman = cl_demo_sql_chess=>c_chessman_king color = cl_demo_sql_chess=>c_color_black x = 6 y = 8
         before_x = 6 before_y = 8 )
       ( client = sy-mandt gameuuid = lo_object->gv_gameuuid movecnt = 3
         chessman = cl_demo_sql_chess=>c_chessman_king color = cl_demo_sql_chess=>c_color_white x = 5 y = 1
         before_x = 5 before_y = 1 )
       ( client = sy-mandt gameuuid = lo_object->gv_gameuuid movecnt = 3
         chessman = cl_demo_sql_chess=>c_chessman_rook color = cl_demo_sql_chess=>c_color_white x = 8 y = 1
         before_x = 7 before_y = 1 )
       ( client = sy-mandt gameuuid = lo_object->gv_gameuuid movecnt = 3
         chessman = cl_demo_sql_chess=>c_chessman_rook color = cl_demo_sql_chess=>c_color_white x = 1 y = 1
         before_x = 1 before_y = 1 )


       ( client = sy-mandt gameuuid = lo_object->gv_gameuuid movecnt = 2
         chessman = cl_demo_sql_chess=>c_chessman_king color = cl_demo_sql_chess=>c_color_black x = 6 y = 8
         before_x = 5 before_y = 8 )
       ( client = sy-mandt gameuuid = lo_object->gv_gameuuid movecnt = 2
         chessman = cl_demo_sql_chess=>c_chessman_king color = cl_demo_sql_chess=>c_color_white x = 5 y = 1
         before_x = 5 before_y = 1 )
       ( client = sy-mandt gameuuid = lo_object->gv_gameuuid movecnt = 2
         chessman = cl_demo_sql_chess=>c_chessman_rook color = cl_demo_sql_chess=>c_color_white x = 7 y = 1
         before_x = 7 before_y = 1 )
       ( client = sy-mandt gameuuid = lo_object->gv_gameuuid movecnt = 2
         chessman = cl_demo_sql_chess=>c_chessman_rook color = cl_demo_sql_chess=>c_color_white x = 1 y = 1
         before_x = 1 before_y = 1 )



       ( client = sy-mandt gameuuid = lo_object->gv_gameuuid movecnt = 1
         chessman = cl_demo_sql_chess=>c_chessman_king color = cl_demo_sql_chess=>c_color_black x = 5 y = 8
         before_x = 5 before_y = 8 )
       ( client = sy-mandt gameuuid = lo_object->gv_gameuuid movecnt = 1
         chessman = cl_demo_sql_chess=>c_chessman_king color = cl_demo_sql_chess=>c_color_white x = 5 y = 1
         before_x = 5 before_y = 1 )
       ( client = sy-mandt gameuuid = lo_object->gv_gameuuid movecnt = 1
         chessman = cl_demo_sql_chess=>c_chessman_rook color = cl_demo_sql_chess=>c_color_white x = 7 y = 1
         before_x = 8 before_y = 1 )
       ( client = sy-mandt gameuuid = lo_object->gv_gameuuid movecnt = 1
         chessman = cl_demo_sql_chess=>c_chessman_rook color = cl_demo_sql_chess=>c_color_white x = 1 y = 1
         before_x = 1 before_y = 1 )

       ( client = sy-mandt gameuuid = lo_object->gv_gameuuid movecnt = 0
         chessman = cl_demo_sql_chess=>c_chessman_king color = cl_demo_sql_chess=>c_color_black x = 5 y = 8
         before_x = 5 before_y = 8 )
       ( client = sy-mandt gameuuid = lo_object->gv_gameuuid movecnt = 0
         chessman = cl_demo_sql_chess=>c_chessman_king color = cl_demo_sql_chess=>c_color_white x = 5 y = 1
         before_x = 5 before_y = 1 )
       ( client = sy-mandt gameuuid = lo_object->gv_gameuuid movecnt = 0
         chessman = cl_demo_sql_chess=>c_chessman_rook color = cl_demo_sql_chess=>c_color_white x = 8 y = 1
         before_x = 8 before_y = 1 )
       ( client = sy-mandt gameuuid = lo_object->gv_gameuuid movecnt = 0
         chessman = cl_demo_sql_chess=>c_chessman_rook color = cl_demo_sql_chess=>c_color_white x = 1 y = 1
         before_x = 1 before_y = 1 )
     ).

    select * from demo_chess_pos
      where gameuuid = @lo_object->gv_gameuuid
      into table @lt_pos.

    cl_aunit_assert=>assert_equals( act = lt_pos exp = lt_pos_expected quit = if_aunit_constants=>no ).

    select single * from demo_chess_game
      where gameuuid = @lo_object->gv_gameuuid
      into @data(ls_game).

    cl_aunit_assert=>assert_equals( act = ls_game-movecnt exp = 5 quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_game-color exp = cl_demo_sql_chess=>c_color_black quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_game-castling_black_long exp = abap_true quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_game-castling_black_short exp = abap_true quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_game-castling_white_long exp = abap_true quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = ls_game-castling_white_short exp = abap_true quit = if_aunit_constants=>no ).

    lo_object->delete( ).
  endmethod.

  method test_resume_001.
    data lt_moves type cl_demo_sql_chess=>gtt_moves.
    data lt_positions type cl_demo_sql_chess=>gtt_positions.
    data lo_object type ref to cl_demo_sql_chess.
    data lo_exc type ref to cx_demo_sql_chess.
    data lv_flg_success type abap_bool.
    data lt_pos_expected type sorted table of demo_chess_pos with unique key gameuuid movecnt color chessman x y.
    data lt_pos type sorted table of demo_chess_pos with unique key gameuuid movecnt color chessman x y.

    lt_positions = value #(
 ( color = cl_demo_sql_chess=>c_color_black chessman = cl_demo_sql_chess=>c_chessman_king x = 5 y = 8 )
 ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_king x = 5 y = 1 )
 ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_rook x = 8 y = 1 )
 ( color = cl_demo_sql_chess=>c_color_white chessman = cl_demo_sql_chess=>c_chessman_rook x = 1 y = 1 )
).
    lo_object = cl_demo_sql_chess=>factory_from_position( is_settings  = value #( color = cl_demo_sql_chess=>c_color_white  )
                                                          it_positions = lt_positions ).

    lv_flg_success = lo_object->move( exporting iv_chessman = cl_demo_sql_chess=>c_chessman_rook
                                                iv_color    = cl_demo_sql_chess=>c_color_white
                                                iv_from_x   = 1
                                                iv_from_y   = 1
                                                iv_to_x     = 2
                                                iv_to_y     = 1 ).
    cl_aunit_assert=>assert_equals( act = lv_flg_success exp = abap_true quit = if_aunit_constants=>no ).

    lo_object->release( ).
    lo_object->resume( ).

    lv_flg_success = lo_object->move( exporting iv_chessman = cl_demo_sql_chess=>c_chessman_king
                                                iv_color    = cl_demo_sql_chess=>c_color_black
                                                iv_from_x   = 5
                                                iv_from_y   = 8
                                                iv_to_x     = 6
                                                iv_to_y     = 8 ).
    cl_aunit_assert=>assert_equals( act = lv_flg_success exp = abap_true quit = if_aunit_constants=>no ).

    lo_object->release( ).
    lo_object->resume( ).

    lv_flg_success = lo_object->move( exporting iv_chessman = cl_demo_sql_chess=>c_chessman_rook
                                                iv_color    = cl_demo_sql_chess=>c_color_white
                                                iv_from_x   = 2
                                                iv_from_y   = 1
                                                iv_to_x     = 1
                                                iv_to_y     = 1 ).
    cl_aunit_assert=>assert_equals( act = lv_flg_success exp = abap_true quit = if_aunit_constants=>no ).

    lo_object->release( ).
    lo_object->resume( ).

    lv_flg_success = lo_object->move( exporting iv_chessman = cl_demo_sql_chess=>c_chessman_king
                                                iv_color    = cl_demo_sql_chess=>c_color_black
                                                iv_from_x   = 6
                                                iv_from_y   = 8
                                                iv_to_x     = 5
                                                iv_to_y     = 8 ).
    cl_aunit_assert=>assert_equals( act = lv_flg_success exp = abap_true quit = if_aunit_constants=>no ).

    lo_object->release( ).
    lo_object->resume( ).

    " now is no castling possible in this direction
    lv_flg_success = lo_object->move( exporting iv_chessman = cl_demo_sql_chess=>c_chessman_king
                                                iv_color    = cl_demo_sql_chess=>c_color_white
                                                iv_from_x   = 5
                                                iv_from_y   = 1
                                                iv_to_x     = 3
                                                iv_to_y     = 1 ).
    cl_aunit_assert=>assert_equals( act = lv_flg_success exp = abap_false quit = if_aunit_constants=>no ).

    lo_object->release( ).
    lo_object->resume( ).

    " other direcrtion possible
    lv_flg_success = lo_object->move( exporting iv_chessman = cl_demo_sql_chess=>c_chessman_king
                                                iv_color    = cl_demo_sql_chess=>c_color_white
                                                iv_from_x   = 5
                                                iv_from_y   = 1
                                                iv_to_x     = 7
                                                iv_to_y     = 1 ).
    cl_aunit_assert=>assert_equals( act = lv_flg_success exp = abap_true quit = if_aunit_constants=>no ).

    lo_object->delete( ).
  endmethod.

  method test_resume_002.
    data lo_object type ref to cl_demo_sql_chess.
    lo_object = cl_demo_sql_chess=>factory( ).
    lo_object->release( ).
    lock_moves( ).
    delete from demo_chess_moves where 1 = 1.
    unlock_moves( ).
    lo_object->resume( ).
    lo_object->delete( ).
    select * from demo_chess_moves
      into table @data(lt_moves).
    cl_aunit_assert=>assert_subrc( act = sy-subrc quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = sy-dbcnt exp = 7620 quit = if_aunit_constants=>no ).
    cl_aunit_assert=>assert_equals( act = lines( lt_moves ) exp = 7620 quit = if_aunit_constants=>no ).
  endmethod.

  method test_resume_003.
    data lo_object type ref to cl_demo_sql_chess.
    data lo_exc type ref to cx_demo_sql_chess.
    data lo_uuid type ref to lcl_system_uuid_mock2.
    data lv_catched type abap_bool.

    lo_object = cl_demo_sql_chess=>factory( ).
    lo_object->release( ).

    delete from demo_chess_game where gameuuid = lo_object->gv_gameuuid.
    delete from demo_chess_pos where  gameuuid = lo_object->gv_gameuuid.

    try.
        lo_object->resume( ).
      catch cx_demo_sql_chess into lo_exc.
        if lo_exc->if_t100_message~t100key = cx_demo_sql_chess=>game_not_found.
          lv_catched = abap_true.
        endif.
    endtry.
    cl_aunit_assert=>assert_equals( act = lv_catched exp = abap_true quit = if_aunit_constants=>no ).

    lo_uuid = new #( lo_object->gv_gameuuid ).
    lo_object = cl_demo_sql_chess=>factory( io_uuid_factory = lo_uuid ).
    lo_object->delete( ).
  endmethod.

  method test_resume_004.
    data lo_object type ref to cl_demo_sql_chess.
    data lo_exc type ref to cx_demo_sql_chess.
    data lv_catched type abap_bool.

    lo_object = cl_demo_sql_chess=>factory( ).
    lo_object->release( ).

    delete from demo_chess_pos where  gameuuid = lo_object->gv_gameuuid and
                                      color = cl_demo_sql_chess=>c_color_black and
                                      chessman = cl_demo_sql_chess=>c_chessman_king.
    try.
        lo_object->resume( ).
      catch cx_demo_sql_chess into lo_exc.
        if lo_exc->if_t100_message~t100key = cx_demo_sql_chess=>invalid_chess_position.
          lv_catched = abap_true.
        endif.
    endtry.
    cl_aunit_assert=>assert_equals( act = lv_catched exp = abap_true quit = if_aunit_constants=>no ).

    delete from demo_chess_game where gameuuid = lo_object->gv_gameuuid.
    delete from demo_chess_pos where  gameuuid = lo_object->gv_gameuuid.
  endmethod.

  method test_resume_005.
    data lo_object type ref to cl_demo_sql_chess.
    data lo_exc type ref to cx_demo_sql_chess.
    data lv_catched type abap_bool.
    lo_object = cl_demo_sql_chess=>factory( ).
    lo_object->resume( ).
    lo_object->delete( ).
    check_game_does_not_exist( iv_gameuuid = lo_object->gv_gameuuid ).
  endmethod.

  method test_raise.
    data lo_object type ref to cl_demo_sql_chess.
    data lo_exc type ref to cx_demo_sql_chess.
    data lv_catched type abap_bool.
    lo_object = cl_demo_sql_chess=>factory( ).
    lo_object->raise( is_t100key = cx_demo_sql_chess=>game_not_found iv_flg_rollback = abap_true iv_flg_raise = abap_false ).
    check_game_does_not_exist( iv_gameuuid = lo_object->gv_gameuuid ).
  endmethod.

endclass.
