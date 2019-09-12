-- this is the equivalent of stage2 on top of stage8
@AbapCatalog.sqlViewName: 'demo_chess_sst9'
@AbapCatalog.compiler.compareFilter: true
@EndUserText.label: 'Helper View to generate allowed movements'
define view Demo_Chess_V_Stage9 as select from
  Demo_Chess_V_Stage8 as moves
  inner join Demo_Chess_V_Stage7 as position on position.gameuuid = moves.gameuuid and
                                                position.movecnt  = moves.movecnt  and
                                                position.move_color = moves.move_color and
                                                position.move_chessman = moves.move_chessman and
                                                position.move_from_x = moves.move_from_x and
                                                position.move_from_y = moves.move_from_y and
                                                position.move_to_x = moves.move_to_x and
                                                position.move_to_y = moves.move_to_y
{
  key moves.gameuuid,
  key moves.movecnt,
  key moves.move_color,
  key moves.move_chessman,
  key moves.move_from_x,
  key moves.move_from_y,
  key moves.move_to_x,
  key moves.move_to_y,
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
  
  
  
 