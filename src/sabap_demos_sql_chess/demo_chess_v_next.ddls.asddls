-- this view generates all final positions after carying out a particular move
-- it is the equivalent of demo_chess_v_stage7 on top of stage13
@AbapCatalog.sqlViewName: 'demo_chess_snxt'
@ClientDependent: true
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Generating the final position after carrying out the move'
define view Demo_Chess_V_Next as select from Demo_Chess_V_Stage13 as moves 
inner join Demo_Chess_V_Pos_Cds as pos
on moves.gameuuid = pos.gameuuid and
   moves.movecnt  = pos.movecnt
{
  key moves.gameuuid, 
  key moves.movecnt, 
  key moves.color as move_color, 
  key moves.chessman as move_chessman, 
  key moves.from_x as move_from_x, 
  key moves.from_y as move_from_y, 
  key moves.to_x as move_to_x, 
  key moves.to_y as move_to_y, 
  key case when moves.transform_pawn_flag = 'X' and
                moves.chessman = pos.chessman and
                moves.color    = pos.color    and 
                moves.from_x   = pos.x        and 
                moves.from_y   = pos.y
           then 'Q'
           else pos.chessman end as chessman,
  key pos.color,
  key case when moves.chessman = pos.chessman and
                moves.color    = pos.color    and 
                moves.from_x   = pos.x        and 
                moves.from_y   = pos.y
           then moves.to_x 
           when moves.special_flag = #DEMO_CHESS_SPECIAL_FLAG.'C' and
                moves.chessman_dep = pos.chessman and
                moves.color_dep    = pos.color    and
                moves.from_x_dep   = pos.x        and
                moves.from_y_dep   = pos.y
           then moves.to_x_dep
           else pos.x end as x,  
  key case when moves.chessman = pos.chessman and
                moves.color    = pos.color    and 
                moves.from_x   = pos.x        and 
                moves.from_y   = pos.y
           then moves.to_y 
           when moves.special_flag = #DEMO_CHESS_SPECIAL_FLAG.'C' and
                moves.chessman_dep = pos.chessman and
                moves.color_dep    = pos.color    and
                moves.from_x_dep   = pos.x        and
                moves.from_y_dep   = pos.y
           then moves.to_y_dep          
           else pos.y end as y,   
  pos.x as before_x,
  pos.y as before_y,     
  case when moves.chessman = pos.chessman and
            moves.color    = pos.color    and 
            moves.from_x   = pos.x        and 
            moves.from_y   = pos.y
       then 'X' 
       when moves.special_flag = #DEMO_CHESS_SPECIAL_FLAG.'C' and
            moves.chessman_dep = pos.chessman and
            moves.color_dep    = pos.color    and
            moves.from_x_dep   = pos.x        and
            moves.from_y_dep   = pos.y
       then 'X'
       else ' ' end as moved_flag, 
  moves.castling_black_long, 
  moves.castling_black_short, 
  moves.castling_white_long, 
  moves.castling_white_short,
  moves.is_castling_black_long,
  moves.is_castling_black_short,
  moves.is_castling_white_long,
  moves.is_castling_white_short
}
where ( not -- capture chessman:
  ( pos.x = moves.to_x and 
    pos.y = moves.to_y ) ) and ( not
  -- en passant:
  ( moves.special_flag = #DEMO_CHESS_SPECIAL_FLAG.'P' and 
    moves.color_dep    = pos.color and
    moves.chessman_dep = pos.chessman and 
    moves.to_x_dep     = pos.x and
    moves.to_y_dep     = pos.y ) )            
  
  
  
  
  
 