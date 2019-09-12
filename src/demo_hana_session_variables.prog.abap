REPORT demo_hana_session_variables.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA(out) = cl_demo_output=>new( ).

    IF cl_db_sys=>is_in_memory_db = abap_false.
      out->display(
        `Example can be executed on SAP HANA Database only` ).
      LEAVE PROGRAM.
    ENDIF.

    DATA(oref) = NEW cl_demo_hana_session_variables( ).

    TRY.
        DATA(result_exec_sql) =
          oref->get_session_variables_exec_sql( ).
        out->write( result_exec_sql ).
      CATCH cx_sy_native_sql_error INTO DATA(exec_sql_exc).
        out->write( exec_sql_exc->get_text( ) ).
    ENDTRY.

    TRY.
        DATA(result_adbc) =
          oref->get_session_variables_adbc( ).
        out->write( result_adbc ).
      CATCH cx_sql_exception INTO DATA(adbc_exc).
        out->write( adbc_exc->get_text( ) ).
    ENDTRY.

    TRY.
        DATA result_amdp
         TYPE cl_demo_hana_session_variables=>session_variables.
        oref->get_session_variables_amdp(
                IMPORTING clnt     = result_amdp-client
                          cds_clnt = result_amdp-cds_client
                          unam     = result_amdp-uname
                          lang     = result_amdp-langu
                          date     = result_amdp-datum ).
        out->write( result_amdp ).
      CATCH cx_amdp_error INTO DATA(amdp_exc).
        out->write( amdp_exc->get_text( ) ).
    ENDTRY.

    out->display( ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
