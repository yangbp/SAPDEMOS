-- this is the equalivalent of stage1 on top of stage7
-- it is used to determine if after a move the king is in chess, i.e. the king could be 
-- taken in the next move by the opponent.
-- contrary to stage1, only the moves of the _oponent_ are taken into account 
-- and we restrict the view also to the moves which affect the final position of the king
@AbapCatalog.sqlViewName: 'demo_chess_sst8'
@AbapCatalog.compiler.compareFilter: true
@EndUserText.label: 'Principally allowed movements'
define view Demo_Chess_V_Stage8 as select from
  ( demo_chess_game as game inner join
    Demo_Chess_V_Stage7 as source on game.gameuuid = source.gameuuid ) 
  inner join Demo_Chess_V_Stage7 as kings_pos on kings_pos.gameuuid      = source.gameuuid and 
                                                kings_pos.movecnt       = source.movecnt   and
                                               kings_pos.move_color    = source.move_color and
                                               kings_pos.move_chessman = source.move_chessman and
                                               kings_pos.move_from_x   = source.move_from_x and
                                               kings_pos.move_from_y   = source.move_from_y and
                                               kings_pos.move_to_x     = source.move_to_x and
                                               kings_pos.move_to_y     = source.move_to_y and
                                               kings_pos.color         = source.move_color and
                                               kings_pos.chessman      = 'K'
  inner join Demo_Chess_V_Moves_Cds as moves
    on source.color    = moves.color    and
       source.chessman = moves.chessman and
       source.x        = moves.from_x   and 
       source.y        = moves.from_y  
  left outer join Demo_Chess_V_Stage7 as target_field on target_field.gameuuid      = source.gameuuid and
                                                         target_field.movecnt       = source.movecnt and
                                                         target_field.move_color    = source.move_color and
                                                         target_field.move_chessman = source.move_chessman and
                                                         target_field.move_from_x   = source.move_from_x and
                                                         target_field.move_from_y   = source.move_from_y and
                                                         target_field.move_to_x     = source.move_to_x and
                                                         target_field.move_to_y     = source.move_to_y and
                                                         target_field.x             = moves.to_x and
                                                         target_field.y             = moves.to_y
  left outer join Demo_Chess_V_Stage7 as last_move    on last_move.gameuuid      = source.gameuuid and 
                                                         last_move.movecnt       = source.movecnt   and 
                                                         last_move.move_color    = source.move_color and
                                                         last_move.move_chessman = source.move_chessman and
                                                         last_move.move_from_x   = source.move_from_x and
                                                         last_move.move_from_y   = source.move_from_y and
                                                         last_move.move_to_x     = source.move_to_x and
                                                         last_move.move_to_y     = source.move_to_y and
                                                         last_move.moved_flag    = 'X' 
                                                        
