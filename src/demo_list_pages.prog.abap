*&---------------------------------------------------------------------*
*& Report  DEMO_LIST_PAGES
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT  DEMO_LIST_PAGES LINE-SIZE 60 LINE-COUNT 12(3).


TOP-OF-PAGE.

  WRITE: '------', ' Top-of-page', (3) sy-pagno, '------'.

END-OF-PAGE.

  WRITE: '------', ' End-of-page', (3) sy-pagno, '------'.


START-OF-SELECTION.

  DO 32 TIMES.
    IF sy-index = 7.
      WRITE:/ '"NEW-PAGE NO-TITLE"'.
      NEW-PAGE NO-TITLE.
    ENDIF.
    IF sy-index = 9.
      WRITE: / '"NEW-PAGE NO-HEADING"'.
      NEW-PAGE NO-HEADING.
    ENDIF.
    IF sy-index = 11.
      WRITE: / '"NEW-PAGE WITH-TITLE"'.
      NEW-PAGE WITH-TITLE.
    ENDIF.
    IF sy-index = 13.
      WRITE: / '"NEW-PAGE WITH-HEADING"'.
      NEW-PAGE WITH-HEADING.
    ENDIF.
    IF sy-index = 15.
      WRITE: / '"RESERVE 3 LINES"'.
      RESERVE 3 LINES.
    ENDIF.
    IF sy-index = 18.
      WRITE: / '"NEW-PAGE LINE-COUNT 15"'.
      NEW-PAGE LINE-COUNT 15.
    ENDIF.
    WRITE: /  sy-index.
  ENDDO.
