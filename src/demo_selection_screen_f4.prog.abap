REPORT demo_selection_screen_f4.

PARAMETERS: p_carr_1 TYPE spfli-carrid,
            p_carr_2 TYPE spfli-carrid.

AT SELECTION-SCREEN ON VALUE-REQUEST FOR p_carr_2.
  CALL SCREEN 100 STARTING AT 10 5
                  ENDING   AT 50 10.

MODULE value_list OUTPUT.
  SUPPRESS DIALOG.
  LEAVE TO LIST-PROCESSING AND RETURN TO SCREEN 0.
  SET PF-STATUS space.
  NEW-PAGE NO-TITLE.
  WRITE 'Star Alliance' COLOR COL_HEADING.
  ULINE.
  p_carr_2 = 'AC '.
  WRITE: / p_carr_2 COLOR COL_KEY, 'Air Canada'.
  HIDE p_carr_2.
  p_carr_2 = 'LH '.
  WRITE: / p_carr_2 COLOR COL_KEY, 'Lufthansa'.
  HIDE p_carr_2.
  p_carr_2 = 'SAS'.
  WRITE: / p_carr_2 COLOR COL_KEY, 'SAS'.
  HIDE p_carr_2.
  p_carr_2 = 'THA'.
  WRITE: / p_carr_2 COLOR COL_KEY, 'Thai International'.
  HIDE p_carr_2.
  p_carr_2 = 'UA '.
  WRITE: / p_carr_2 COLOR COL_KEY, 'United Airlines'.
  HIDE p_carr_2.
  CLEAR p_carr_2.
ENDMODULE.

AT LINE-SELECTION.
  CHECK NOT p_carr_2 IS INITIAL.
  LEAVE TO SCREEN 0.
