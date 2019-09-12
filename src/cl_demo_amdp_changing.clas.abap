class CL_DEMO_AMDP_CHANGING definition
  public
  final
  create public .

public section.

  interfaces IF_AMDP_MARKER_HDB .

  types:
    t_carriers TYPE STANDARD TABLE OF scarr WITH EMPTY KEY .

  methods GET_CARRIERS
    changing
      value(CARRIERS) type T_CARRIERS
    raising
      CX_AMDP_ERROR .
  methods CALL_GET_CARRIERS
    changing
      value(CARRIERS) type T_CARRIERS
    raising
      CX_AMDP_ERROR .
ENDCLASS.



CLASS CL_DEMO_AMDP_CHANGING IMPLEMENTATION.


  METHOD call_get_carriers BY DATABASE PROCEDURE FOR HDB
                              LANGUAGE SQLSCRIPT
                           USING cl_demo_amdp_changing=>get_carriers.
    call "CL_DEMO_AMDP_CHANGING=>GET_CARRIERS"(
      CARRIERS__IN__  => :CARRIERS,
      CARRIERS        => :CARRIERS );
  ENDMETHOD.


  METHOD get_carriers BY DATABASE PROCEDURE FOR HDB
                         LANGUAGE SQLSCRIPT
                      USING scarr.
    carriers  = select s.*
                     from scarr as s
                     inner join :carriers as c
                       on s.mandt  = c.mandt and
                          s.carrid = c.carrid;
  ENDMETHOD.
ENDCLASS.
