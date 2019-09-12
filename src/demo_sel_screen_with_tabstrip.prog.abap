REPORT demo_sel_screen_with_tabstrip.

DATA flag(1) TYPE c.

* SUBSCREEN 1

SELECTION-SCREEN BEGIN OF SCREEN 100 AS SUBSCREEN.
SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME.
PARAMETERS: p1(10) TYPE c,
            p2(10) TYPE c,
            p3(10) TYPE c.
SELECTION-SCREEN END OF BLOCK b1.
SELECTION-SCREEN END OF SCREEN 100.

* SUBSCREEN 2

SELECTION-SCREEN BEGIN OF SCREEN 200 AS SUBSCREEN.
SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME.
PARAMETERS: q1(10) TYPE c OBLIGATORY,
            q2(10) TYPE c OBLIGATORY,
            q3(10) TYPE c OBLIGATORY.
SELECTION-SCREEN END OF BLOCK b2.
SELECTION-SCREEN END OF SCREEN 200.

* STANDARD SELECTION SCREEN

SELECTION-SCREEN: BEGIN OF TABBED BLOCK mytab FOR 10 LINES,
                  TAB (20) button1 USER-COMMAND push1,
                  TAB (20) button2 USER-COMMAND push2,
                  TAB (20) button3 USER-COMMAND push3
                                   DEFAULT SCREEN 300,
                  END OF BLOCK mytab.

INITIALIZATION.
  button1 = text-010.
  button2 = text-020.
  button3 = text-030.
  mytab-prog = sy-repid.
  mytab-dynnr = 100.
  mytab-activetab = 'BUTTON1'.

AT SELECTION-SCREEN.
  CASE sy-dynnr.
    WHEN 1000.
      CASE sy-ucomm.
        WHEN 'PUSH1'.
          mytab-dynnr = 100.
          mytab-activetab = 'BUTTON1'.
        WHEN 'PUSH2'.
          mytab-dynnr = 200.
          mytab-activetab = 'BUTTON2'.
      ENDCASE.
    WHEN 100.
      MESSAGE s888(sabapdemos) WITH text-040 sy-dynnr.
    WHEN 200.
      MESSAGE s888(sabapdemos) WITH text-040 sy-dynnr.
  ENDCASE.

MODULE init_0100 OUTPUT.
  LOOP AT SCREEN INTO DATA(screen_wa).
    IF screen_wa-group1 = 'MOD'.
      CASE flag.
        WHEN 'X'.
          screen_wa-input = '1'.
        WHEN ' '.
          screen_wa-input = '0'.
      ENDCASE.
      MODIFY SCREEN FROM screen_wa.
    ENDIF.
  ENDLOOP.
ENDMODULE.

MODULE user_command_0100 INPUT.
  MESSAGE s888(sabapdemos) WITH text-050 sy-dynnr.
  CASE sy-ucomm.
    WHEN 'TOGGLE'.
      IF flag = ' '.
        flag = 'X'.
      ELSEIF flag = 'X'.
        flag = ' '.
      ENDIF.
  ENDCASE.
ENDMODULE.

START-OF-SELECTION.
  WRITE: / 'P1:', p1,'Q1:', q1,
         / 'P2:', p2,'Q2:', q2,
         / 'P3:', p3,'Q3:', q3.