{
  key source.gameuuid,
  key source.movecnt,
  key source.move_color,
  key source.move_chessman,
  key source.move_from_x,
  key source.move_from_y,
  key source.move_to_x,
  key source.move_to_y,
  key source.color, 
  key source.chessman, 
  key source.x as from_x, 
  key source.y as from_y, 
  key moves.to_x, 
  key moves.to_y, 
  moves.special_flag, 
  moves.color_dep, 
  moves.chessman_dep, 
  moves.from_x_dep, 
  moves.from_y_dep, 
  moves.to_x_dep, 
  moves.to_y_dep, 
  moves.transform_pawn_flag,
  case when source.castling_black_long = #SAP_BOOL.'X' then 'X'
       when source.color = #DEMO_CHESS_COLOR.'B' and 
            source.chessman = #DEMO_CHESS_CHESSMAN.'K' then 'X'
       when source.color = #DEMO_CHESS_COLOR.'B' and 
            source.chessman = #DEMO_CHESS_CHESSMAN.'R' and
            source.x  = 1 and 
            source.y  = 8 then 'X'
       else ' '
  end as castling_black_long,
  case when source.castling_black_short = #SAP_BOOL.'X' then 'X'
       when source.color = #DEMO_CHESS_COLOR.'B' and 
            source.chessman = #DEMO_CHESS_CHESSMAN.'K' then 'X'
       when source.color = #DEMO_CHESS_COLOR.'B' and 
            source.chessman = #DEMO_CHESS_CHESSMAN.'R' and
            source.x  = 8 and 
            source.y  = 8 then 'X'
       else ' '
  end as castling_black_short,
  case when source.castling_white_long = #SAP_BOOL.'X' then 'X'
       when source.color = #DEMO_CHESS_COLOR.'W' and 
            source.chessman = #DEMO_CHESS_CHESSMAN.'K' then 'X'
       when source.color = #DEMO_CHESS_COLOR.'W' and 
            source.chessman = #DEMO_CHESS_CHESSMAN.'R' and
            source.x  = 1 and 
            source.y  = 1 then 'X'
       else ' '
  end as castling_white_long,
  case when source.castling_white_short = #SAP_BOOL.'X' then 'X'
       when source.color = #DEMO_CHESS_COLOR.'W' and 
            source.chessman = #DEMO_CHESS_CHESSMAN.'K' then 'X'
       when source.color = #DEMO_CHESS_COLOR.'W' and 
            source.chessman = #DEMO_CHESS_CHESSMAN.'R' and
            source.x  = 8 and 
            source.y  = 1 then 'X'
       else ' '
  end as castling_white_short,
  last_move.chessman as last_chessman,
  last_move.color as last_color,    
  last_move.before_x as last_from_x,
  last_move.before_y as last_from_y,
  last_move.x as last_to_x,       
  last_move.y as last_to_y        
}
  where
  -- only opponents color:
    ( ( source.color = #DEMO_CHESS_COLOR.'B' and game.color = #DEMO_CHESS_COLOR.'W') or 
    ( source.color = #DEMO_CHESS_COLOR.'W' and game.color = #DEMO_CHESS_COLOR.'B') ) and 
    ( target_field.color is null or target_field.color <> source.color ) and   -- on the target field, there should be no chessman of the same color
    -- the following three lines are there to rule out castling at the moment, this is handled separately
    -- to speed up the processing, we use not <> 'C' but equality for the other enumeration values
    ( moves.special_flag = #DEMO_CHESS_SPECIAL_FLAG.' ' or 
      moves.special_flag = #DEMO_CHESS_SPECIAL_FLAG.'P' or 
      moves.special_flag = #DEMO_CHESS_SPECIAL_FLAG.'E' ) and
    ( -- move generation rules for pawns
      moves.special_flag <> #DEMO_CHESS_SPECIAL_FLAG.'P' or
      target_field.color is not null                     or -- may only move diagonal, if there is some chessman in the target
      -- en passant rules      
      (
        last_move.chessman = moves.chessman_dep and 
        last_move.color    = moves.color_dep    and
        last_move.before_x = moves.from_x_dep   and
        last_move.before_y = moves.from_y_dep   and
        last_move.x        = moves.to_x_dep     and
        last_move.y        = moves.to_y_dep
      )          
    )
    and      
  ( -- pawn may only move straight, if the field is empty
    moves.special_flag <> #DEMO_CHESS_SPECIAL_FLAG.'E' or
    target_field.color is null 
  ) and
 -- enemy king must be taken: 
     ( ( moves.to_x     = kings_pos.x    and
          moves.to_y     = kings_pos.y ) or
        ( source.is_castling_black_long = #SAP_BOOL.'X' and
          moves.to_y = 8 and 
          ( moves.to_x = 4 or moves.to_x = 5 ) 
        ) or 
        ( source.is_castling_white_long = #SAP_BOOL.'X' and
          moves.to_y = 1 and 
          ( moves.to_x = 4 or moves.to_x = 5 ) 
        ) or
        ( source.is_castling_black_short = #SAP_BOOL.'X' and
          moves.to_y = 8 and 
          ( moves.to_x = 5 or moves.to_x = 6 ) 
        ) or
        ( source.is_castling_white_short = #SAP_BOOL.'X' and
          moves.to_y = 1 and 
          ( moves.to_x = 5 or moves.to_x = 6 ) 
        ) 
      )  
             
  
  
  
 