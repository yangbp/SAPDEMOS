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
        NEW cl_demo_amdp( )->increase_price( clnt = sy-mandt
                                             inc  = '0.1' ) ##LITERAL.
      CATCH cx_amdp_error .
        cl_aunit_assert=>fail(
          msg   = 'AMDP method call failed' ##no_text
          level = cl_aunit_assert=>critical ).
    ENDTRY.

    TRY.
        NEW cl_demo_amdp( )->increase_price_client( inc  = '0.1' ) ##LITERAL.
      CATCH cx_amdp_error.
        cl_aunit_assert=>fail(
          msg   = 'AMDP method call failed' ##no_text
          level = cl_aunit_assert=>critical ).
    ENDTRY.

    TRY.
        NEW cl_demo_amdp( )->increase_price_cds_client( inc  = '0.1' ) ##LITERAL.
      CATCH cx_amdp_error.
        cl_aunit_assert=>fail(
          msg   = 'AMDP method call failed' ##no_text
          level = cl_aunit_assert=>critical ).
    ENDTRY.

  ENDMETHOD.
ENDCLASS.
