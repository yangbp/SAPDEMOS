-- This helper view builds uppon stage3 and does some further calculations
-- needed to rule out chessman in the way between
-- (from_x, from_y) => (to_x, to_y)
-- It is needed because CDS, at the moment, can not aribitrarily nest
-- arithmetic functions and case statements
@AbapCatalog.sqlViewName: 'demo_chess_sst3'
@AbapCatalog.compiler.compareFilter: true
@EndUserText.label: 'Helper view to generate allowed movements'
define view Demo_Chess_V_Stage3 as select from Demo_Chess_V_Stage2 as source  
{
  key source.gameuuid,
  key source.movecnt,
  key source.color, 
  key source.chessman, 
  key source.from_x, 
  key source.from_y, 
  key source.to_x, 
  key source.to_y,
  source.other_color,
  source.other_x,
  source.other_y,
  source.special_flag, 
  source.color_dep, 
  source.chessman_dep, 
  source.from_x_dep, 
  source.from_y_dep, 
  source.to_x_dep, 
  source.to_y_dep, 
  source.transform_pawn_flag,
  source.first_slope,
  source.second_slope,
  abs( source.cmp_1x + source.cmp_2x ) as first_distance,
  abs( source.cmp_1y + source.cmp_2y ) as second_distance
}           
  
  
  
 