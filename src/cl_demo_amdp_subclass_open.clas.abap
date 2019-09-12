CLASS cl_demo_amdp_subclass_open DEFINITION
  PUBLIC
  INHERITING FROM cl_demo_amdp_superclass
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS get_scarr REDEFINITION.
ENDCLASS.



CLASS CL_DEMO_AMDP_SUBCLASS_OPEN IMPLEMENTATION.


  METHOD get_scarr.
    SELECT *
           FROM scarr
           INTO TABLE @carriers.
  ENDMETHOD.
ENDCLASS.
