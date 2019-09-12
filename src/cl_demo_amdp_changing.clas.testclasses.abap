*"* use this source file for your ABAP unit test classes

CLASS test_amdp DEFINITION FINAL
                FOR TESTING RISK LEVEL HARMLESS DURATION SHORT.
  PRIVATE SECTION.
    METHODS test FOR TESTING.
ENDCLASS.

CLASS test_amdp IMPLEMENTATION.
  METHOD test.
    DATA lower TYPE scarr-carrid VALUE 'AA'.
    DATA upper TYPE scarr-carrid VALUE 'BA'.
    DATA carriers TYPE cl_demo_amdp_changing=>t_carriers.

    IF NOT cl_abap_dbfeatures=>use_features(
      EXPORTING
        requested_features =
          VALUE #( ( cl_abap_dbfeatures=>call_amdp_method ) ) ).
      RETURN.
    ENDIF.

    SELECT mandt, carrid
           FROM scarr
           WHERE carrid BETWEEN @lower AND @upper
           ORDER BY mandt, carrid
           INTO CORRESPONDING FIELDS OF TABLE @carriers ##TOO_MANY_ITAB_FIELDS.

    TRY.
        NEW cl_demo_amdp_changing(
          )->get_carriers( CHANGING carriers = carriers ).
      CATCH cx_amdp_error.
        cl_aunit_assert=>fail(
          msg   = 'AMDP method call failed' ##no_text
          level = cl_aunit_assert=>critical ).
    ENDTRY.
    TRY.
        NEW cl_demo_amdp_changing(
          )->call_get_carriers( CHANGING carriers = carriers ).
      CATCH cx_amdp_error.
        cl_aunit_assert=>fail(
          msg   = 'AMDP method call failed' ##no_text
          level = cl_aunit_assert=>critical ).
    ENDTRY.
  ENDMETHOD.
ENDCLASS.
