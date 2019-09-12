-- get all allowed chess moves, _including_ that the king should not be in chess 
-- after the move or during a castling
@AbapCatalog.sqlViewName: 'demo_chess_sst13'
@AbapCatalog.compiler.compareFilter: true
@EndUserText.label: 'Principally allowed movements'
define view Demo_Chess_V_Stage13 as select from
  Demo_Chess_V_Stage6 as allowed
  left outer join demo_chess_stp12 as forbidden
  on  allowed.gameuuid = forbidden.gameuuid and 
      allowed.movecnt  = forbidden.movecnt  and 
      allowed.color = forbidden.move_color and
      allowed.chessman = forbidden.move_chessman and
      allowed.from_x = forbidden.move_from_x and
      allowed.from_y = forbidden.move_from_y and
      allowed.to_x = forbidden.move_to_x and
      allowed.to_y = forbidden.move_to_y
{
  allowed.gameuuid, 
  allowed.movecnt, 
  allowed.color, 
  allowed.chessman, 
  allowed.from_x, 
  allowed.from_y, 
  allowed.to_x, 
  allowed.to_y, 
  allowed.special_flag, 
  allowed.color_dep, 
  allowed.chessman_dep, 
  allowed.from_x_dep, 
  allowed.from_y_dep, 
  allowed.to_x_dep, 
  allowed.to_y_dep, 
  allowed.transform_pawn_flag, 
  allowed.castling_black_long, 
  allowed.castling_black_short, 
  allowed.castling_white_long, 
  allowed.castling_white_short,
  allowed.is_castling_black_long,
  allowed.is_castling_black_short,
  allowed.is_castling_white_long,
  allowed.is_castling_white_short
}
  where forbidden.gameuuid is null        
  
  
  
  
  
 