REPORT demo_abap_unit.

CLASS test_demo DEFINITION DEFERRED.

*Productive Code

CLASS demo DEFINITION
           FRIENDS test_demo.
  PUBLIC SECTION.
    METHODS get_sum
      IMPORTING id TYPE demo_expressions-id.
  PRIVATE SECTION.
    DATA sum TYPE i.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD get_sum.
    SELECT SINGLE
           FROM demo_expressions
           FIELDS num1 + num2 AS sum
           WHERE id = @id
           INTO @sum.
  ENDMETHOD.
ENDCLASS.

*Test Code

CLASS test_demo DEFINITION
                FOR TESTING RISK LEVEL DANGEROUS
                            DURATION SHORT.
  PRIVATE SECTION.
    METHODS:
      setup,
      test_sum FOR TESTING,
      teardown.
    DATA:
      demo_ref TYPE REF TO demo.
ENDCLASS.

CLASS test_demo IMPLEMENTATION.
  METHOD setup.
    demo_ref = NEW #( ).
    DELETE FROM demo_expressions WHERE id = '@'.
    INSERT demo_expressions FROM @(
      VALUE #( id = '@' num1 = 100 num2 = 200 ) ).
  ENDMETHOD.
  METHOD test_sum.
    demo_ref->get_sum( '@' ).
    cl_abap_unit_assert=>assert_equals(
     act = demo_ref->sum
     exp = 300
     msg = `Wrong sum`
     quit = cl_aunit_assert=>no ).
  ENDMETHOD.
  METHOD teardown.
    DELETE FROM demo_expressions WHERE id = '@'.
  ENDMETHOD.
ENDCLASS.
