-- the semantics of this view is as follows: it returns all possible next moves 
-- _without_ the following two rules:
--     => castling
--     => king would be in chess
@AbapCatalog.sqlViewName: 'demo_chess_sst5'
@AbapCatalog.compiler.compareFilter: true
@EndUserText.label: 'Principally allowed movements respecting other chessman'
define view Demo_Chess_V_Stage5 as select from
  Demo_Chess_V_Stage1 as allowed
  left outer join Demo_Chess_V_Stage4 as forbidden
  on  allowed.gameuuid = forbidden.gameuuid and 
      allowed.movecnt  = forbidden.movecnt  and 
      allowed.color    = forbidden.color    and
      allowed.chessman = forbidden.chessman and
      allowed.from_x   = forbidden.from_x   and
      allowed.from_y   = forbidden.from_y   and
      allowed.to_x     = forbidden.to_x     and
      allowed.to_y     = forbidden.to_y
{
  key allowed.gameuuid, 
  key allowed.movecnt, 
  key allowed.color, 
  key allowed.chessman, 
  key allowed.from_x, 
  key allowed.from_y, 
  key allowed.to_x, 
  key allowed.to_y, 
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
  allowed.castling_white_short 
}
  where forbidden.gameuuid is null           
  
  
  
 