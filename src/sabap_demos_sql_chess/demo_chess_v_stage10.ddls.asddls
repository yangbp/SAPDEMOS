-- equivalent of stage3 on top of stage8
@AbapCatalog.sqlViewName: 'demo_chess_sst10'
@AbapCatalog.compiler.compareFilter: true
@EndUserText.label: 'Helper view to generate allowed movements'
define view Demo_Chess_V_Stage10 as select from Demo_Chess_V_Stage9 as source  
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
  
  
  
 