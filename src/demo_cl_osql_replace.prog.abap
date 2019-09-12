REPORT demo_cl_osql_replace.

CLASS prod DEFINITION.
  PUBLIC SECTION.
    TYPES scarr_tab TYPE SORTED TABLE OF scarr
                    WITH UNIQUE KEY carrid.
    CLASS-METHODS:
      select RETURNING VALUE(r) TYPE scarr_tab,
      delete IMPORTING carrid   TYPE scarr-carrid.
ENDCLASS.

CLASS prod IMPLEMENTATION.
  METHOD select.
    SELECT *
           FROM scarr
           INTO TABLE @r.
  ENDMETHOD.
  METHOD delete.
    DELETE FROM scarr WHERE carrid = @carrid.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  cl_demo_output=>display( prod=>select( ) ).

CLASS test_prod DEFINITION FOR TESTING
                RISK LEVEL HARMLESS
                DURATION SHORT.
  PRIVATE SECTION.
    DATA
      testdata TYPE prod=>scarr_tab.
    METHODS:
      test FOR TESTING,
      setup,
      teardown.
ENDCLASS.

CLASS test_prod IMPLEMENTATION.
  METHOD setup.
    DATA schema TYPE c LENGTH 256.
    CALL FUNCTION 'DB_DBSCHEMA_CURRENT'
      IMPORTING
        dbschema = schema.
    TRY.
        cl_osql_replace=>activate_replacement(
           EXPORTING
             flg_dml           = abap_true
             replacement_table =
               VALUE cl_osql_replace=>tt_replacement(
                ( source = 'SCARR'
                  target = 'DEMO_TEST_SCARR'
                  schema = schema ) ) ).
      CATCH cx_osql_replace.
        cl_abap_unit_assert=>fail(
          EXPORTING
            msg    = 'Replacement failed' ).
    ENDTRY.
    DELETE FROM demo_test_scarr.
    testdata = VALUE #(
      ( mandt    = sy-mandt
        carrid   = 'AAA' carrname = 'Aaaaa'
        currcode = 'EUR' url =      'aaaaa' )
      ( mandt    = sy-mandt
        carrid   = 'BBB' carrname = 'Bbbbb'
        currcode = 'EUR' url =      'bbbbb' ) ).
    INSERT demo_test_scarr FROM TABLE @testdata.
  ENDMETHOD.
  METHOD test.
    DATA(result) = prod=>select( ).
    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act                  = result
        exp                  = testdata
        msg                  = 'Assertion failed' ).
    prod=>delete( 'AAA' ).
    SELECT SINGLE @abap_true
           FROM demo_test_scarr
           WHERE carrid = 'AAA'
           INTO @DATA(flag).
    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act                  = flag
        exp                  = abap_false
        msg                  = 'Assertion failed' ).
  ENDMETHOD.
  METHOD teardown.
    DELETE FROM demo_test_scarr.
  ENDMETHOD.
ENDCLASS.
