*"* use this source file for your ABAP unit test classes

CLASS test_demo DEFINITION FOR TESTING DURATION MEDIUM
  RISK LEVEL HARMLESS FINAL.
  PUBLIC SECTION.
  PRIVATE SECTION.
    METHODS test FOR TESTING.
ENDCLASS.

CLASS test_demo IMPLEMENTATION.
  METHOD test.
    IF cl_db_sys=>is_in_memory_db = abap_false.
      RETURN.
    ENDIF.

    DATA(oref) =
      NEW cl_demo_call_hana_db_procedure( to_upper( 'LH' ) ).

    DATA(osql_result) = oref->osql( ).
    DATA(adbc_result) = oref->adbc( ).
    DATA(cdbp_result) = oref->cdbp( ).
    DATA(amdp_result) = oref->amdp( ).

    IF NOT (
       osql_result = adbc_result AND
       osql_result = cdbp_result AND
       osql_result = amdp_result ).
      cl_aunit_assert=>fail(
          msg = 'Wrong results'
         level = cl_aunit_assert=>tolerable ).
    ENDIF.

  ENDMETHOD.
ENDCLASS.
