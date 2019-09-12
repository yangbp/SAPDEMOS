-- the semantics of this view is as follows: it returns all possible next moves 
-- _without_ the following three rules:
--     => other chessman in the way between (from_x, from_y) => (to_x, to_y)
--     => castling
--     => king would be in chess
-- en_passant and all the special rules of pawn movement are handled correctly
@AbapCatalog.sqlViewName: 'demo_chess_sst1'
@AbapCatalog.compiler.compareFilter: true
@EndUserText.label: 'Principally allowed movements'
define view Demo_Chess_V_Stage1 as select from
  ( demo_chess_game as game inner join
    Demo_Chess_V_Pos_Cds as source on game.gameuuid = source.gameuuid ) 
  inner join Demo_Chess_V_Moves_Cds as moves
    on source.color    = moves.color    and
       source.chessman = moves.chessman and
       source.x        = moves.from_x   and 
       source.y        = moves.from_y
  left outer join Demo_Chess_V_Pos_Cds as target_field on target_field.gameuuid = source.gameuuid and
                                                      target_field.movecnt = source.movecnt and
                                                      target_field.x = moves.to_x and
                                                      target_field.y = moves.to_y
  left outer join Demo_Chess_V_Pos_Cds as last_move    on last_move.gameuuid   = source.gameuuid and 
                                                      last_move.movecnt    = source.movecnt   and 
                                                      last_move.moved_flag = 'X' 
{
  key source.gameuuid,
  key source.movecnt,
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
  case when game.castling_black_long = #SAP_BOOL.'X' then 'X'
       when source.color = #DEMO_CHESS_COLOR.'B' and 
            source.chessman = #DEMO_CHESS_CHESSMAN.'K' then 'X'
       when source.color = #DEMO_CHESS_COLOR.'B' and 
            source.chessman = #DEMO_CHESS_CHESSMAN.'R' and
            source.x  = 1 and 
            source.y  = 8 then 'X'
  end as castling_black_long,
  case when game.castling_black_short = #SAP_BOOL.'X' then 'X'
       when source.color = #DEMO_CHESS_COLOR.'B' and 
            source.chessman = #DEMO_CHESS_CHESSMAN.'K' then 'X'
       when source.color = #DEMO_CHESS_COLOR.'B' and 
            source.chessman = #DEMO_CHESS_CHESSMAN.'R' and
            source.x  = 8 and 
            source.y  = 8 then 'X'
  end as castling_black_short,
  case when game.castling_white_long = #SAP_BOOL.'X' then 'X'
       when source.color = #DEMO_CHESS_COLOR.'W' and 
            source.chessman = #DEMO_CHESS_CHESSMAN.'K' then 'X'
       when source.color = #DEMO_CHESS_COLOR.'W' and 
            source.chessman = #DEMO_CHESS_CHESSMAN.'R' and
            source.x  = 1 and 
            source.y  = 1 then 'X'
  end as castling_white_long,
  case when game.castling_white_short = #SAP_BOOL.'X' then 'X'
       when source.color = #DEMO_CHESS_COLOR.'W' and 
            source.chessman = #DEMO_CHESS_CHESSMAN.'K' then 'X'
       when source.color = #DEMO_CHESS_COLOR.'W' and 
            source.chessman = #DEMO_CHESS_CHESSMAN.'R' and
            source.x  = 8 and 
            source.y  = 1 then 'X'
  end as castling_white_short,
  last_move.chessman as last_chessman,
  last_move.color as last_color,    
  last_move.before_x as last_from_x,
  last_move.before_y as last_from_y,
  last_move.x as last_to_x,       
  last_move.y as last_to_y        
}
  where
    source.color = game.color          and   -- only the moves of the current color
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
  )
           
  
  
  
 