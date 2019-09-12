CLASS cl_demo_call_hana_db_procedure DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_amdp_marker_hdb .

    TYPES:
      BEGIN OF connection,
        mandt  TYPE spfli-mandt,
        carrid TYPE spfli-carrid,
        connid TYPE spfli-connid,
      END OF connection .
    TYPES:
      connections TYPE HASHED TABLE OF connection WITH UNIQUE KEY carrid connid .
    TYPES:
      flights     TYPE SORTED TABLE OF sflight WITH UNIQUE KEY carrid connid fldate .

    METHODS constructor
      IMPORTING
        !carrid TYPE spfli-carrid .
    METHODS osql
      RETURNING
        VALUE(flights) TYPE flights .
    METHODS adbc
      RETURNING
        VALUE(flights) TYPE flights .
    METHODS cdbp
      RETURNING
        VALUE(flights) TYPE flights .
    METHODS amdp
      RETURNING
        VALUE(flights) TYPE flights .
  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA connection_tab TYPE connections.
    DATA api TYPE REF TO if_dbproc_proxy_public_api.
    METHODS amdp_meth IMPORTING VALUE(connections) TYPE connections
                      EXPORTING VALUE(flights)     TYPE flights.
    METHODS:
      setup,
      setup_proxy.
ENDCLASS.



