CLASS cl_demo_amdp_implement_open DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_demo_amdp_interface.
    ALIASES get_scarr FOR if_demo_amdp_interface~get_scarr.
ENDCLASS.



CLASS CL_DEMO_AMDP_IMPLEMENT_OPEN IMPLEMENTATION.


  METHOD get_scarr.
    SELECT *
           FROM scarr
           INTO TABLE @carriers.
  ENDMETHOD.
ENDCLASS.
