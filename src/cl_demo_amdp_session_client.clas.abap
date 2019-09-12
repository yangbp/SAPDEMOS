CLASS cl_demo_amdp_session_client DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_amdp_marker_hdb .
    TYPES t_connections TYPE STANDARD TABLE OF demo_cds_prjct0a
                        WITH EMPTY KEY.
    METHODS get_spfli_view
      AMDP OPTIONS READ-ONLY
                   CDS SESSION CLIENT clnt
      IMPORTING VALUE(clnt)        TYPE sy-mandt
      EXPORTING VALUE(connections) TYPE t_connections
      RAISING   cx_amdp_error.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS CL_DEMO_AMDP_SESSION_CLIENT IMPLEMENTATION.


  METHOD get_spfli_view BY DATABASE PROCEDURE FOR HDB
                        LANGUAGE SQLSCRIPT
                        USING demo_cds_prjct0a.
    connections  = select *
                          from DEMO_CDS_PRJCT0A;
  ENDMETHOD.
ENDCLASS.
