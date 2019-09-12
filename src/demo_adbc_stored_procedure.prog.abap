REPORT demo_adbc_stored_procedure.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA incprice TYPE sflight-price.
    SELECT price
           FROM sflight
           ORDER BY carrid, connid, fldate
           INTO @DATA(price_before)
           UP TO 1 ROWS.
    ENDSELECT.
    cl_demo_input=>request( CHANGING field = incprice ).
    IF incprice IS INITIAL.
      RETURN.
    ENDIF.
    DATA(sql) = NEW cl_sql_statement( ).
    TRY.
        CASE substring( val = cl_db_sys=>dbsys_type len = 3 ).
          WHEN 'HDB'.
            TRY.
                sql->execute_ddl(
                  'DROP PROCEDURE abap_docu_demo_incprice' ).
              CATCH cx_sql_exception ##NO_HANDLER.
            ENDTRY.
            sql->execute_ddl(
               `CREATE PROCEDURE  `
            && `abap_docu_demo_incprice (IN inc DECIMAL(15,2)) AS `
            && `BEGIN `
            && `UPDATE sflight SET price = price + :inc`
            && `               WHERE mandt = '` && sy-mandt && `'; `
            && `END` ).
            sql->set_param( data_ref = REF #( incprice )
                            inout    = cl_sql_statement=>c_param_in ).
            sql->execute_procedure(
              proc_name = 'abap_docu_demo_incprice' ).
          WHEN 'ADA'.
            TRY.
                sql->execute_ddl(
                  'DROP PROCEDURE abap_docu_demo_incprice' ).
              CATCH cx_sql_exception ##NO_HANDLER.
            ENDTRY.
            DATA schema TYPE c LENGTH 256.
            CALL FUNCTION 'DB_DBSCHEMA_CURRENT'
                 IMPORTING dbschema = schema.
            sql->execute_ddl(
               `CREATE DBPROC abap_docu_demo_incprice `
            && `(IN inc VARCHAR(15)) AS `
            && `UPDATE `
            && cl_abap_dyn_prg=>check_whitelist_str(
                 val = schema
                 whitelist = `SAP` && sy-sysid ) && `.sflight `
            && `  SET price = price + TO_NUMBER(:inc)`
            && `  WHERE mandt = '` && sy-mandt && `'; ` ).
            DATA(char_incprice) = CONV string( incprice ).
            sql->set_param( data_ref = REF #( char_incprice )
                            inout    = cl_sql_statement=>c_param_in ).
            sql->execute_procedure(
              proc_name = 'abap_docu_demo_incprice' ).
          WHEN 'ORA'.
            sql->execute_ddl(
              `CREATE OR REPLACE PROCEDURE `
            && `abap_docu_demo_incprice (inc IN NUMBER) IS `
            && `BEGIN `
            && `UPDATE sflight SET price = price + inc`
            && `               WHERE mandt = '` && sy-mandt && `'; `
            && `END;` ).
            sql->set_param( data_ref = REF #( incprice )
                            inout    = cl_sql_statement=>c_param_in ).
            sql->execute_procedure(
              proc_name = 'abap_docu_demo_incprice' ).
          WHEN OTHERS.
            cl_demo_output=>display( `Example is not supported for `
                                     && sy-dbsys ).
            LEAVE PROGRAM.
        ENDCASE.
      CATCH cx_sql_exception cx_abap_not_in_whitelist INTO DATA(err).
        cl_demo_output=>display( err->get_text( ) ).
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
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
