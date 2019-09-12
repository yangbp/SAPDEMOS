@AbapCatalog.sqlViewName: 'demo_chess_scsw'
@ClientDependent: true
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Short Castling for White Color'
define view Demo_Chess_V_Cstl_Ws as select from Demo_Chess_V_Game_Cds as game
left outer join Demo_Chess_V_Pos_Cds as e1 
  on game.gameuuid = e1.gameuuid and 
     game.movecnt  = e1.movecnt  and
     e1.x          = 5           and 
     e1.y          = 1
left outer join Demo_Chess_V_Pos_Cds as f1 
  on game.gameuuid = f1.gameuuid and 
     game.movecnt  = f1.movecnt  and
     f1.x          = 6           and 
     f1.y          = 1 
left outer join Demo_Chess_V_Pos_Cds as g1 
  on game.gameuuid = g1.gameuuid and 
     game.movecnt  = g1.movecnt  and
     g1.x          = 7           and 
     g1.y          = 1         
left outer join Demo_Chess_V_Pos_Cds as h1 
  on game.gameuuid = h1.gameuuid and 
     game.movecnt  = h1.movecnt  and
     h1.x          = 8           and 
     h1.y          = 1
{
  key game.gameuuid, 
  key game.movecnt, 
  key #DEMO_CHESS_COLOR.'W' as color, 
  key #DEMO_CHESS_CHESSMAN.'K' as chessman,  
  key 5 as from_x, 
  key 1 as from_y, 
  key 7 as to_x, 
  key 1 as to_y, 
  #DEMO_CHESS_SPECIAL_FLAG.'C' as special_flag, 
  #DEMO_CHESS_COLOR.'W' as color_dep, 
  #DEMO_CHESS_CHESSMAN.'R' as chessman_dep, 
  8 as from_x_dep, 
  1 as from_y_dep, 
  6 as to_x_dep, 
  1 as to_y_dep, 
  cast( ' ' as demo_chess_transform_pawn ) as transform_pawn_flag, 
  game.castling_black_long, 
  game.castling_black_short, 
  cast( 'X' as demo_chess_castling ) as castling_white_long,
  cast( 'X' as demo_chess_castling ) as castling_white_short
}
  where game.castling_white_short = ' ' and
        e1.color = #DEMO_CHESS_COLOR.'W' and
        e1.chessman = #DEMO_CHESS_CHESSMAN.'K' and 
        f1.color is null and
        g1.color is null and
        h1.color = #DEMO_CHESS_COLOR.'W' and
        h1.chessman = #DEMO_CHESS_CHESSMAN.'R'           
  
  
  
 