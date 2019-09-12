CLASS cl_demo_amdp_call DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_amdp_marker_hdb .

    CLASS-METHODS class_constructor .
    CLASS-METHODS increase_price
      IMPORTING
                VALUE(incprice) TYPE sflight-price
      RAISING   cx_amdp_error.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS CL_DEMO_AMDP_CALL IMPLEMENTATION.


  METHOD class_constructor.
    DATA(sql) = NEW cl_sql_statement( ).
    TRY.
        sql->execute_ddl(
          `DROP PROCEDURE ` && `"/1BCAMDP/ABAP_DOCU_DEMO_INCPRICE"` ).
      CATCH cx_sql_exception ##NO_HANDLER.
    ENDTRY.
    TRY.
        sql->execute_ddl(
           `CREATE PROCEDURE  `
        && `"/1BCAMDP/ABAP_DOCU_DEMO_INCPRICE"`
        && ` (IN inc DECIMAL(15,2)) AS `
        && `BEGIN `
        && `UPDATE sflight SET price = price + :inc`
        && `               WHERE mandt = '` && sy-mandt && `'; `
        && `END` ).
      CATCH cx_sql_exception INTO DATA(err).
        cl_demo_output=>display( err->get_text( ) ).
    ENDTRY.
  ENDMETHOD.


  METHOD increase_price BY DATABASE PROCEDURE FOR HDB LANGUAGE SQLSCRIPT.
    call "/1BCAMDP/ABAP_DOCU_DEMO_INCPRICE"( INC => :INCPRICE );
  ENDMETHOD.
ENDCLASS.
