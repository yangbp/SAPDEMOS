CLASS cl_demo_amdp_subclass_hdb DEFINITION
  PUBLIC
  INHERITING FROM cl_demo_amdp_superclass
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS get_scarr REDEFINITION.
ENDCLASS.



CLASS CL_DEMO_AMDP_SUBCLASS_HDB IMPLEMENTATION.


  METHOD get_scarr BY DATABASE PROCEDURE FOR HDB
                        LANGUAGE SQLSCRIPT
                        USING scarr.
    carriers  = select *
                       from scarr
                       WHERE mandt  = clnt;
  ENDMETHOD.
ENDCLASS.
