CLASS cl_demo_amdp_abap_types DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_amdp_marker_hdb.
    TYPES:
      BEGIN OF line,
        mandt  TYPE sy-mandt,
        uname  TYPE sy-uname,
        langu  TYPE sy-langu,
        datum  TYPE sy-datum,
        text   TYPE c LENGTH 10,
        number TYPE f,
      END OF line,
      itab TYPE STANDARD TABLE OF line WITH EMPTY KEY.
    CLASS-METHODS demo_abap_types
      EXPORTING VALUE(itab) TYPE itab
      RAISING   cx_amdp_error.
ENDCLASS.



CLASS CL_DEMO_AMDP_ABAP_TYPES IMPLEMENTATION.


  METHOD demo_abap_types BY DATABASE PROCEDURE
                         FOR HDB LANGUAGE SQLSCRIPT.

    DECLARE mytab table( mandt  "$ABAP.type( mandt )",
                         uname  "$ABAP.type( syst_uname )",
                         langu  "$ABAP.type( syst_langu )",
                         datum  "$ABAP.type( syst_datum )",
                         text   "$ABAP.type( line-text )",
                         number "$ABAP.type( f )" );

    mytab.mandt[1]  := session_context('CLIENT');
    mytab.uname[1]  := session_context('APPLICATIONUSER');
    mytab.langu[1]  := session_context('LOCALE_SAP');
    mytab.datum[1]  := session_context('SAP_SYSTEM_DATE');
    mytab.text[1]   := cast( 0123456789 as "$ABAP.type( line-text )" );
    mytab.number[1] := 333 ;

    itab = select * from :mytab;
  ENDMETHOD.
ENDCLASS.
