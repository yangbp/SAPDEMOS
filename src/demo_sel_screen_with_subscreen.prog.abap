REPORT demo_sel_screen_with_subscreen.

TABLES sscrfields.

* SUBSCREEN 1

SELECTION-SCREEN BEGIN OF SCREEN 100 AS SUBSCREEN.
SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE text-010.
PARAMETERS: p1(10) TYPE c,
            p2(10) TYPE c,
            p3(10) TYPE c.
SELECTION-SCREEN END OF BLOCK b1.
SELECTION-SCREEN END OF SCREEN 100.

* SUBSCREEN 2

SELECTION-SCREEN BEGIN OF SCREEN 200 AS SUBSCREEN.
SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME TITLE text-020.
PARAMETERS: q1(10) TYPE c,
            q2(10) TYPE c,
            q3(10) TYPE c.
SELECTION-SCREEN END OF BLOCK b2.
SELECTION-SCREEN END OF SCREEN 200.

* SUBSCREEN 3

SELECTION-SCREEN BEGIN OF SCREEN 300 AS SUBSCREEN.
SELECTION-SCREEN BEGIN OF BLOCK b3 WITH FRAME TITLE text-030.
PARAMETERS: r1(10) TYPE c,
            r2(10) TYPE c,
            r3(10) TYPE c.
SELECTION-SCREEN END OF BLOCK b3.
SELECTION-SCREEN END OF SCREEN 300.

* STANDARD SELECTION SCREEN

SELECTION-SCREEN: FUNCTION KEY 1,
                  FUNCTION KEY 2.

SELECTION-SCREEN: BEGIN OF TABBED BLOCK sub FOR 10 LINES,
                  END OF BLOCK sub.

INITIALIZATION.
  sscrfields-functxt_01 = '@0D@'.
  sscrfields-functxt_02 = '@0E@'.
  sub-prog = sy-repid.
  sub-dynnr = 100.

AT SELECTION-SCREEN.
  CASE sy-dynnr.
    WHEN 100.
      IF sscrfields-ucomm = 'FC01'.
        sub-dynnr = 300.
      ELSEIF sscrfields-ucomm = 'FC02'.
        sub-dynnr = 200.
      ENDIF.
    WHEN 200.
      IF sscrfields-ucomm = 'FC01'.
        sub-dynnr = 100.
      ELSEIF sscrfields-ucomm = 'FC02'.
        sub-dynnr = 300.
      ENDIF.
    WHEN 300.
      IF sscrfields-ucomm = 'FC01'.
        sub-dynnr = 200.
      ELSEIF sscrfields-ucomm = 'FC02'.
        sub-dynnr = 100.
      ENDIF.
  ENDCASE.

START-OF-SELECTION.
  WRITE: / 'P1:', p1,'Q1:', q1, 'R1:', r1,
         / 'P2:', p2,'Q2:', q2, 'R2:', r2,
         / 'P3:', p3,'Q3:', q3, 'R3:', r3.


