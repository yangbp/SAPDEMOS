CLASS cl_demo_sqlscript_curr_conv DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .
  PUBLIC SECTION.
    INTERFACES if_amdp_marker_hdb.
    TYPES:
      BEGIN OF price,
        amount   TYPE p LENGTH 8 DECIMALS 2,
        currency TYPE c LENGTH 5,
      END OF price,
      prices TYPE STANDARD TABLE OF price WITH EMPTY KEY.
    METHODS convert
      IMPORTING VALUE(to_currency) TYPE price-currency
                VALUE(mandt)       TYPE sy-mandt
                VALUE(date)        TYPE d.
    METHODS abap_convert
      IMPORTING VALUE(to_currency) TYPE price-currency
                VALUE(mandt)       TYPE sy-mandt
                VALUE(date)        TYPE d.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS CL_DEMO_SQLSCRIPT_CURR_CONV IMPLEMENTATION.


  METHOD abap_convert.
    DATA prices TYPE STANDARD TABLE OF demo_prices.
    SELECT *
           FROM demo_prices
           INTO TABLE prices.
    LOOP AT prices ASSIGNING FIELD-SYMBOL(<price>).
      CALL FUNCTION 'CONVERT_TO_LOCAL_CURRENCY'
        EXPORTING
          client           = mandt
          date             = date
          foreign_amount   = <price>-amount
          foreign_currency = <price>-currency
          local_currency   = to_currency
        IMPORTING
          local_amount     = <price>-amount
        EXCEPTIONS
          OTHERS           = 4.
      IF sy-subrc <> 0.
        CONTINUE.
      ENDIF.
      <price>-currency = to_currency.
    ENDLOOP.
    MODIFY demo_prices FROM table prices.
  ENDMETHOD.


  METHOD convert BY DATABASE PROCEDURE FOR HDB
                             LANGUAGE SQLSCRIPT
                             USING demo_prices.
    PRICES = select * from DEMO_PRICES;
    PRICES =
      CE_CONVERSION (
        :PRICES,
        [ family             = 'currency',
          method             = 'ERP',
          steps              = 'shift,convert,shift_back',
          target_unit        = :TO_CURRENCY,
          client             = :MANDT,
          source_unit_column = "CURRENCY",
          reference_date     = :DATE,
          output_unit_column = "CURRENCY",
          error_handling     = 'keep unconverted' ],
        [ amount AS amount ] );
     replace DEMO_PRICES select * from :PRICES;
  ENDMETHOD.
ENDCLASS.
