CLASS cl_demo_amdp_functions_nocl DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_amdp_marker_hdb.
    TYPES:
      BEGIN OF scarr_spfli,
        carrname TYPE scarr-carrname,
        connid   TYPE spfli-connid,
        cityfrom TYPE spfli-cityfrom,
        cityto   TYPE spfli-cityto,
      END OF scarr_spfli,
      scarr_spfli_tab TYPE STANDARD TABLE OF scarr_spfli
                           WITH EMPTY KEY.

    METHODS select_get_scarr_spfli
      IMPORTING
                VALUE(clnt)            TYPE sy-mandt
                VALUE(carrid)          TYPE s_carr_id
      EXPORTING VALUE(scarr_spfli_tab) TYPE scarr_spfli_tab.

    CLASS-METHODS get_scarr_spfli_for_cds
                  FOR TABLE FUNCTION demo_cds_get_scarr_spfli_nocl.

  PRIVATE SECTION.
    METHODS get_scarr_spfli
      IMPORTING
                VALUE(clnt)            TYPE sy-mandt
                VALUE(carrid)          TYPE s_carr_id
      RETURNING VALUE(scarr_spfli_tab) TYPE scarr_spfli_tab.

ENDCLASS.



CLASS CL_DEMO_AMDP_FUNCTIONS_NOCL IMPLEMENTATION.


  METHOD get_scarr_spfli BY DATABASE FUNCTION FOR HDB
                         LANGUAGE SQLSCRIPT
                         OPTIONS READ-ONLY
                         USING scarr spfli.
    RETURN SELECT sc.carrname, sp.connid, sp.cityfrom, sp.cityto
                  FROM scarr AS sc
                    INNER JOIN spfli AS sp ON sc.mandt = sp.mandt AND
                                              sc.carrid = sp.carrid
                    WHERE sp.mandt = :clnt AND sp.carrid = :carrid
                    ORDER BY sc.carrname, sp.connid;

  ENDMETHOD.


  METHOD get_scarr_spfli_for_cds
         BY DATABASE FUNCTION FOR HDB
         LANGUAGE SQLSCRIPT
         OPTIONS READ-ONLY
         USING scarr spfli.
    RETURN SELECT sc.carrname, sp.connid, sp.cityfrom, sp.cityto
                  FROM scarr AS sc
                    INNER JOIN spfli AS sp ON sc.mandt = sp.mandt AND
                                              sc.carrid = sp.carrid
                    WHERE sp.mandt = :clnt AND sp.carrid = :carrid
                    ORDER BY sc.carrname, sp.connid;

  ENDMETHOD.


  METHOD select_get_scarr_spfli
         BY DATABASE PROCEDURE FOR HDB
         LANGUAGE SQLSCRIPT
         OPTIONS READ-ONLY
         USING cl_demo_amdp_functions_nocl=>get_scarr_spfli.
    SCARR_SPFLI_TAB =
      SELECT *
             FROM "CL_DEMO_AMDP_FUNCTIONS_NOCL=>GET_SCARR_SPFLI"(
                    clnt => :clnt,
                    carrid => :carrid );

  ENDMETHOD.
ENDCLASS.
