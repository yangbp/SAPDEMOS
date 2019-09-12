CLASS cl_demo_amdp_call_amdp DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .
  PUBLIC SECTION.
    INTERFACES if_amdp_marker_hdb .
    CLASS-METHODS:
      increase_price
        IMPORTING
          VALUE(clnt)     TYPE sy-mandt
          VALUE(incprice) TYPE sflight-price
        RAISING cx_amdp_error.
  PROTECTED SECTION.
  PRIVATE SECTION.
    CLASS-METHODS:
      increase_price_amdp
        IMPORTING VALUE(clnt)     TYPE sy-mandt
                  VALUE(incprice) TYPE sflight-price
        RAISING cx_amdp_error.
ENDCLASS.



CLASS CL_DEMO_AMDP_CALL_AMDP IMPLEMENTATION.


  METHOD increase_price BY DATABASE PROCEDURE
                        FOR HDB LANGUAGE SQLSCRIPT
                        USING cl_demo_amdp_call_amdp=>increase_price_amdp.
    call "CL_DEMO_AMDP_CALL_AMDP=>INCREASE_PRICE_AMDP"(
      CLNT => :CLNT, INCPRICE => :INCPRICE );
  ENDMETHOD.


  METHOD increase_price_amdp BY DATABASE PROCEDURE
                             FOR HDB LANGUAGE SQLSCRIPT
                             USING sflight.
    update sflight set price = price + incprice
                 where mandt = clnt;
  ENDMETHOD.
ENDCLASS.
