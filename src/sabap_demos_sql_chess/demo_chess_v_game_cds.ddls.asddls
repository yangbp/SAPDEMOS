@AbapCatalog.sqlViewName: 'demo_chess_sgcds'
@AbapCatalog.compiler.compareFilter: true
@EndUserText.label: 'Chess Game'
define view Demo_Chess_V_Game_Cds as select from demo_chess_game 
association [*] to Demo_Chess_V_Pos_Cds as _to_pos on _to_pos.gameuuid = $projection.gameuuid
{
  demo_chess_game.gameuuid, 
  demo_chess_game.movecnt, 
  demo_chess_game.color, 
  demo_chess_game.castling_white_long, 
  demo_chess_game.castling_white_short, 
  demo_chess_game.castling_black_long, 
  demo_chess_game.castling_black_short,
  /* Associations */
  _to_pos
}                     
  
  
  
  
  
  
  
 