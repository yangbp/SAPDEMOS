CLASS cl_demo_amdp_connection DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_amdp_marker_hdb .
    TYPES t_carriers TYPE STANDARD TABLE OF scarr WITH EMPTY KEY.
    METHODS get_scarr
      IMPORTING
                VALUE(connection) TYPE dbcon_name DEFAULT 'DEFAULT'
                VALUE(clnt)       TYPE sy-mandt
      EXPORTING VALUE(carriers)   TYPE t_carriers
      RAISING   cx_amdp_error.
ENDCLASS.



CLASS CL_DEMO_AMDP_CONNECTION IMPLEMENTATION.


  METHOD get_scarr BY DATABASE PROCEDURE FOR HDB
                        LANGUAGE SQLSCRIPT
                        USING scarr.
    carriers  = select *
                       from scarr
                       WHERE mandt  = clnt;
  ENDMETHOD.
ENDCLASS.
