@AbapCatalog.sqlViewName: 'demo_chess_smcds'
@AbapCatalog.compiler.compareFilter: true
@EndUserText.label: 'Schachzüge'
define view Demo_Chess_V_Moves_Cds as select from demo_chess_moves
{
    demo_chess_moves.color, 
    demo_chess_moves.chessman, 
    demo_chess_moves.from_x, 
    demo_chess_moves.from_y, 
    demo_chess_moves.to_x, 
    demo_chess_moves.to_y, 
    demo_chess_moves.special_flag, 
    demo_chess_moves.color_dep, 
    demo_chess_moves.chessman_dep, 
    demo_chess_moves.from_x_dep, 
    demo_chess_moves.from_y_dep, 
    demo_chess_moves.to_x_dep, 
    demo_chess_moves.to_y_dep, 
    demo_chess_moves.transform_pawn_flag
}           
  
  
  
 