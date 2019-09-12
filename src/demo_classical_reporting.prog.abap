REPORT DEMO_CLASSICAL_REPORTING.

DATA: carrid TYPE scarr-carrid,
      url    TYPE scarr-url.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS:
      main,
      detail  IMPORTING carrid TYPE scarr-carrid,
      browser IMPORTING url    TYPE csequence.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA scarr_wa TYPE scarr.
    SET PF-STATUS space.
    ULINE (80).
    SELECT *
           FROM scarr
           INTO @scarr_wa.
      WRITE: /  '|', (36) scarr_wa-carrname
                          COLOR COL_HEADING,
             40 '|', (36) scarr_wa-url
                          COLOR COL_TOTAL, 80 '|'.
      carrid = scarr_wa-carrid.
      url    = scarr_wa-url.
      HIDE: carrid, url.
    ENDSELECT.
    ULINE /(80).
    CLEAR: carrid, url.
  ENDMETHOD.
  METHOD detail.
    DATA spfli_wa TYPE spfli.
    WINDOW STARTING AT 10 10
           ENDING   AT 60 20.
    NEW-PAGE LINE-SIZE 50.
    FORMAT COLOR COL_NORMAL.
    SELECT carrid, connid, cityfrom, cityto
           FROM spfli
           WHERE carrid = @carrid
           INTO CORRESPONDING FIELDS OF @spfli_wa.
      WRITE: /(3)  spfli_wa-carrid,
              (4)  spfli_wa-connid,
              (20) spfli_wa-cityfrom,
              (20) spfli_wa-cityto.
    ENDSELECT.
    IF sy-subrc <> 0.
      MESSAGE e007(sabapdemos).
    ENDIF.
  ENDMETHOD.
  METHOD browser.
    cl_ABAP_browser=>show_url(
      EXPORTING
        url          =     url ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).

AT LINE-SELECTION.
  IF carrid IS NOT INITIAL.
    IF sy-cucol < 40.
      demo=>detail( carrid ).
    ELSEIF sy-cucol > 40.
      demo=>browser( url ).
    ENDIF.
    CLEAR: carrid, url.
  ENDIF.
