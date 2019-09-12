REPORT demo_cds_currency_conversion.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
  PRIVATE SECTION.
    CLASS-DATA prices TYPE SORTED TABLE OF demo_prices
                      WITH UNIQUE KEY id.
    CLASS-METHODS setup.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA(out) = cl_demo_output=>new( ).

    DATA currency TYPE c LENGTH 5 VALUE 'USD'.
    cl_demo_input=>request( CHANGING field = currency ).
    currency = to_upper( currency ).
    setup( ).

    SELECT *
           FROM demo_prices
           ORDER BY id
           INTO TABLE @DATA(original_prices).

    out->begin_section( `Original Prices`
      )->write( original_prices
      )->next_section( `Converted Prices` ).

    TRY.
        SELECT *
               FROM demo_cds_curr_conv(
                      to_currency = @currency, exc_date = @sy-datlo )
               ORDER BY id
               INTO TABLE @DATA(converted_prices_cds).
        out->write( converted_prices_cds ).
      CATCH cx_sy_open_sql_db INTO DATA(exc).
        out->write( exc->get_text( ) ).
    ENDTRY.

    DATA converted_prices_abap LIKE converted_prices_cds.
    converted_prices_abap = CORRESPONDING #( prices ).
    LOOP AT converted_prices_abap ASSIGNING FIELD-SYMBOL(<price>).
      CALL FUNCTION 'CONVERT_TO_LOCAL_CURRENCY'
        EXPORTING
          client           = sy-mandt
          date             = sy-datlo
          foreign_amount   = <price>-amount
          foreign_currency = <price>-currency
          local_currency   = currency
        IMPORTING
          local_amount     = <price>-amount
        EXCEPTIONS
          OTHERS           = 4.
      IF sy-subrc <> 0.
        out->write( 'Error in function module' ).
      ENDIF.
      <price>-currency = currency.
    ENDLOOP.
    out->write( converted_prices_abap ).

    out->display( ).
  ENDMETHOD.
  METHOD setup.
    prices = VALUE #(
      ( id = 1 amount = '1.00' currency = 'EUR' )
      ( id = 2 amount = '1.00' currency = 'GBP' )
      ( id = 3 amount = '1.00' currency = 'JPY' )
      ( id = 4 amount = '1.00' currency = 'USD' ) ).

    DELETE FROM demo_prices.
    INSERT demo_prices FROM TABLE prices.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
