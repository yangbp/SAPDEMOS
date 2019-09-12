*"* use this source file for your ABAP unit test classes

CLASS test_memory DEFINITION FOR TESTING RISK LEVEL HARMLESS DURATION SHORT FINAL.
  PRIVATE SECTION.
    METHODS test_memory FOR TESTING.
ENDCLASS.

CLASS test_memory IMPLEMENTATION.
  METHOD test_memory.
    DATA mem TYPE REF TO  memory.
    CREATE OBJECT mem.
    mem->set( 10 ).
    cl_abap_unit_assert=>assert_equals(
        exp   =     10
        act   =     mem->get( )  ).
    mem->add( 10 ).
    cl_abap_unit_assert=>assert_equals(
        exp   =     20
        act   =     mem->get( )  ).
    mem->sub( 10 ).
    cl_abap_unit_assert=>assert_equals(
        exp   =     10
        act   =     mem->get( )  ).
    CREATE OBJECT mem.
    cl_abap_unit_assert=>assert_initial(
            act   =     mem->get( ) ).
  ENDMETHOD.
ENDCLASS.
