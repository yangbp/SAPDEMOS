REPORT demo_sqlscript_curr_conv.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
  PRIVATE SECTION.
    CLASS-METHODS setup.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA(out) = cl_demo_output=>new( ).

    DATA currency TYPE c LENGTH 5 VALUE 'USD'.
    cl_demo_input=>request( CHANGING field = currency ).
    setup( ).

    SELECT *
           FROM demo_prices
           ORDER BY id
           INTO TABLE @DATA(original_prices).

    out->begin_section( `Original Prices`
      )->write( original_prices ).

    IF cl_abap_dbfeatures=>use_features(
          EXPORTING
            requested_features =
              VALUE #( ( cl_abap_dbfeatures=>call_amdp_method ) ) ).
      NEW cl_demo_sqlscript_curr_conv(
        )->convert(
          EXPORTING
            to_currency      = to_upper( currency )
            mandt            = sy-mandt
            date             = sy-datlo ).
    ELSE.
      NEW cl_demo_sqlscript_curr_conv(
        )->abap_convert(
          EXPORTING
            to_currency      = to_upper( currency )
            mandt            = sy-mandt
            date             = sy-datlo ).
    ENDIF.

    SELECT *
           FROM demo_prices
           ORDER BY id
           INTO TABLE @DATA(converted_prices).

    out->next_section( `Converted Prices`
      )->write( converted_prices
      )->display( ).

  ENDMETHOD.
  METHOD setup.
    DELETE FROM demo_prices.
    INSERT demo_prices FROM TABLE @( VALUE #(
      ( id = 1 amount = '1.00' currency = 'EUR' )
      ( id = 2 amount = '1.00' currency = 'GBP' )
      ( id = 3 amount = '1.00' currency = 'JPY' )
      ( id = 4 amount = '1.00' currency = 'USD' ) ) ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
