*"* use this source file for your ABAP unit test classes

CLASS test_amdp DEFINITION FINAL
                FOR TESTING RISK LEVEL HARMLESS DURATION SHORT.
  PRIVATE SECTION.
    METHODS test FOR TESTING.
ENDCLASS.

CLASS test_amdp IMPLEMENTATION.
  METHOD test.
    IF cl_db_sys=>is_in_memory_db = abap_false.
      RETURN.
    ENDIF.

    DATA(oref) = NEW cl_demo_hana_session_variables( ).

    TRY.
        DATA(result_exec_sql) =
          oref->get_session_variables_exec_sql( ).
      CATCH cx_sy_native_sql_error INTO DATA(exec_sql_exc).
        cl_aunit_assert=>fail(
          msg   = 'Exec SQL failed' ##no_text
          level = cl_aunit_assert=>critical ).
    ENDTRY.

    TRY.
        DATA(result_adbc) =
          oref->get_session_variables_adbc( ).
      CATCH cx_sql_exception INTO DATA(adbc_exc).
        cl_aunit_assert=>fail(
          msg   = 'ADBC failed' ##no_text
          level = cl_aunit_assert=>critical ).
    ENDTRY.

    TRY.
        DATA result_amdp
         TYPE cl_demo_hana_session_variables=>session_variables.
        oref->get_session_variables_amdp(
                IMPORTING clnt = result_amdp-client
                          unam = result_amdp-uname
                          lang = result_amdp-langu ).
      CATCH cx_amdp_error INTO DATA(amdp_exc).
        cl_aunit_assert=>fail(
          msg   = 'AMDP failed' ##no_text
          level = cl_aunit_assert=>critical ).
    ENDTRY.

  ENDMETHOD.
ENDCLASS.
