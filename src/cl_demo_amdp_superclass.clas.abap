CLASS cl_demo_amdp_superclass DEFINITION ABSTRACT
  PUBLIC
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_amdp_marker_hdb .
    TYPES t_carriers TYPE STANDARD TABLE OF scarr WITH EMPTY KEY.
    METHODS get_scarr ABSTRACT
      IMPORTING
                VALUE(clnt)       TYPE sy-mandt   DEFAULT '000'
      EXPORTING VALUE(carriers)   TYPE t_carriers
      RAISING   cx_amdp_error.
ENDCLASS.



CLASS CL_DEMO_AMDP_SUPERCLASS IMPLEMENTATION.
ENDCLASS.
