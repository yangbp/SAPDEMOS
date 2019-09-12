@AbapCatalog.sqlViewName: 'demo_chess_scsb'
@ClientDependent: true
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Short Castling for Black Color'
define view Demo_Chess_V_Cstl_Bs as select from Demo_Chess_V_Game_Cds as game
left outer join Demo_Chess_V_Pos_Cds as e8 
  on game.gameuuid = e8.gameuuid and 
     game.movecnt  = e8.movecnt  and
     e8.x          = 5           and 
     e8.y          = 8
left outer join Demo_Chess_V_Pos_Cds as f8 
  on game.gameuuid = f8.gameuuid and 
     game.movecnt  = f8.movecnt  and
     f8.x          = 6           and 
     f8.y          = 8 
left outer join Demo_Chess_V_Pos_Cds as g8 
  on game.gameuuid = g8.gameuuid and 
     game.movecnt  = g8.movecnt  and
     g8.x          = 7           and 
     g8.y          = 8         
left outer join Demo_Chess_V_Pos_Cds as h8 
  on game.gameuuid = h8.gameuuid and 
     game.movecnt  = h8.movecnt  and
     h8.x          = 8           and 
     h8.y          = 8
{
  key game.gameuuid, 
  key game.movecnt, 
  key #DEMO_CHESS_COLOR.'B' as color, 
  key #DEMO_CHESS_CHESSMAN.'K' as chessman,  
  key 5 as from_x, 
  key 8 as from_y, 
  key 7 as to_x, 
  key 8 as to_y, 
  #DEMO_CHESS_SPECIAL_FLAG.'C' as special_flag, 
  #DEMO_CHESS_COLOR.'B' as color_dep, 
  #DEMO_CHESS_CHESSMAN.'R' as chessman_dep, 
  8 as from_x_dep, 
  8 as from_y_dep, 
  6 as to_x_dep, 
  8 as to_y_dep, 
  cast( ' ' as demo_chess_transform_pawn ) as transform_pawn_flag, 
  cast( 'X' as demo_chess_castling ) as castling_black_long,
  cast( 'X' as demo_chess_castling ) as castling_black_short,
  game.castling_white_long,
  game.castling_white_short
}
  where game.castling_black_short = ' ' and
        e8.color = #DEMO_CHESS_COLOR.'B' and
        e8.chessman = #DEMO_CHESS_CHESSMAN.'K' and 
        f8.color is null and
        g8.color is null and
        h8.color = #DEMO_CHESS_COLOR.'B' and
        h8.chessman = #DEMO_CHESS_CHESSMAN.'R'           
  
  
  
 