@AbapCatalog.sqlViewName: 'demo_chess_svall'
@ClientDependent: true
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Allowed Moves regarding all chess rules'
define view Demo_Chess_V_Allowed as select from Demo_Chess_V_Stage13 {
  gameuuid, 
  movecnt, 
  color, 
  chessman, 
  from_x, 
  from_y, 
  to_x, 
  to_y, 
  castling_black_long, 
  castling_black_short, 
  castling_white_long, 
  castling_white_short,
  is_castling_black_long,
  is_castling_black_short,
  is_castling_white_long,
  is_castling_white_short
}            
  
  
  
  
  
 