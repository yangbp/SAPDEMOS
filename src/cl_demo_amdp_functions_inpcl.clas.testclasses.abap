*"* use this source file for your ABAP unit test classes

CLASS test_amdp DEFINITION FINAL
                FOR TESTING RISK LEVEL HARMLESS DURATION SHORT.
  PRIVATE SECTION.
    METHODS test FOR TESTING.
ENDCLASS.

CLASS test_amdp IMPLEMENTATION.
  METHOD test.
    IF NOT cl_abap_dbfeatures=>use_features(
      EXPORTING
        requested_features =
          VALUE #( ( cl_abap_dbfeatures=>call_amdp_method ) ) ).
      RETURN.
    ENDIF.
    TRY.
        NEW cl_demo_amdp_functions_inpcl( )->select_get_scarr_spfli(
          EXPORTING clnt   = sy-mandt
                    carrid = 'LH'
          IMPORTING scarr_spfli_tab = DATA(result1) ).
      CATCH cx_amdp_error.
        cl_aunit_assert=>fail(
          msg   = 'AMDP method call failed' ##no_text
          level = cl_aunit_assert=>critical ).
    ENDTRY.
    SELECT *
           FROM demo_cds_get_scarr_spfli_inpcl( carrid ='LH' )
           INTO TABLE @DATA(result2)
           ##db_feature_mode[amdp_table_function].
    cl_aunit_assert=>assert_equals(
              exp   = result1
              act   = result2
              msg   = 'Wrong result' ##no_text
              level = cl_aunit_assert=>critical ).
  ENDMETHOD.
ENDCLASS.
