INTERFACE if_demo_amdp_interface
  PUBLIC.
  INTERFACES if_amdp_marker_hdb .
  TYPES t_carriers TYPE STANDARD TABLE OF scarr WITH EMPTY KEY.
  METHODS get_scarr
    IMPORTING
              VALUE(clnt)       TYPE sy-mandt   DEFAULT '000'
    EXPORTING VALUE(carriers)   TYPE t_carriers
    RAISING   cx_amdp_error.
ENDINTERFACE.
