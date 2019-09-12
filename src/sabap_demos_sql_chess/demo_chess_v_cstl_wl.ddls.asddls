@AbapCatalog.sqlViewName: 'demo_chess_sclw'
@ClientDependent: true
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Long Castling for White Color'
define view Demo_Chess_V_Cstl_Wl as select from Demo_Chess_V_Game_Cds as game
left outer join Demo_Chess_V_Pos_Cds as a1 
  on game.gameuuid = a1.gameuuid and 
     game.movecnt  = a1.movecnt  and
     a1.x          = 1           and 
     a1.y          = 1
left outer join Demo_Chess_V_Pos_Cds as b1 
  on game.gameuuid = b1.gameuuid and 
     game.movecnt  = b1.movecnt  and
     b1.x          = 2           and 
     b1.y          = 1
left outer join Demo_Chess_V_Pos_Cds as c1 
  on game.gameuuid = c1.gameuuid and 
     game.movecnt  = c1.movecnt  and
     c1.x          = 3           and 
     c1.y          = 1
left outer join Demo_Chess_V_Pos_Cds as d1 
  on game.gameuuid = d1.gameuuid and 
     game.movecnt  = d1.movecnt  and
     d1.x          = 4           and 
     d1.y          = 1
left outer join Demo_Chess_V_Pos_Cds as e1 
  on game.gameuuid = e1.gameuuid and 
     game.movecnt  = e1.movecnt  and
     e1.x          = 5           and 
     e1.y          = 1
{
  key game.gameuuid, 
  key game.movecnt, 
  key #DEMO_CHESS_COLOR.'W' as color, 
  key #DEMO_CHESS_CHESSMAN.'K' as chessman,  
  key 5 as from_x, 
  key 1 as from_y, 
  key 3 as to_x, 
  key 1 as to_y, 
  #DEMO_CHESS_SPECIAL_FLAG.'C' as special_flag, 
  #DEMO_CHESS_COLOR.'W' as color_dep, 
  #DEMO_CHESS_CHESSMAN.'R' as chessman_dep, 
  1 as from_x_dep, 
  1 as from_y_dep, 
  4 as to_x_dep, 
  1 as to_y_dep, 
  cast( ' ' as demo_chess_transform_pawn ) as transform_pawn_flag, 
  game.castling_black_long, 
  game.castling_black_short, 
  cast( 'X' as demo_chess_castling ) as castling_white_long,
  cast( 'X' as demo_chess_castling ) as castling_white_short
}
  where game.castling_white_long = ' ' and
        e1.color = #DEMO_CHESS_COLOR.'W' and
        e1.chessman = #DEMO_CHESS_CHESSMAN.'K' and 
        b1.color is null and
        c1.color is null and
        d1.color is null and
        a1.color = #DEMO_CHESS_COLOR.'W' and
        a1.chessman = #DEMO_CHESS_CHESSMAN.'R'           
  
  
  
 