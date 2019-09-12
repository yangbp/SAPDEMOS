-- This view is an intermediate step in calculating all allowed movements
-- especially to rule out all disallowed movements because of other
-- chessman in the way between (from_x, from_y) => (to_x, to_y).
-- It therefore joins the principally allowed moves from Stage1
-- again with all chess positions and calculates some intermediate numbers
@AbapCatalog.sqlViewName: 'demo_chess_sst2'
@AbapCatalog.compiler.compareFilter: true
@EndUserText.label: 'Helper View to generate allowed movements'
define view Demo_Chess_V_Stage2 as select from
  Demo_Chess_V_Stage1 as moves
  inner join Demo_Chess_V_Pos_Cds as position on position.gameuuid = moves.gameuuid and
                                             position.movecnt  = moves.movecnt
{
  key moves.gameuuid,
  key moves.movecnt,
  key moves.color, 
  key moves.chessman, 
  key moves.from_x, 
  key moves.from_y, 
  key moves.to_x, 
  key moves.to_y, 
  position.color as other_color,
  position.x as other_x,
  position.y as other_y,
  moves.special_flag, 
  moves.color_dep, 
  moves.chessman_dep, 
  moves.from_x_dep, 
  moves.from_y_dep, 
  moves.to_x_dep, 
  moves.to_y_dep, 
  moves.transform_pawn_flag,
  ( moves.to_x - moves.from_x ) * ( position.y - moves.from_y ) as first_slope,
  ( position.x - moves.from_x ) * ( moves.to_y - moves.from_y ) as second_slope,
  case when moves.from_x < position.x then -1
       when moves.from_x = position.x then  0
       else                                 1
  end as cmp_1x,
  case when moves.to_x  < position.x then -1
       when moves.to_x = position.x  then  0
       else                                1
  end as cmp_2x, 
  case when moves.from_y < position.y then -1
       when moves.from_y = position.y then  0
       else                                 1
  end as cmp_1y,
  case when moves.to_y  < position.y then -1
       when moves.to_y = position.y  then  0
       else                                1
  end as cmp_2y
}
  where not ( position.chessman = moves.chessman and 
              position.color    = moves.color    and
              position.x        = moves.from_x   and
              position.y        = moves.from_y
  )           
  
  
  
 