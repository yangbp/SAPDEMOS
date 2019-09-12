REPORT demo_adbc_ddl_dml.

PARAMETERS  p_name TYPE c LENGTH 10 DEFAULT 'mytab'.
SELECTION-SCREEN SKIP.
PARAMETERS: p_create RADIOBUTTON GROUP grp,
            p_insert RADIOBUTTON GROUP grp,
            p_select RADIOBUTTON GROUP grp,
            p_drop   RADIOBUTTON GROUP grp.
SELECTION-SCREEN SKIP.
PARAMETERS  p_key TYPE i DEFAULT 1.

CLASS adbc DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
  PRIVATE SECTION.
    CLASS-DATA: dbname TYPE string,
                wa1    TYPE c LENGTH 10,
                wa2    TYPE c LENGTH 10.
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
    DO 100 TIMES.
      wa1 = sy-index.
      wa2 = ipow( base = sy-index exp = 2 ).
      NEW cl_sql_statement( )->execute_update(
       `INSERT INTO ` && dbname && ` ` &&
      `VALUES ('` && wa1 && `','` && wa2 && `')` ).
    ENDDO.
  ENDMETHOD.
  METHOD select.
    DATA: msg TYPE c LENGTH 30,
          key TYPE c LENGTH 10.
    p_key = cl_abap_dyn_prg=>escape_quotes( CONV string( p_key ) ).
    key = p_key.
    DATA(result) = NEW cl_sql_statement( )->execute_query(
      `SELECT val1, val2 ` &&
      `FROM ` && dbname && ` ` &&
      `WHERE val1 = ` && `'` && key && `'` ).
    result->set_param( REF #( wa1 ) ).
    result->set_param( REF #( wa2 ) ).
    DATA(rc) = result->next( ).
    IF rc > 0.
      msg = |Result { wa1 }: { wa2 }|.
    ELSE.
      msg = 'No entry found'.
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
