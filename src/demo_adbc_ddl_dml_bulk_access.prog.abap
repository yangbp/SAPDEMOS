REPORT demo_adbc_ddl_dml_bulk_access.

PARAMETERS  p_name TYPE c LENGTH 10 DEFAULT 'mytab'.
SELECTION-SCREEN SKIP.
PARAMETERS: p_create RADIOBUTTON GROUP grp,
            p_insert RADIOBUTTON GROUP grp,
            p_delete RADIOBUTTON GROUP grp,
            p_select RADIOBUTTON GROUP grp,
            p_drop   RADIOBUTTON GROUP grp.
SELECTION-SCREEN SKIP.
PARAMETERS  p_key TYPE i DEFAULT 10.

CLASS adbc DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
  PRIVATE SECTION.
    CLASS-DATA: dbname TYPE string,
                BEGIN OF wa,
                  col1 TYPE c LENGTH 10,
                  col2 TYPE c LENGTH 10,
                END OF wa,
                itab LIKE TABLE OF wa.
    CLASS-METHODS: create RAISING cx_sql_exception,
                   insert RETURNING VALUE(rc) TYPE i
                          RAISING cx_sql_exception,
                   delete RETURNING VALUE(rc) TYPE i
                          RAISING cx_sql_exception,
                   select RETURNING VALUE(rc) TYPE i
                          RAISING cx_sql_exception,
                   drop   RAISING cx_sql_exception.
ENDCLASS.

CLASS adbc IMPLEMENTATION.
  METHOD main.
    IF cl_abap_demo_services=>is_production_system( ).
      MESSAGE  'This demo cannot be executed in a production system'
               TYPE 'I' DISPLAY LIKE 'E'.
      LEAVE PROGRAM.
    ENDIF.
    TRY.
        dbname = 'ABAP_DOCU_DEMO_' &&
                 cl_abap_dyn_prg=>check_variable_name( p_name ).
      CATCH cx_abap_invalid_name INTO DATA(exc1).
        MESSAGE exc1 TYPE 'I' DISPLAY LIKE 'E'.
        RETURN.
    ENDTRY.
    TRY.
        IF p_create = 'X'.
          create( ).
          MESSAGE 'Create was successful' TYPE 'S'.
        ELSEIF p_insert = 'X'.
          DATA(rci) = insert( ).
          MESSAGE rci && ' lines inserted' TYPE 'S'.
        ELSEIF p_delete = 'X'.
          DATA(rcd) = delete( ).
          MESSAGE rcd && ' lines deleted' TYPE 'S'.
        ELSEIF p_select = 'X'.
          DATA(rcs) = select( ).
          MESSAGE rcs && ' lines selected' TYPE 'S'.
        ELSEIF p_drop   = 'X'.
          drop( ).
          MESSAGE 'Drop was successful' TYPE 'S'.
        ENDIF.
      CATCH cx_sql_exception INTO DATA(exc2).
        MESSAGE exc2 TYPE 'I' DISPLAY LIKE 'E'.
    ENDTRY.
  ENDMETHOD.
  METHOD create.
    NEW cl_sql_statement( )->execute_ddl(
      `CREATE TABLE ` && dbname   &&
      `( val1 char(10) NOT NULL,` &&
      `  val2 char(10) NOT NULL,` &&
      `  PRIMARY KEY (val1) )` ).
  ENDMETHOD.
  METHOD insert.
    DATA(sql) = NEW cl_sql_statement( ).
    sql->set_param_table( REF #( itab ) ).
    DO 50 TIMES.
      wa-col1 = sy-index.
      wa-col2 = ipow( base = sy-index exp = 2 ).
      APPEND wa TO itab.
    ENDDO.
    rc = sql->execute_update(
       `INSERT INTO ` && dbname && ` VALUES (?,?)` ).
  ENDMETHOD.
  METHOD delete.
    DATA itab LIKE TABLE OF wa-col1.
    DATA(sql) = NEW cl_sql_statement( ).
    sql->set_param_table( REF #( itab ) ).
    CLEAR itab.
    DO 10 TIMES.
      APPEND sy-index + p_key - 1 TO itab.
    ENDDO.
    rc = sql->execute_update(
       `DELETE FROM ` && dbname && ` WHERE val1 = ?`  ).
  ENDMETHOD.
  METHOD select.
    DATA(sql) = NEW cl_sql_statement( ).
    DATA(result) = sql->execute_query(
      `SELECT val1, val2 ` &&
      `FROM ` && dbname  ).
    result->set_param_table( itab_ref = REF #( itab ) ).
    rc = result->next_package( ).
    IF rc > 0.
      cl_abap_demo_services=>list_table( itab ).
    ENDIF.
    result->close( ).
  ENDMETHOD.
  METHOD drop.
    NEW cl_sql_statement( )->execute_ddl(
     `DROP TABLE ` && dbname ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  adbc=>main( ).
