REPORT demo_adbc_ddl_dml_binding.

PARAMETERS  p_name TYPE c LENGTH 10 DEFAULT 'mytab'.
SELECTION-SCREEN SKIP.
PARAMETERS: p_create RADIOBUTTON GROUP grp,
            p_insert RADIOBUTTON GROUP grp,
            p_select RADIOBUTTON GROUP grp,
            p_drop   RADIOBUTTON GROUP grp.
SELECTION-SCREEN SKIP.
PARAMETERS  p_key TYPE i DEFAULT 1.
SELECTION-SCREEN SKIP.
SELECTION-SCREEN ULINE.
PARAMETERS: p_params RADIOBUTTON GROUP pgrp,
            p_struct RADIOBUTTON GROUP pgrp.

CLASS adbc DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
  PRIVATE SECTION.
    CLASS-DATA: dbname TYPE string,
                wa1    TYPE c LENGTH 10,
                wa2    TYPE c LENGTH 10,
                BEGIN OF wa,
                  col1 TYPE c LENGTH 10,
                  col2 TYPE c LENGTH 10,
                END OF wa,
                err TYPE REF TO cx_sql_exception.
    CLASS-METHODS: create RAISING cx_sql_exception,
      insert RAISING cx_sql_exception,
      select RAISING cx_sql_exception,
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
          insert( ).
          MESSAGE 'Insert was successful' TYPE 'S'.
        ELSEIF p_select = 'X'.
          select( ).
          MESSAGE 'Select was successful' TYPE 'S'.
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
    DO 100 TIMES.
      IF p_params = abap_true.
        sql->set_param( REF #( wa1 ) ).
        sql->set_param( REF #( wa2 ) ).
        wa1 = sy-index.
        wa2 = sy-index ** 2.
      ELSEIF p_struct = abap_true.
        sql->set_param_struct( REF #( wa ) ).
        wa-col1 = sy-index.
        wa-col2 = sy-index ** 2.
      ENDIF.
      sql->execute_update(
       `INSERT INTO ` && dbname && ` VALUES (?,?)` ).
    ENDDO.
  ENDMETHOD.
  METHOD select.
    DATA: msg TYPE c LENGTH 30,
          key TYPE c LENGTH 10.
    key = p_key.
    DATA(sql) = NEW cl_sql_statement( ).
    sql->set_param( REF #( key ) ).
    DATA(result) = sql->execute_query(
      `SELECT val1, val2 ` &&
      `FROM ` && dbname && ` ` &&
      `WHERE val1 = ?` ).
    IF p_params = abap_true.
      result->set_param( REF #( wa1 ) ).
      result->set_param( REF #( wa2 ) ).
      DATA(rc1) = result->next( ).
      IF rc1 > 0.
        msg = |Result { wa1 }: { wa2 }|.
      ELSE.
        msg = 'No entry found'.
      ENDIF.
    ELSEIF p_struct = abap_true.
      result->set_param_struct( REF #( wa ) ).
      DATA(rc2) = result->next( ).
      IF rc2 > 0.
        msg = |Result { wa-col1 }: { wa-col2 }|.
      ELSE.
        msg = 'No entry found'.
      ENDIF.
    ENDIF.
    result->close( ).
    MESSAGE msg TYPE 'I'.
  ENDMETHOD.
  METHOD drop.
    NEW cl_sql_statement( )->execute_ddl(
     `DROP TABLE ` && dbname ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  adbc=>main( ).
