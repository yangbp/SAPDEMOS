CLASS cl_demo_from_adbc_to_amdp DEFINITION
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
      connections TYPE HASHED TABLE OF connection
                    WITH UNIQUE KEY carrid connid .
    TYPES:
      flights     TYPE SORTED TABLE OF sflight
                    WITH UNIQUE KEY carrid connid fldate .

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
    METHODS amdp_meth IMPORTING VALUE(connections) TYPE connections
                      EXPORTING VALUE(flights)     TYPE flights.
ENDCLASS.



CLASS CL_DEMO_FROM_ADBC_TO_AMDP IMPLEMENTATION.


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
          `( MANDT  NVARCHAR(3), `                                   &&
            `CARRID NVARCHAR(3), `                                   &&
            `CONNID NVARCHAR(4) )` ).

        sql->set_param_table( REF #( connection_tab ) ).
        sql->execute_update(
          |insert into DEMO_ADBC_CONNECTIONS values ( ?, ?, ? )| ).

        DATA(result) = sql->execute_query(
          `    select * `                                   &&
          `      from SFLIGHT as S `                        &&
          `      where exists (`                            &&
          `        select MANDT, CARRID, CONNID `           &&
          `               from  DEMO_ADBC_CONNECTIONS as C` &&
          `               where C.MANDT  = S.MANDT and `    &&
          `                     C.CARRID = S.CARRID and `   &&
          `                     C.CONNID = S.CONNID )` ).
        DATA std_flights TYPE STANDARD TABLE OF sflight WITH EMPTY KEY.
        result->set_param_table( REF #( std_flights ) ).
        result->next_package( ).
        result->close( ).
        flights = std_flights.

        sql->execute_update( 'truncate table DEMO_ADBC_CONNECTIONS' ).
        sql->execute_ddl( '   drop table DEMO_ADBC_CONNECTIONS' ).

      CATCH cx_sql_exception.
        CLEAR flights.
    ENDTRY.
  ENDMETHOD.


  METHOD amdp.
    amdp_meth( EXPORTING connections = connection_tab
               IMPORTING flights     = flights ).
  ENDMETHOD.


  METHOD amdp_meth BY DATABASE PROCEDURE FOR HDB
         LANGUAGE SQLSCRIPT OPTIONS READ-ONLY
         USING sflight.
    FLIGHTS = select *
                     from SFLIGHT as S
                     where exists ( select MANDT, CARRID, CONNID
                                           from :CONNECTIONS as C
                                           where C.MANDT  = S.MANDT and
                                                 C.CARRID = S.CARRID and
                                                 C.CONNID = S.CONNID );
  ENDMETHOD.


  METHOD cdbp.
    DATA(sql) = NEW cl_sql_statement( ).

    TRY.
        sql->execute_ddl( 'drop type DEMO_ADBC_CONNECTIONS_TYPE' ).
      CATCH cx_sql_exception ##no_handler.
    ENDTRY.
    TRY.
        sql->execute_ddl( `drop procedure DEMO_ADBC_GET_FLIGHTS` ).
      CATCH cx_sql_exception ##no_handler.
    ENDTRY.

    TRY.
        sql->execute_ddl(
          `create type DEMO_ADBC_CONNECTIONS_TYPE as table ` &&
          `( MANDT  NVARCHAR(3), `                           &&
            `CARRID NVARCHAR(3), `                           &&
            `CONNID NVARCHAR(4) )` ).
        sql->execute_ddl(
          `create procedure DEMO_ADBC_GET_FLIGHTS  `            &&
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
          `                           C.CONNID = S.CONNID );`   &&
          `      end` ).


        DATA db_schema TYPE if_dbproc_proxy_basic_types=>ty_db_name.
        CALL FUNCTION 'DB_DBSCHEMA_CURRENT'
          IMPORTING dbschema = db_schema.

        DATA(params) =
          VALUE if_dbproc_proxy_basic_types=>ty_param_override_t(
          ( db_name   = 'FLIGHTS'
            abap_name = 'FLIGHTS'
            descr     = cl_abap_typedescr=>describe_by_name(
                        'SFLIGHT' ) ) ).

        DATA(api) = cl_dbproc_proxy_factory=>get_proxy_public_api(
          if_proxy_name = 'DEMO_ADBC_GET_FLIGHTS_PROXY' ).
        api->delete( ).
        api->create_proxy( EXPORTING
                    if_proc_schema    = db_schema
                    it_param_override = params
                    if_proc_name      = 'DEMO_ADBC_GET_FLIGHTS' ).
        COMMIT CONNECTION default.

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

        COMMIT CONNECTION default.
        api->delete( ).
        sql->execute_ddl( `drop procedure DEMO_ADBC_GET_FLIGHTS` ).
        sql->execute_ddl( 'drop type DEMO_ADBC_CONNECTIONS_TYPE' ).
      CATCH cx_sql_exception cx_dbproc_proxy.
        CLEAR flights.
    ENDTRY.

  ENDMETHOD.


  METHOD constructor.
    SELECT mandt, carrid, connid
      FROM spfli
      INTO CORRESPONDING FIELDS OF TABLE @connection_tab
      WHERE carrid = @carrid.
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
ENDCLASS.
