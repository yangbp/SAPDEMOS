--   this view displays a whole chess position as a single line
-- by using 64 left outer joins; not filled positions are thus null
@AbapCatalog.sqlViewName: 'demo_chess_sp2l'
@ClientDependent: true
@AbapCatalog.compiler.compareFilter: true
@EndUserText.label: 'Create View which contains a chess position in a single line'
define view Demo_Chess_V_Pos2line as select from demo_chess_game as game
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
left outer join Demo_Chess_V_Pos_Cds as a2 
  on game.gameuuid = a2.gameuuid and 
     game.movecnt  = a2.movecnt  and
     a2.x          = 1           and 
     a2.y          = 2
left outer join Demo_Chess_V_Pos_Cds as b2 
  on game.gameuuid = b2.gameuuid and 
     game.movecnt  = b2.movecnt  and
     b2.x          = 2           and 
     b2.y          = 2
left outer join Demo_Chess_V_Pos_Cds as c2 
  on game.gameuuid = c2.gameuuid and 
     game.movecnt  = c2.movecnt  and
     c2.x          = 3           and 
     c2.y          = 2
left outer join Demo_Chess_V_Pos_Cds as d2 
  on game.gameuuid = d2.gameuuid and 
     game.movecnt  = d2.movecnt  and
     d2.x          = 4           and 
     d2.y          = 2
left outer join Demo_Chess_V_Pos_Cds as e2 
  on game.gameuuid = e2.gameuuid and 
     game.movecnt  = e2.movecnt  and
     e2.x          = 5           and 
     e2.y          = 2
left outer join Demo_Chess_V_Pos_Cds as f2 
  on game.gameuuid = f2.gameuuid and 
     game.movecnt  = f2.movecnt  and
     f2.x          = 6           and 
     f2.y          = 2 
left outer join Demo_Chess_V_Pos_Cds as g2 
  on game.gameuuid = g2.gameuuid and 
     game.movecnt  = g2.movecnt  and
     g2.x          = 7           and 
     g2.y          = 2         
left outer join Demo_Chess_V_Pos_Cds as h2 
  on game.gameuuid = h2.gameuuid and 
     game.movecnt  = h2.movecnt  and
     h2.x          = 8           and 
     h2.y          = 2
left outer join Demo_Chess_V_Pos_Cds as a3 
  on game.gameuuid = a3.gameuuid and 
     game.movecnt  = a3.movecnt  and
     a3.x          = 1           and 
     a3.y          = 3
left outer join Demo_Chess_V_Pos_Cds as b3 
  on game.gameuuid = b3.gameuuid and 
     game.movecnt  = b3.movecnt  and
     b3.x          = 2           and 
     b3.y          = 3
left outer join Demo_Chess_V_Pos_Cds as c3 
  on game.gameuuid = c3.gameuuid and 
     game.movecnt  = c3.movecnt  and
     c3.x          = 3           and 
     c3.y          = 3
left outer join Demo_Chess_V_Pos_Cds as d3 
  on game.gameuuid = d3.gameuuid and 
     game.movecnt  = d3.movecnt  and
     d3.x          = 4           and 
     d3.y          = 3
left outer join Demo_Chess_V_Pos_Cds as e3 
  on game.gameuuid = e3.gameuuid and 
     game.movecnt  = e3.movecnt  and
     e3.x          = 5           and 
     e3.y          = 3
left outer join Demo_Chess_V_Pos_Cds as f3 
  on game.gameuuid = f3.gameuuid and 
     game.movecnt  = f3.movecnt  and
     f3.x          = 6           and 
     f3.y          = 3 
left outer join Demo_Chess_V_Pos_Cds as g3 
  on game.gameuuid = g3.gameuuid and 
     game.movecnt  = g3.movecnt  and
     g3.x          = 7           and 
     g3.y          = 3         
left outer join Demo_Chess_V_Pos_Cds as h3 
  on game.gameuuid = h3.gameuuid and 
     game.movecnt  = h3.movecnt  and
     h3.x          = 8           and 
     h3.y          = 3     
