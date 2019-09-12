@AbapCatalog.sqlViewName: 'demo_chess_spcds'
@AbapCatalog.compiler.compareFilter: true
@EndUserText.label: 'Chess positions'
define view Demo_Chess_V_Pos_Cds as select from demo_chess_pos 
association [1] to Demo_Chess_V_Game_Cds as _to_game on _to_game.gameuuid = $projection.gameuuid
association [*] to Demo_Chess_V_Moves_Cds as _to_move on _to_move.chessman = $projection.chessman and
                                                           _to_move.color = $projection.color and
                                                          _to_move.from_x = $projection.x and
                                                          _to_move.from_y = $projection.y 
{
  key demo_chess_pos.gameuuid, 
  key demo_chess_pos.movecnt, 
  key demo_chess_pos.chessman, 
  key demo_chess_pos.color, 
  key demo_chess_pos.x, 
  key demo_chess_pos.y,
  demo_chess_pos.before_x,
  demo_chess_pos.before_y,
  case when demo_chess_pos.before_x = x and demo_chess_pos.before_y = y then ' '
       when demo_chess_pos.before_x < 1 or demo_chess_pos.before_x > 8 then ' '
       when demo_chess_pos.before_y < 1 or demo_chess_pos.before_y > 8 then ' '
       else 'X'
  end as moved_flag, 
  _to_game,
  _to_move
}           
  
  
  
 