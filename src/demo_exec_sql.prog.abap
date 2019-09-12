REPORT demo_exec_sql.

PARAMETERS: p_create RADIOBUTTON GROUP grp,
            p_insert RADIOBUTTON GROUP grp,
            p_select RADIOBUTTON GROUP grp,
            p_drop   RADIOBUTTON GROUP grp.
SELECTION-SCREEN SKIP.
PARAMETERS  p_key TYPE i DEFAULT 1.

CLASS native_sql DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
  PRIVATE SECTION.
    CLASS-DATA: wa1 TYPE c LENGTH 10,
                wa2 TYPE c LENGTH 10,
                err TYPE REF TO cx_sy_native_sql_error.
    CLASS-METHODS: create RAISING cx_sy_native_sql_error,
                   insert RAISING cx_sy_native_sql_error,
                   select RAISING cx_sy_native_sql_error,
                   drop   RAISING cx_sy_native_sql_error.
ENDCLASS.

CLASS native_sql IMPLEMENTATION.
  METHOD main.
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
      CATCH cx_sy_native_sql_error INTO err.
        MESSAGE err TYPE 'I' DISPLAY LIKE 'E'.
    ENDTRY.
  ENDMETHOD.
  METHOD create.
    EXEC SQL.
      CREATE TABLE abap_docu_demo_mytab (
               val1 char(10) NOT NULL,
               val2 char(10) NOT NULL,
               PRIMARY KEY (val1)      )
    ENDEXEC.
  ENDMETHOD.
  METHOD insert.
    DO 100 TIMES.
      wa1 = sy-index.
      wa2 = sy-index ** 2.
      EXEC SQL.
        INSERT INTO abap_docu_demo_mytab VALUES (:wa1, :wa2)
      ENDEXEC.
      IF sy-subrc <> 0.
        RAISE EXCEPTION TYPE cx_sy_native_sql_error
          EXPORTING
            textid = cx_sy_native_sql_error=>key_already_exists.
      ENDIF.
    ENDDO.
  ENDMETHOD.
  METHOD select.
    DATA: msg TYPE c LENGTH 30,
          key TYPE c LENGTH 10.
    p_key = cl_abap_dyn_prg=>escape_quotes( CONV string( p_key ) ).
    key = p_key.
    EXEC SQL.
      SELECT val1, val2
             INTO :wa1, :wa2
             FROM abap_docu_demo_mytab
             WHERE val1 = :key
    ENDEXEC.
    IF sy-subrc = 0.
      WRITE: 'Result:' TO msg,
             wa1 TO msg+10,
             wa2 TO msg+20.
    ELSE.
      msg = 'No entry found'.
    ENDIF.
    MESSAGE msg TYPE 'I'.
  ENDMETHOD.
  METHOD drop.
    EXEC SQL.
      DROP TABLE abap_docu_demo_mytab
    ENDEXEC.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  native_sql=>main( ).