left outer join Demo_Chess_V_Pos_Cds as a4 
  on game.gameuuid = a4.gameuuid and 
     game.movecnt  = a4.movecnt  and
     a4.x          = 1           and 
     a4.y          = 4
left outer join Demo_Chess_V_Pos_Cds as b4 
  on game.gameuuid = b4.gameuuid and 
     game.movecnt  = b4.movecnt  and
     b4.x          = 2           and 
     b4.y          = 4
left outer join Demo_Chess_V_Pos_Cds as c4 
  on game.gameuuid = c4.gameuuid and 
     game.movecnt  = c4.movecnt  and
     c4.x          = 3           and 
     c4.y          = 4
left outer join Demo_Chess_V_Pos_Cds as d4 
  on game.gameuuid = d4.gameuuid and 
     game.movecnt  = d4.movecnt  and
     d4.x          = 4           and 
     d4.y          = 4
left outer join Demo_Chess_V_Pos_Cds as e4 
  on game.gameuuid = e4.gameuuid and 
     game.movecnt  = e4.movecnt  and
     e4.x          = 5           and 
     e4.y          = 4
left outer join Demo_Chess_V_Pos_Cds as f4 
  on game.gameuuid = f4.gameuuid and 
     game.movecnt  = f4.movecnt  and
     f4.x          = 6           and 
     f4.y          = 4 
left outer join Demo_Chess_V_Pos_Cds as g4 
  on game.gameuuid = g4.gameuuid and 
     game.movecnt  = g4.movecnt  and
     g4.x          = 7           and 
     g4.y          = 4         
left outer join Demo_Chess_V_Pos_Cds as h4 
  on game.gameuuid = h4.gameuuid and 
     game.movecnt  = h4.movecnt  and
     h4.x          = 8           and 
     h4.y          = 4    
left outer join Demo_Chess_V_Pos_Cds as a5 
  on game.gameuuid = a5.gameuuid and 
     game.movecnt  = a5.movecnt  and
     a5.x          = 1           and 
     a5.y          = 5
left outer join Demo_Chess_V_Pos_Cds as b5 
  on game.gameuuid = b5.gameuuid and 
     game.movecnt  = b5.movecnt  and
     b5.x          = 2           and 
     b5.y          = 5
left outer join Demo_Chess_V_Pos_Cds as c5 
  on game.gameuuid = c5.gameuuid and 
     game.movecnt  = c5.movecnt  and
     c5.x          = 3           and 
     c5.y          = 5
left outer join Demo_Chess_V_Pos_Cds as d5 
  on game.gameuuid = d5.gameuuid and 
     game.movecnt  = d5.movecnt  and
     d5.x          = 4           and 
     d5.y          = 5
left outer join Demo_Chess_V_Pos_Cds as e5 
  on game.gameuuid = e5.gameuuid and 
     game.movecnt  = e5.movecnt  and
     e5.x          = 5           and 
     e5.y          = 5
left outer join Demo_Chess_V_Pos_Cds as f5 
  on game.gameuuid = f5.gameuuid and 
     game.movecnt  = f5.movecnt  and
     f5.x          = 6           and 
     f5.y          = 5
left outer join Demo_Chess_V_Pos_Cds as g5 
  on game.gameuuid = g5.gameuuid and 
     game.movecnt  = g5.movecnt  and
     g5.x          = 7           and 
     g5.y          = 5         
left outer join Demo_Chess_V_Pos_Cds as h5 
  on game.gameuuid = h5.gameuuid and 
     game.movecnt  = h5.movecnt  and
     h5.x          = 8           and 
     h5.y          = 5 
left outer join Demo_Chess_V_Pos_Cds as a6 
  on game.gameuuid = a6.gameuuid and 
     game.movecnt  = a6.movecnt  and
     a6.x          = 1           and 
     a6.y          = 6
