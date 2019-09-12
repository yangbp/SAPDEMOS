REPORT demo_dynpros_and_lists NO STANDARD PAGE HEADING.

DATA: dynpro TYPE sy-dynnr,
      dynback LIKE dynpro.

dynpro = sy-dynnr.

PERFORM output.

CALL SCREEN 100.

MODULE list_100 OUTPUT.
  SET PF-STATUS 'LIST_100'.
  dynpro = sy-dynnr.
  LEAVE TO LIST-PROCESSING AND RETURN TO SCREEN 0.
  PERFORM output.
  LEAVE SCREEN.
ENDMODULE.

MODULE list_200 OUTPUT.
  SET PF-STATUS 'LIST_200'.
  dynpro = sy-dynnr.
  LEAVE TO LIST-PROCESSING AND RETURN TO SCREEN 0.
  PERFORM output.
  LEAVE SCREEN.
ENDMODULE.

MODULE list_300 OUTPUT.
  SET PF-STATUS 'LIST_300'.
  dynpro = sy-dynnr.
  LEAVE TO LIST-PROCESSING AND RETURN TO SCREEN 0.
  PERFORM output.
  LEAVE TO SCREEN dynback.
ENDMODULE.

AT LINE-SELECTION.
  PERFORM output.

AT USER-COMMAND.
  CASE sy-pfkey.
    WHEN 'LIST_100'.
      dynback = '0100'.
    WHEN 'LIST_200'.
      dynback = '0200'.
  ENDCASE.
  CASE sy-ucomm.
    WHEN 'LIST_200'.
      CALL SCREEN 200.
    WHEN 'LIST_300'.
      LEAVE SCREEN.
  ENDCASE.

FORM output.
  WRITE: text-010 COLOR = 2, dynpro   COLOR = 3,
       / text-020 COLOR = 2, sy-lsind COLOR = 3.
  SKIP.
  WRITE text-030 HOTSPOT COLOR = 5.
  HIDE dynpro.
ENDFORM.
