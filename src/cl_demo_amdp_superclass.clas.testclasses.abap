*"* use this source file for your ABAP unit test classes

CLASS test_amdp DEFINITION FINAL
                FOR TESTING RISK LEVEL HARMLESS DURATION SHORT.
  PRIVATE SECTION.
    METHODS test FOR TESTING.
ENDCLASS.

CLASS test_amdp IMPLEMENTATION.
  METHOD test.
    DATA: iref TYPE REF TO if_demo_amdp_interface,
          cref TYPE REF TO cl_demo_amdp_superclass.

    IF cl_abap_dbfeatures=>use_features(
         EXPORTING
           requested_features =
             VALUE #( ( cl_abap_dbfeatures=>call_amdp_method ) ) ).
      cref = NEW cl_demo_amdp_subclass_hdb( ).
      iref = NEW cl_demo_amdp_implement_hdb( ).
    ELSE.
      cref = NEW cl_demo_amdp_subclass_open( ).
      iref = NEW cl_demo_amdp_implement_open( ).
    ENDIF.

    TRY.
        iref->get_scarr( EXPORTING clnt     = sy-mandt
                         IMPORTING carriers = DATA(result1) ).
        cref->get_scarr( EXPORTING clnt     = sy-mandt
                         IMPORTING carriers = DATA(result2) ).

      CATCH cx_amdp_error.
        cl_aunit_assert=>fail(
          msg   = 'AMDP method call failed' ##no_text
          level = cl_aunit_assert=>critical ).
    ENDTRY.

    cl_aunit_assert=>assert_equals(
           exp   = result1
           act   = result2
           msg   = 'Wrong result' ##no_text
           level = cl_aunit_assert=>critical ).
  ENDMETHOD.
ENDCLASS.
