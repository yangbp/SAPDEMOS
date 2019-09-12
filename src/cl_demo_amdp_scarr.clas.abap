CLASS cl_demo_amdp_scarr DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_amdp_marker_hdb.
    TYPES
      scarr_tab TYPE STANDARD TABLE OF scarr WITH EMPTY KEY.

    METHODS select_scarr
      IMPORTING
                VALUE(clnt)      TYPE sy-mandt
      EXPORTING VALUE(scarr_tab) TYPE scarr_tab.
ENDCLASS.



CLASS CL_DEMO_AMDP_SCARR IMPLEMENTATION.


  METHOD select_scarr
         BY DATABASE PROCEDURE FOR HDB
         LANGUAGE SQLSCRIPT
         OPTIONS READ-ONLY
         USING scarr.
    scarr_tab =
    SELECT *
           FROM "SCARR"
           WHERE mandt = clnt
           ORDER BY carrid;
  ENDMETHOD.
ENDCLASS.
