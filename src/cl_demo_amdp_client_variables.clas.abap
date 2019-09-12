CLASS cl_demo_amdp_client_variables DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_amdp_marker_hdb .

    CLASS-METHODS get
        FOR TABLE FUNCTION demo_cds_get_client_variables.

ENDCLASS.



CLASS CL_DEMO_AMDP_CLIENT_VARIABLES IMPLEMENTATION.


  METHOD get BY DATABASE FUNCTION FOR HDB
                LANGUAGE SQLSCRIPT
                OPTIONS READ-ONLY.
    declare client_tab table( mandt      "$ABAP.type( mandt )",
                              client     "$ABAP.type( mandt )",
                              cds_client "$ABAP.type( mandt )" );

    client_tab.mandt[1] := clnt;
    client_tab.client[1] := session_context('CLIENT');
    client_tab.cds_client[1] := session_context('CDS_CLIENT');

    RETURN :client_tab;
  ENDMETHOD.
ENDCLASS.
