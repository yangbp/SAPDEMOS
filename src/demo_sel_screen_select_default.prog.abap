REPORT demo_sel_screen_select_default.

DATA wa_spfli TYPE spfli.

SELECT-OPTIONS airline FOR wa_spfli-carrid
               DEFAULT 'AA'
                    TO 'LH'
                OPTION  nb
                  SIGN  i.
