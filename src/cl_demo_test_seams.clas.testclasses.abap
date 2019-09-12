*"* use this source file for your ABAP unit test classes

CLASS test_demo_test_seam DEFINITION FOR TESTING
                          RISK LEVEL HARMLESS
                          DURATION SHORT
                          FINAL.
  PRIVATE SECTION.
    METHODS: setup,
      test_change_price FOR TESTING,
      invoke_and_assert IMPORTING exp TYPE i.
ENDCLASS.

CLASS test_demo_test_seam IMPLEMENTATION.
  METHOD setup.
    TEST-INJECTION selection.
      wa-price = 100.
    END-TEST-INJECTION.
  ENDMETHOD.
  METHOD test_change_price.
    TEST-INJECTION modification.
    END-TEST-INJECTION.
    invoke_and_assert( 90 ).
    TEST-INJECTION modification.
      sy-subrc = 4.
    END-TEST-INJECTION.
    invoke_and_assert( -2 ).
    TEST-INJECTION selection.
      sy-subrc = 4.
    END-TEST-INJECTION.
    TEST-INJECTION modification.
    END-TEST-INJECTION.
    invoke_and_assert( -1 ).
  ENDMETHOD.
  METHOD invoke_and_assert.
    NEW cl_demo_test_seams( )->change_price(
      EXPORTING
         carrid = '   '
         connid = '0000'
         fldate = '00000000'
         factor = 90
       IMPORTING new_price = DATA(new_price) ).
    cl_abap_unit_assert=>assert_equals(
     EXPORTING
       exp = exp
       act = new_price  ).
  ENDMETHOD.
ENDCLASS.
