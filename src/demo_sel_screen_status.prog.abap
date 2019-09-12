REPORT demo_sel_screen_status .

DATA itab TYPE TABLE OF sy-ucomm.

PARAMETERS test(10) TYPE c.

AT SELECTION-SCREEN OUTPUT.

  itab = VALUE #( ( CONV sy-ucomm( 'PRIN' ) )
                  ( CONV sy-ucomm( 'SPOS' ) ) ).

  CALL FUNCTION 'RS_SET_SELSCREEN_STATUS'
       EXPORTING
            p_status  = sy-pfkey
       TABLES
            p_exclude = itab.
