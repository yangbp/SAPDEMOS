*&---------------------------------------------------------------------*
*& Modulpool  SAPMSSLS                                                 *
*&---------------------------------------------------------------------*

PROGRAM  sapmdemo_selscreen_dynp.

SET EXTENDED CHECK OFF.

SELECTION-SCREEN BEGIN OF SCREEN 500 AS WINDOW.

  SELECTION-SCREEN BEGIN OF BLOCK sel1 WITH FRAME.
    PARAMETERS: cityfr LIKE spfli-cityfrom,
                cityto LIKE spfli-cityto.
  SELECTION-SCREEN END OF BLOCK sel1.

  SELECTION-SCREEN BEGIN OF BLOCK sel2 WITH FRAME.
    PARAMETERS: airpfr LIKE spfli-airpfrom,
              airpto LIKE spfli-airpto.
  SELECTION-SCREEN END OF BLOCK sel2.

SELECTION-SCREEN END OF SCREEN 500.

AT SELECTION-SCREEN.
   ...
   LEAVE TO SCREEN 100.
