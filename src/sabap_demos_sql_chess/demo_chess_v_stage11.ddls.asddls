-- equivalent of stage4 on top of stage8
@AbapCatalog.sqlViewName: 'demo_chess_sst11'
@AbapCatalog.compiler.compareFilter: true
@EndUserText.label: 'Helper view'
define view Demo_Chess_V_Stage11 as select from Demo_Chess_V_Stage10 as source
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
  key source.to_y
}
where
   source.chessman <> #DEMO_CHESS_CHESSMAN.'N' and  -- knights may move everywhere
   source.first_slope = source.second_slope and
   source.first_distance  <= 1 and
   source.second_distance <= 1 and not
   (
     source.color <> source.other_color and
     source.to_x  = source.other_x      and 
     source.to_y  = source.other_y
   )           
  
  
  
 