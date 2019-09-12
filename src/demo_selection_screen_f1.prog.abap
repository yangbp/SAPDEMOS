REPORT demo_selection_screen_f1.

PARAMETERS: p_carr_1 TYPE s_carr_id,
            p_carr_2 TYPE spfli-carrid.

AT SELECTION-SCREEN ON HELP-REQUEST FOR p_carr_2.
  CALL SCREEN 100 STARTING AT 10 5
                  ENDING   AT 60 10.
