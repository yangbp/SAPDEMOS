REPORT demo_logical_database.

DATA wa_spfli TYPE spfli.
SELECTION-SCREEN BEGIN OF SCREEN 1100.
SELECT-OPTIONS s_carr FOR wa_spfli-carrid.
SELECTION-SCREEN END OF SCREEN 1100.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.

    DATA callback    TYPE TABLE OF ldbcb.

    DATA: seltab    TYPE TABLE OF rsparams,
          seltab_wa LIKE LINE OF seltab,
          scarr_wa  LIKE LINE OF s_carr.

    CALL SELECTION-SCREEN 1100 STARTING AT 10 10.
    IF sy-subrc <> 0.
      RETURN.
    ENDIF.

    callback = VALUE #( ( ldbnode     = 'SPFLI'
                          get         = 'X'
                          get_late    = 'X'
                          cb_prog     = sy-repid
                          cb_form     = 'CALLBACK_SPFLI' )
                        ( ldbnode     = 'SFLIGHT'
                          get         = 'X'
                          cb_prog     = sy-repid
                          cb_form     = 'CALLBACK_SFLIGHT' ) ).

    seltab_wa-kind = 'S'.
    seltab_wa-selname = 'CARRID'.
    LOOP AT s_carr INTO scarr_wa.
      MOVE-CORRESPONDING scarr_wa TO seltab_wa.
      APPEND seltab_wa TO seltab.
    ENDLOOP.

    CALL FUNCTION 'LDB_PROCESS'
      EXPORTING
        ldbname                     = 'F1S'
        variant                     = ' '
      TABLES
        callback                    = callback
        selections                  = seltab
      EXCEPTIONS
        OTHERS                      = 4.

    IF sy-subrc <> 0.
      WRITE: 'Exception with SY-SUBRC', sy-subrc.
    ENDIF.

  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).

FORM callback_spfli USING name  TYPE ldbn-ldbnode
                          wa    TYPE spfli
                          evt   TYPE c
                          check TYPE c.
  CASE evt.
    WHEN 'G'.
      WRITE: / wa-carrid, wa-connid, wa-cityfrom, wa-cityto.
      ULINE.
    WHEN 'L'.
      ULINE.
  ENDCASE.
ENDFORM.

FORM callback_sflight USING name  TYPE ldbn-ldbnode
                            wa    TYPE sflight
                            evt   TYPE c
                            check TYPE c.
  WRITE: / wa-fldate, wa-seatsocc, wa-seatsmax.
ENDFORM.
