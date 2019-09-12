CLASS cl_demo_amdp_implement_hdb DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_demo_amdp_interface.
    ALIASES get_scarr FOR if_demo_amdp_interface~get_scarr.
ENDCLASS.



CLASS CL_DEMO_AMDP_IMPLEMENT_HDB IMPLEMENTATION.


  METHOD get_scarr BY DATABASE PROCEDURE FOR HDB
                        LANGUAGE SQLSCRIPT
                        USING scarr.
    carriers  = select *
                       from scarr
                       WHERE mandt  = clnt;
  ENDMETHOD.
ENDCLASS.
