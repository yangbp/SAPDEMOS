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
    TRY.
        NEW cl_demo_amdp_l_hello_world(
              )->hello_world( EXPORTING text  = 'XYZ' ) ##LITERAL.
      CATCH cx_amdp_error.
        cl_aunit_assert=>fail(
          msg   = 'AMDP method call failed' ##no_text
          level = cl_aunit_assert=>critical ).
    ENDTRY.
  ENDMETHOD.
ENDCLASS.
