REPORT demo_cds_decimal_shift.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
  PRIVATE SECTION.
    CLASS-METHODS setup.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA(out) = cl_demo_output=>new( ).

    setup( ).

      TRY.
          SELECT *
                 FROM demo_cds_decimal_shift
                 ORDER BY id
                 INTO TABLE @DATA(result).
          out->write( result ).
        CATCH cx_sy_open_sql_db INTO DATA(exc).
          out->write( exc->get_text( ) ).
      ENDTRY.

    out->display( ).
  ENDMETHOD.
  METHOD setup.
    DELETE FROM demo_prices.
    INSERT demo_prices FROM TABLE @( VALUE #(
      ( id = 1 amount = '1.23'    currency = 'USD' )
      ( id = 2 amount = '12.34'   currency = 'USD' )
      ( id = 3 amount = '123.45'  currency = 'USD' )
      ( id = 4 amount = '1234.56' currency = 'USD' ) ) ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
