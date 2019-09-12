CLASS cl_demo_hana_session_variables DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_amdp_marker_hdb .

    TYPES:
      BEGIN OF session_variables,
        client     TYPE sy-mandt,
        cds_client TYPE sy-mandt,
        uname      TYPE sy-uname,
        langu      TYPE sy-langu,
        datum      TYPE sy-datum,
      END OF session_variables .

    METHODS get_session_variables_exec_sql
      RETURNING
        VALUE(session_variables) TYPE session_variables
      RAISING
        cx_sy_native_sql_error .
    METHODS get_session_variables_adbc
      RETURNING
        VALUE(session_variables) TYPE session_variables
      RAISING
        cx_sql_exception .
    METHODS get_session_variables_amdp
      EXPORTING
        VALUE(clnt)     TYPE session_variables-client
        VALUE(cds_clnt) TYPE session_variables-cds_client
        VALUE(unam)     TYPE session_variables-uname
        VALUE(lang)     TYPE session_variables-langu
        VALUE(date)     TYPE session_variables-datum
      RAISING
        cx_amdp_error .
ENDCLASS.



CLASS CL_DEMO_HANA_SESSION_VARIABLES IMPLEMENTATION.


  METHOD get_session_variables_adbc.
    DATA(result) = NEW cl_sql_statement( )->execute_query(
      `select SESSION_CONTEXT('CLIENT') from DUMMY` ).
    result->set_param( REF #( session_variables-client ) ).
    result->next( ).
    result = NEW cl_sql_statement( )->execute_query(
      `select SESSION_CONTEXT('CDS_CLIENT') from DUMMY` ).
    result->set_param( REF #( session_variables-cds_client ) ).
    result->next( ).
    result = NEW cl_sql_statement( )->execute_query(
      `select SESSION_CONTEXT('APPLICATIONUSER') from DUMMY` ).
    result->set_param( REF #( session_variables-uname ) ).
    result->next( ).
    result = NEW cl_sql_statement( )->execute_query(
      `select SESSION_CONTEXT('LOCALE_SAP') from DUMMY` ).
    result->set_param( REF #( session_variables-langu ) ).
    result->next( ).
    result = NEW cl_sql_statement( )->execute_query(
      `select SESSION_CONTEXT('SAP_SYSTEM_DATE') from DUMMY` ).
    result->set_param( REF #( session_variables-datum ) ).
    result->next( ).
  ENDMETHOD.


  METHOD get_session_variables_amdp
         BY DATABASE PROCEDURE FOR HDB
         LANGUAGE SQLSCRIPT.
    clnt := session_context('CLIENT');
    cds_clnt := session_context('CDS_CLIENT');
    unam := session_context('APPLICATIONUSER');
    lang := session_context('LOCALE_SAP');
    date := session_context('SAP_SYSTEM_DATE');
  ENDMETHOD.


  METHOD get_session_variables_exec_sql.
    EXEC SQL.
      select SESSION_CONTEXT('CLIENT')
             from DUMMY
             into :session_variables-client
    ENDEXEC.
    EXEC SQL.
      select SESSION_CONTEXT('CDS_CLIENT')
             from DUMMY
             into :session_variables-cds_client
    ENDEXEC.
    EXEC SQL.
      select SESSION_CONTEXT('APPLICATIONUSER')
             from DUMMY
             into :session_variables-uname
    ENDEXEC.
    EXEC SQL.
      select SESSION_CONTEXT('LOCALE_SAP')
             from DUMMY
             into :session_variables-langu
    ENDEXEC.
    EXEC SQL.
      select SESSION_CONTEXT('SAP_SYSTEM_DATE')
             from DUMMY
             into :session_variables-datum
    ENDEXEC.
  ENDMETHOD.
ENDCLASS.
