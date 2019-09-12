CLASS cl_demo_amdp DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_amdp_marker_hdb .

    METHODS increase_price
      IMPORTING
        VALUE(clnt) TYPE sy-mandt
        VALUE(inc)  TYPE sflight-price
      RAISING
        cx_amdp_error.

    METHODS increase_price_client
      IMPORTING
        VALUE(inc) TYPE sflight-price
      RAISING
        cx_amdp_error.

    METHODS increase_price_cds_client
      AMDP OPTIONS CDS SESSION CLIENT current
      IMPORTING
        VALUE(inc) TYPE sflight-price
      RAISING
        cx_amdp_error.
ENDCLASS.



CLASS CL_DEMO_AMDP IMPLEMENTATION.


  METHOD increase_price BY DATABASE PROCEDURE FOR HDB
                           LANGUAGE SQLSCRIPT
                           USING sflight.
    update sflight set price = price + :inc
                   where mandt = :clnt;
  ENDMETHOD.


  METHOD increase_price_cds_client BY DATABASE PROCEDURE FOR HDB
                                   LANGUAGE SQLSCRIPT
                                   USING sflight.
    update sflight set price = price + :inc
                   where mandt = SESSION_CONTEXT('CDS_CLIENT');
  ENDMETHOD.


  METHOD increase_price_client BY DATABASE PROCEDURE FOR HDB
                               LANGUAGE SQLSCRIPT
                               USING sflight.
    update sflight set price = price + :inc
                   where mandt = SESSION_CONTEXT('CLIENT');
  ENDMETHOD.
ENDCLASS.