left outer join Demo_Chess_V_Pos_Cds as b6 
  on game.gameuuid = b6.gameuuid and 
     game.movecnt  = b6.movecnt  and
     b6.x          = 2           and 
     b6.y          = 6
left outer join Demo_Chess_V_Pos_Cds as c6 
  on game.gameuuid = c6.gameuuid and 
     game.movecnt  = c6.movecnt  and
     c6.x          = 3           and 
     c6.y          = 6
left outer join Demo_Chess_V_Pos_Cds as d6 
  on game.gameuuid = d6.gameuuid and 
     game.movecnt  = d6.movecnt  and
     d6.x          = 4           and 
     d6.y          = 6
left outer join Demo_Chess_V_Pos_Cds as e6 
  on game.gameuuid = e6.gameuuid and 
     game.movecnt  = e6.movecnt  and
     e6.x          = 5           and 
     e6.y          = 6
left outer join Demo_Chess_V_Pos_Cds as f6 
  on game.gameuuid = f6.gameuuid and 
     game.movecnt  = f6.movecnt  and
     f6.x          = 6           and 
     f6.y          = 6
left outer join Demo_Chess_V_Pos_Cds as g6 
  on game.gameuuid = g6.gameuuid and 
     game.movecnt  = g6.movecnt  and
     g6.x          = 7           and 
     g6.y          = 6         
left outer join Demo_Chess_V_Pos_Cds as h6 
  on game.gameuuid = h6.gameuuid and 
     game.movecnt  = h6.movecnt  and
     h6.x          = 8           and 
     h6.y          = 6  
left outer join Demo_Chess_V_Pos_Cds as a7 
  on game.gameuuid = a7.gameuuid and 
     game.movecnt  = a7.movecnt  and
     a7.x          = 1           and 
     a7.y          = 7
left outer join Demo_Chess_V_Pos_Cds as b7 
  on game.gameuuid = b7.gameuuid and 
     game.movecnt  = b7.movecnt  and
     b7.x          = 2           and 
     b7.y          = 7
left outer join Demo_Chess_V_Pos_Cds as c7
  on game.gameuuid = c7.gameuuid and 
     game.movecnt  = c7.movecnt  and
     c7.x          = 3           and 
     c7.y          = 7
left outer join Demo_Chess_V_Pos_Cds as d7 
  on game.gameuuid = d7.gameuuid and 
     game.movecnt  = d7.movecnt  and
     d7.x          = 4           and 
     d7.y          = 7
left outer join Demo_Chess_V_Pos_Cds as e7 
  on game.gameuuid = e7.gameuuid and 
     game.movecnt  = e7.movecnt  and
     e7.x          = 5           and 
     e7.y          = 7
left outer join Demo_Chess_V_Pos_Cds as f7
  on game.gameuuid = f7.gameuuid and 
     game.movecnt  = f7.movecnt  and
     f7.x          = 6           and 
     f7.y          = 7
left outer join Demo_Chess_V_Pos_Cds as g7 
  on game.gameuuid = g7.gameuuid and 
     game.movecnt  = g7.movecnt  and
     g7.x          = 7           and 
     g7.y          = 7         
