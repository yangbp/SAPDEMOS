-- the semantics of this view is as follows: it returns all possible next moves 
-- _without_ the following rule:
--     => king would be in chess
-- this means: castling is handled correctly
@AbapCatalog.sqlViewName: 'demo_chess_sst6'
@AbapCatalog.compiler.compareFilter: true
@EndUserText.label: 'Principally allowed movements respecting other chessman and castling'
define view Demo_Chess_V_Stage6 as select from
  Demo_Chess_V_Stage5 as allowed
{
  key allowed.gameuuid, 
  key allowed.movecnt, 
  key allowed.color, 
  key allowed.chessman, 
  key allowed.from_x, 
  key allowed.from_y, 
  key allowed.to_x, 
  key allowed.to_y, 
  allowed.special_flag,
  case when allowed.color_dep <> #DEMO_CHESS_COLOR.'-'
    then allowed.color_dep end as color_dep, -- else NULL 
  case when chessman_dep <> #DEMO_CHESS_CHESSMAN.'-'
    then chessman_dep end as chessman_dep, -- else NULL 
  allowed.from_x_dep, 
  allowed.from_y_dep, 
  allowed.to_x_dep, 
  allowed.to_y_dep, 
  allowed.transform_pawn_flag, 
  allowed.castling_black_long, 
  allowed.castling_black_short, 
  allowed.castling_white_long, 
  allowed.castling_white_short,
  #SAP_BOOL.' ' as is_castling_black_long,
  #SAP_BOOL.' ' as is_castling_black_short,
  #SAP_BOOL.' ' as is_castling_white_long,
  #SAP_BOOL.' ' as is_castling_white_short
} 
union select from Demo_Chess_V_Cstl_Bl
{
  Demo_Chess_V_Cstl_Bl.gameuuid, 
  Demo_Chess_V_Cstl_Bl.movecnt, 
  Demo_Chess_V_Cstl_Bl.color, 
  Demo_Chess_V_Cstl_Bl.chessman, 
  Demo_Chess_V_Cstl_Bl.from_x, 
  Demo_Chess_V_Cstl_Bl.from_y, 
  Demo_Chess_V_Cstl_Bl.to_x, 
  Demo_Chess_V_Cstl_Bl.to_y, 
  Demo_Chess_V_Cstl_Bl.special_flag, 
  Demo_Chess_V_Cstl_Bl.color_dep, 
  Demo_Chess_V_Cstl_Bl.chessman_dep, 
  Demo_Chess_V_Cstl_Bl.from_x_dep, 
  Demo_Chess_V_Cstl_Bl.from_y_dep, 
  Demo_Chess_V_Cstl_Bl.to_x_dep, 
  Demo_Chess_V_Cstl_Bl.to_y_dep, 
  Demo_Chess_V_Cstl_Bl.transform_pawn_flag, 
  Demo_Chess_V_Cstl_Bl.castling_black_long, 
  Demo_Chess_V_Cstl_Bl.castling_black_short, 
  Demo_Chess_V_Cstl_Bl.castling_white_long, 
  Demo_Chess_V_Cstl_Bl.castling_white_short,
  #SAP_BOOL.'X' as is_castling_black_long,
  #SAP_BOOL.' ' as is_castling_black_short,
  #SAP_BOOL.' ' as is_castling_white_long,
  #SAP_BOOL.' ' as is_castling_white_short
}
union select from Demo_Chess_V_Cstl_Bs
{
  Demo_Chess_V_Cstl_Bs.gameuuid, 
  Demo_Chess_V_Cstl_Bs.movecnt, 
  Demo_Chess_V_Cstl_Bs.color, 
  Demo_Chess_V_Cstl_Bs.chessman, 
  Demo_Chess_V_Cstl_Bs.from_x, 
  Demo_Chess_V_Cstl_Bs.from_y, 
  Demo_Chess_V_Cstl_Bs.to_x, 
  Demo_Chess_V_Cstl_Bs.to_y, 
  Demo_Chess_V_Cstl_Bs.special_flag, 
  Demo_Chess_V_Cstl_Bs.color_dep, 
  Demo_Chess_V_Cstl_Bs.chessman_dep, 
  Demo_Chess_V_Cstl_Bs.from_x_dep, 
  Demo_Chess_V_Cstl_Bs.from_y_dep, 
  Demo_Chess_V_Cstl_Bs.to_x_dep, 
  Demo_Chess_V_Cstl_Bs.to_y_dep, 
  Demo_Chess_V_Cstl_Bs.transform_pawn_flag, 
  Demo_Chess_V_Cstl_Bs.castling_black_long, 
  Demo_Chess_V_Cstl_Bs.castling_black_short, 
  Demo_Chess_V_Cstl_Bs.castling_white_long, 
  Demo_Chess_V_Cstl_Bs.castling_white_short,
  #SAP_BOOL.' ' as is_castling_black_long,
  #SAP_BOOL.'X' as is_castling_black_short,
  #SAP_BOOL.' ' as is_castling_white_long,
  #SAP_BOOL.' ' as is_castling_white_short
}
union select from Demo_Chess_V_Cstl_Wl
{
  Demo_Chess_V_Cstl_Wl.gameuuid, 
  Demo_Chess_V_Cstl_Wl.movecnt, 
  Demo_Chess_V_Cstl_Wl.color, 
  Demo_Chess_V_Cstl_Wl.chessman, 
  Demo_Chess_V_Cstl_Wl.from_x, 
  Demo_Chess_V_Cstl_Wl.from_y, 
  Demo_Chess_V_Cstl_Wl.to_x, 
  Demo_Chess_V_Cstl_Wl.to_y, 
  Demo_Chess_V_Cstl_Wl.special_flag, 
  Demo_Chess_V_Cstl_Wl.color_dep, 
  Demo_Chess_V_Cstl_Wl.chessman_dep, 
  Demo_Chess_V_Cstl_Wl.from_x_dep, 
  Demo_Chess_V_Cstl_Wl.from_y_dep, 
  Demo_Chess_V_Cstl_Wl.to_x_dep, 
  Demo_Chess_V_Cstl_Wl.to_y_dep, 
  Demo_Chess_V_Cstl_Wl.transform_pawn_flag, 
  Demo_Chess_V_Cstl_Wl.castling_black_long, 
  Demo_Chess_V_Cstl_Wl.castling_black_short, 
  Demo_Chess_V_Cstl_Wl.castling_white_long, 
  Demo_Chess_V_Cstl_Wl.castling_white_short,
  #SAP_BOOL.' ' as is_castling_black_long,
  #SAP_BOOL.' ' as is_castling_black_short,
  #SAP_BOOL.'X' as is_castling_white_long,
  #SAP_BOOL.' ' as is_castling_white_short
}
union select from Demo_Chess_V_Cstl_Ws
{
  Demo_Chess_V_Cstl_Ws.gameuuid, 
  Demo_Chess_V_Cstl_Ws.movecnt, 
  Demo_Chess_V_Cstl_Ws.color, 
  Demo_Chess_V_Cstl_Ws.chessman, 
  Demo_Chess_V_Cstl_Ws.from_x, 
  Demo_Chess_V_Cstl_Ws.from_y, 
  Demo_Chess_V_Cstl_Ws.to_x, 
  Demo_Chess_V_Cstl_Ws.to_y, 
  Demo_Chess_V_Cstl_Ws.special_flag, 
  Demo_Chess_V_Cstl_Ws.color_dep, 
  Demo_Chess_V_Cstl_Ws.chessman_dep, 
  Demo_Chess_V_Cstl_Ws.from_x_dep, 
  Demo_Chess_V_Cstl_Ws.from_y_dep, 
  Demo_Chess_V_Cstl_Ws.to_x_dep, 
  Demo_Chess_V_Cstl_Ws.to_y_dep, 
  Demo_Chess_V_Cstl_Ws.transform_pawn_flag, 
  Demo_Chess_V_Cstl_Ws.castling_black_long, 
  Demo_Chess_V_Cstl_Ws.castling_black_short, 
  Demo_Chess_V_Cstl_Ws.castling_white_long, 
  Demo_Chess_V_Cstl_Ws.castling_white_short,
  #SAP_BOOL.' ' as is_castling_black_long,
  #SAP_BOOL.' ' as is_castling_black_short,
  #SAP_BOOL.' ' as is_castling_white_long,
  #SAP_BOOL.'X' as is_castling_white_short
}           
  
  
  
 