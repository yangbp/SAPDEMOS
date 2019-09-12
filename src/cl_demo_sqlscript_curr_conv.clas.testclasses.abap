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
    DATA currency TYPE c LENGTH 5 VALUE 'USD'.
    DATA prices TYPE SORTED TABLE OF demo_prices
                WITH UNIQUE KEY id.
    prices = VALUE #(
      ( id = 1 amount = '1.00' currency = 'EUR' )
      ( id = 2 amount = '1.00' currency = 'GBP' )
      ( id = 3 amount = '1.00' currency = 'JPY' )
      ( id = 4 amount = '1.00' currency = 'USD' ) ).

    DELETE FROM demo_prices.
    INSERT demo_prices FROM TABLE prices.

    NEW cl_demo_sqlscript_curr_conv(
      )->convert(
        EXPORTING
          to_currency      = to_upper( currency )
          mandt            = sy-mandt
          date             = sy-datlo ).
    DATA converted_prices1 TYPE SORTED TABLE OF demo_prices
                           WITH UNIQUE KEY id.
    SELECT *
           FROM demo_prices
           INTO TABLE converted_prices1.

    DELETE FROM demo_prices.
    INSERT demo_prices FROM TABLE prices.

    NEW cl_demo_sqlscript_curr_conv(
      )->abap_convert(
        EXPORTING
          to_currency      = to_upper( currency )
          mandt            = sy-mandt
          date             = sy-datlo ).
    DATA converted_prices2 TYPE SORTED TABLE OF demo_prices
                           WITH UNIQUE KEY id.
    SELECT *
           FROM demo_prices
           INTO TABLE converted_prices2.

    IF converted_prices1 <> converted_prices2.
      cl_aunit_assert=>fail(
        msg = 'Wrong results'
        level = cl_aunit_assert=>tolerable ).
    ENDIF.

  ENDMETHOD.
ENDCLASS.