left outer join Demo_Chess_V_Pos_Cds as h7 
  on game.gameuuid = h7.gameuuid and 
     game.movecnt  = h7.movecnt  and
     h7.x          = 8           and 
     h7.y          = 7  
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
  game.movecnt, 
  game.color, 
  game.castling_white_long, 
  game.castling_white_short, 
  game.castling_black_long, 
  game.castling_black_short,
  a1.color as a1_color,
  a1.chessman as a1_chessman,
  b1.color as b1_color,
  b1.chessman as b1_chessman,
  c1.color as c1_color,
  c1.chessman as c1_chessman,
  d1.color as d1_color,
  d1.chessman as d1_chessman,
  e1.color as e1_color,
  e1.chessman as e1_chessman,
  f1.color as f1_color,
  f1.chessman as f1_chessman,
  g1.color as g1_color,
  g1.chessman as g1_chessman,
  h1.color as h1_color,
  h1.chessman as h1_chessman,
  a2.color as a2_color,
  a2.chessman as a2_chessman,
  b2.color as b2_color,
  b2.chessman as b2_chessman,
  c2.color as c2_color,
  c2.chessman as c2_chessman,
  d2.color as d2_color,
  d2.chessman as d2_chessman,
  e2.color as e2_color,
  e2.chessman as e2_chessman,
  f2.color as f2_color,
  f2.chessman as f2_chessman,
  g2.color as g2_color,
  g2.chessman as g2_chessman,
  h2.color as h2_color,
  h2.chessman as h2_chessman,
  a3.color as a3_color,
  a3.chessman as a3_chessman,
  b3.color as b3_color,
  b3.chessman as b3_chessman,
  c3.color as c3_color,
  c3.chessman as c3_chessman,
  d3.color as d3_color,
  d3.chessman as d3_chessman,
  e3.color as e3_color,
  e3.chessman as e3_chessman,
  f3.color as f3_color,
  f3.chessman as f3_chessman,
  g3.color as g3_color,
  g3.chessman as g3_chessman,
  h3.color as h3_color,
  h3.chessman as h3_chessman,
  a4.color as a4_color,
  a4.chessman as a4_chessman,
  b4.color as b4_color,
  b4.chessman as b4_chessman,
  c4.color as c4_color,
  c4.chessman as c4_chessman,
  d4.color as d4_color,
  d4.chessman as d4_chessman,
  e4.color as e4_color,
  e4.chessman as e4_chessman,
  f4.color as f4_color,
  f4.chessman as f4_chessman,
  g4.color as g4_color,
  g4.chessman as g4_chessman,
  h4.color as h4_color,
  h4.chessman as h4_chessman,
  a5.color as a5_color,
  a5.chessman as a5_chessman,
  b5.color as b5_color,
  b5.chessman as b5_chessman,
  c5.color as c5_color,
  c5.chessman as c5_chessman,
  d5.color as d5_color,
  d5.chessman as d5_chessman,
  e5.color as e5_color,
  e5.chessman as e5_chessman,
  f5.color as f5_color,
  f5.chessman as f5_chessman,
  g5.color as g5_color,
  g5.chessman as g5_chessman,
  h5.color as h5_color,
  h5.chessman as h5_chessman,
  a6.color as a6_color,
  a6.chessman as a6_chessman,
  b6.color as b6_color,
  b6.chessman as b6_chessman,
  c6.color as c6_color,
  c6.chessman as c6_chessman,
  d6.color as d6_color,
  d6.chessman as d6_chessman,
  e6.color as e6_color,
  e6.chessman as e6_chessman,
  f6.color as f6_color,
  f6.chessman as f6_chessman,
  g6.color as g6_color,
  g6.chessman as g6_chessman,
  h6.color as h6_color,
  h6.chessman as h6_chessman,
  a7.color as a7_color,
  a7.chessman as a7_chessman,
  b7.color as b7_color,
  b7.chessman as b7_chessman,
  c7.color as c7_color,
  c7.chessman as c7_chessman,
  d7.color as d7_color,
  d7.chessman as d7_chessman,
  e7.color as e7_color,
  e7.chessman as e7_chessman,
  f7.color as f7_color,
  f7.chessman as f7_chessman,
  g7.color as g7_color,
  g7.chessman as g7_chessman,
  h7.color as h7_color,
  h7.chessman as h7_chessman,
  a8.color as a8_color,
  a8.chessman as a8_chessman,
  b8.color as b8_color,
  b8.chessman as b8_chessman,
  c8.color as c8_color,
  c8.chessman as c8_chessman,
  d8.color as d8_color,
  d8.chessman as d8_chessman,
  e8.color as e8_color,
  e8.chessman as e8_chessman,
  f8.color as f8_color,
  f8.chessman as f8_chessman,
  g8.color as g8_color,
  g8.chessman as g8_chessman,
  h8.color as h8_color,
  h8.chessman as h8_chessman
}           
  
  
  
 