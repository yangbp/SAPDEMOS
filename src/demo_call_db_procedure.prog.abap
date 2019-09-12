REPORT demo_call_db_procedure.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
  PRIVATE SECTION.
    CONSTANTS proc_name TYPE if_dbproc_proxy_basic_types=>ty_db_name
                        VALUE `ABAP_DOCU_DEMO_INCPRICE`.
    CONSTANTS prox_name TYPE if_dbproc_proxy_basic_types=>ty_abap_name
                        VALUE `ABAP_DOCU_DEMO_INCPRICE_PROXY`.
    CLASS-METHODS create_db_procedure.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA incprice     TYPE sflight-price.

    IF NOT cl_abap_dbfeatures=>use_features(
             EXPORTING
               requested_features =
                 VALUE #( (
                  cl_abap_dbfeatures=>call_database_procedure ) ) ).
      cl_demo_output=>display(
        `Current database does not support CALL DATABASE PROCEDURE` ).
      LEAVE PROGRAM.
    ENDIF.

    cl_demo_input=>request( CHANGING field = incprice ).
    IF incprice IS INITIAL.
      RETURN.
    ENDIF.

    SELECT price
           FROM sflight
           ORDER BY carrid, connid, fldate
           INTO @DATA(price_before)
           UP TO 1 ROWS.
    ENDSELECT.

    create_db_procedure( ).

    DATA(params) =
      VALUE if_dbproc_proxy_basic_types=>ty_param_override_t(
        ( db_name   = 'INC'
          abap_name = 'INCREASE'
          descr     = cl_abap_typedescr=>describe_by_name(
                        'SFLIGHT-PRICE' ) ) ).

    TRY.
        DATA(api) = cl_dbproc_proxy_factory=>get_proxy_public_api(
          if_proxy_name = prox_name ).
        api->delete( ).
        api->create_proxy( EXPORTING
                             if_proc_schema    = '_SYS_BIC'
                             it_param_override = params
                             if_proc_name      = proc_name ).
        COMMIT CONNECTION default.
        TRY.
            CALL DATABASE PROCEDURE (prox_name)
              EXPORTING increase = incprice.
          CATCH cx_sy_db_procedure_sql_error INTO DATA(db_exc).
            cl_demo_output=>display( db_exc->get_text( ) ).
            RETURN.
        ENDTRY.
        api->delete( ).
      CATCH cx_dbproc_proxy INTO DATA(api_exc).
        cl_demo_output=>display( api_exc->get_text( ) ).
        RETURN.
    ENDTRY.

    SELECT price
           FROM sflight
           ORDER BY carrid, connid, fldate
           INTO @DATA(price_after)
           UP TO 1 ROWS.
    ENDSELECT.
    IF price_after - price_before = incprice.
      cl_demo_output=>display( `Price increased succesfully` ).
    ENDIF.
  ENDMETHOD.
  METHOD create_db_procedure.
    DATA(sql) = NEW cl_sql_statement( ).
    TRY.
        sql->execute_ddl(
          `DROP PROCEDURE ` && `"_SYS_BIC"."` && proc_name && `"` ).
      CATCH cx_sql_exception ##NO_HANDLER.
    ENDTRY.
    TRY.
        sql->execute_ddl(
           `CREATE PROCEDURE  `
        && `"_SYS_BIC"."` && proc_name && `"`
        && ` (IN inc DECIMAL(15,2)) AS `
        && `BEGIN `
        && `UPDATE sflight SET price = price + :inc`
        && `               WHERE mandt = '` && sy-mandt && `'; `
        && `END` ).
      CATCH cx_sql_exception INTO DATA(err).
        cl_demo_output=>display( err->get_text( ) ).
    ENDTRY.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
