@AbapCatalog.sqlViewName: 'demo_chess_sclb'
@ClientDependent: true
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Long Castling for White Color'
define view Demo_Chess_V_Cstl_Bl as select from Demo_Chess_V_Game_Cds as game
left outer join Demo_Chess_V_Pos_Cds as a8 
  on game.gameuuid = a8.gameuuid and 
     game.movecnt  = a8.movecnt  and
     a8.x          = 1           and 
     a8.y          = 8
left outer join Demo_Chess_V_Pos_Cds as b8 
  on game.gameuuid = b8.gameuuid and 
     game.movecnt  = b8.movecnt  and
     b8.x          = 2           and 
     b8.y          = 8
left outer join Demo_Chess_V_Pos_Cds as c8 
  on game.gameuuid = c8.gameuuid and 
     game.movecnt  = c8.movecnt  and
     c8.x          = 3           and 
     c8.y          = 8
left outer join Demo_Chess_V_Pos_Cds as d8 
  on game.gameuuid = d8.gameuuid and 
     game.movecnt  = d8.movecnt  and
     d8.x          = 4           and 
     d8.y          = 8
left outer join Demo_Chess_V_Pos_Cds as e8 
  on game.gameuuid = e8.gameuuid and 
     game.movecnt  = e8.movecnt  and
     e8.x          = 5           and 
     e8.y          = 8
{
  key game.gameuuid, 
  key game.movecnt, 
  key #DEMO_CHESS_COLOR.'B' as color, 
  key #DEMO_CHESS_CHESSMAN.'K' as chessman,  
  key 5 as from_x, 
  key 8 as from_y, 
  key 3 as to_x, 
  key 8 as to_y, 
  #DEMO_CHESS_SPECIAL_FLAG.'C' as special_flag, 
  #DEMO_CHESS_COLOR.'B' as color_dep, 
  #DEMO_CHESS_CHESSMAN.'R' as chessman_dep, 
  1 as from_x_dep, 
  8 as from_y_dep, 
  4 as to_x_dep, 
  8 as to_y_dep, 
  cast( ' ' as demo_chess_transform_pawn ) as transform_pawn_flag, 
  cast( 'X' as demo_chess_castling ) as castling_black_long,
  cast( 'X' as demo_chess_castling ) as castling_black_short,
  game.castling_white_long, 
  game.castling_white_short
}
  where game.castling_black_long = ' ' and
        e8.color = #DEMO_CHESS_COLOR.'B' and
        e8.chessman = #DEMO_CHESS_CHESSMAN.'K' and 
        b8.color is null and
        c8.color is null and
        d8.color is null and
        a8.color = #DEMO_CHESS_COLOR.'B' and
        a8.chessman = #DEMO_CHESS_CHESSMAN.'R'           
  
  
  
 