-- the semantics of the view is the following: given a (color, chessman, from_x, from_y, to_x, to_y) position, 
-- the result set is empty, if the movement is principally allowed and returns more than 0 result sets, if there is some
-- other chess figure in the way between (from_x, from_y) and (to_x, to_y)
@AbapCatalog.sqlViewName: 'demo_chess_sst4'
@AbapCatalog.compiler.compareFilter: true
@EndUserText.label: 'Hilfsview für zur Generierung er möglichen Züge'
define view Demo_Chess_V_Stage4 as select from Demo_Chess_V_Stage3 as source
{
  key source.gameuuid,
  key source.movecnt,
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
  
  
  
 