CLASS CL_DEMO_CALL_HANA_DB_PROCEDURE IMPLEMENTATION.


  METHOD adbc.
    DATA(sql) = NEW cl_sql_statement( ).

    TRY.
        sql->execute_update( 'truncate table DEMO_ADBC_CONNECTIONS' ).
        sql->execute_ddl(    'drop table DEMO_ADBC_CONNECTIONS' ).
      CATCH cx_sql_exception ##no_handler.
    ENDTRY.

    TRY.
        sql->execute_ddl(
          `create global temporary row table DEMO_ADBC_CONNECTIONS ` &&
             `like DEMO_ADBC_CONNECTIONS_TYPE` ).
        sql->set_param_table( REF #( connection_tab ) ).
        sql->execute_update(
          |insert into DEMO_ADBC_CONNECTIONS values ( ?, ?, ? )| ).

        DATA(result) =
                sql->execute_query(
                  `call "/1BCAMDP/DEMO_ADBC_GET_FLIGHTS"( ` &&
                  `  CONNECTIONS =>DEMO_ADBC_CONNECTIONS, ` &&
                  `  FLIGHTS => NULL )` ).

        DATA flights_std TYPE STANDARD TABLE OF sflight WITH EMPTY KEY.
        result->set_param_table( REF #( flights_std ) ).
        result->next_package( ).
        result->close( ).
        flights = flights_std.

        sql->execute_update( 'truncate table DEMO_ADBC_CONNECTIONS' ).
        sql->execute_ddl(    'drop table DEMO_ADBC_CONNECTIONS' ).
      CATCH cx_sql_exception.
        CLEAR flights.
    ENDTRY.
  ENDMETHOD.


  METHOD amdp.
    amdp_meth( EXPORTING connections = connection_tab
               IMPORTING flights     = flights ).
  ENDMETHOD.


  METHOD amdp_meth BY DATABASE PROCEDURE FOR HDB LANGUAGE SQLSCRIPT.
    call "/1BCAMDP/DEMO_ADBC_GET_FLIGHTS"(
           CONNECTIONS => :CONNECTIONS,
           FLIGHTS => :FLIGHTS );
  ENDMETHOD.


  METHOD cdbp.
    TYPES:
      BEGIN OF connection,
        mandt  TYPE c LENGTH 3,
        carrid TYPE c LENGTH 3,
        connid TYPE c LENGTH 4,
      END OF connection.
    DATA connections TYPE STANDARD TABLE OF connection
                     WITH EMPTY KEY.
    connections = connection_tab.

    CALL DATABASE PROCEDURE ('DEMO_ADBC_GET_FLIGHTS_PROXY')
      EXPORTING connections = connections
      IMPORTING flights     = flights.

  ENDMETHOD.


  METHOD constructor.
    SELECT mandt, carrid, connid
      FROM spfli
      INTO CORRESPONDING FIELDS OF TABLE @connection_tab
      WHERE carrid = @carrid.
    setup( ).
  ENDMETHOD.


  METHOD osql.
    IF connection_tab IS NOT INITIAL.
      SELECT *
            FROM sflight
            FOR ALL ENTRIES IN @connection_tab
            WHERE carrid = @connection_tab-carrid AND
                  connid = @connection_tab-connid
            INTO TABLE @flights.
    ENDIF.
  ENDMETHOD.


  METHOD setup.
    "Create a table type and a database procedure on HANA
    "Normally, those would be available statically

    DATA(sql) = NEW cl_sql_statement( ).

    TRY.
        sql->execute_ddl(
          `drop procedure "/1BCAMDP/DEMO_ADBC_GET_FLIGHTS"` ).
      CATCH cx_sql_exception ##no_handler.
    ENDTRY.
    TRY.
        sql->execute_ddl(
          'drop type "DEMO_ADBC_CONNECTIONS_TYPE"' ).
      CATCH cx_sql_exception ##no_handler.
    ENDTRY.

    TRY.
        sql->execute_ddl(
          `create type "DEMO_ADBC_CONNECTIONS_TYPE" as table `  &&
          `( MANDT  NVARCHAR(3), `                              &&
            `CARRID NVARCHAR(3), `                              &&
            `CONNID NVARCHAR(4) )` ).

        sql->execute_ddl(
          `create procedure "/1BCAMDP/DEMO_ADBC_GET_FLIGHTS"  ` &&
          `  ( in CONNECTIONS DEMO_ADBC_CONNECTIONS_TYPE,  `    &&
          `    out FLIGHTS SFLIGHT ) language sqlscript as `    &&
          `      begin `                                        &&
          `        FLIGHTS = `                                  &&
          `          select * `                                 &&
          `            from SFLIGHT as S `                      &&
          `            where exists (  `                        &&
          `              select MANDT, CARRID, CONNID `         &&
          `                     from :CONNECTIONS as C`         &&
          `                     where C.MANDT  = S.MANDT and `  &&
          `                           C.CARRID = S.CARRID and ` &&
          `                           C.CONNID = S.CONNID ); `  &&
          `      end` ).

      CATCH cx_sql_exception.
        LEAVE PROGRAM.
    ENDTRY.
    setup_proxy(  ).
  ENDMETHOD.


  METHOD setup_proxy.
    "Create a database procedure proxy and its interface
    "Normally, those would be prepared in a framework or in ADT

    DATA db_schema TYPE if_dbproc_proxy_basic_types=>ty_db_name.
    CALL FUNCTION 'DB_DBSCHEMA_CURRENT'
         IMPORTING dbschema = db_schema.

    DATA(params) =
         VALUE if_dbproc_proxy_basic_types=>ty_param_override_t(
         ( db_name   = 'FLIGHTS'
           abap_name = 'FLIGHTS'
           descr     = cl_abap_typedescr=>describe_by_name(
                       'SFLIGHT' ) ) ).

    TRY.
        api = cl_dbproc_proxy_factory=>get_proxy_public_api(
         if_proxy_name = `DEMO_ADBC_GET_FLIGHTS_PROXY` ).
        api->delete( ).
        api = cl_dbproc_proxy_factory=>get_proxy_public_api(
          if_proxy_name = `DEMO_ADBC_GET_FLIGHTS_PROXY` ).
        api->create_proxy(
          EXPORTING
            if_proc_schema    = db_schema
            it_param_override = params
            if_proc_name      = '/1BCAMDP/DEMO_ADBC_GET_FLIGHTS' ).
         COMMIT CONNECTION default.
      CATCH cx_dbproc_proxy.
        LEAVE PROGRAM.
    ENDTRY.

  ENDMETHOD.
ENDCLASS.
