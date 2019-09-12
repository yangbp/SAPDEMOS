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

    DATA connection TYPE dbcon_name VALUE 'R/3*my_conn'.

    TRY.
        NEW cl_demo_amdp_connection(
              )->get_scarr( EXPORTING
                              connection = connection
                              clnt       = sy-mandt ).

      CATCH cx_amdp_error.
        cl_aunit_assert=>fail(
          msg   = 'AMDP method call failed' ##no_text
          level = cl_aunit_assert=>critical ).
    ENDTRY.
  ENDMETHOD.
ENDCLASS.
