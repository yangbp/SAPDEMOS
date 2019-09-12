REPORT demo_amdp_call_amdp_procedure.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA incprice TYPE sflight-price.

    IF NOT cl_abap_dbfeatures=>use_features(
          EXPORTING
            requested_features =
              VALUE #( ( cl_abap_dbfeatures=>call_amdp_method ) ) ).
      cl_demo_output=>display(
        `Current database system does not support AMDP procedures` ).
      RETURN.
    ENDIF.

    cl_demo_input=>request( CHANGING field = incprice ).
    IF incprice IS INITIAL.
      RETURN.
    ENDIF.

    SELECT price
           FROM sflight
           ORDER BY carrid, connid, fldate
           INTO @DATA(price_before)
           UP TO 1 ROWS.
    ENDSELECT.

    TRY.
        cl_demo_amdp_call_amdp=>increase_price( clnt     = sy-mandt
                                                incprice = incprice ).
      CATCH cx_amdp_error INTO DATA(amdp_error).
        cl_demo_output=>display( amdp_error->get_text( ) ).
        RETURN.
    ENDTRY.


    SELECT price
           FROM sflight
           ORDER BY carrid, connid, fldate
           INTO @DATA(price_after)
           UP TO 1 ROWS.
    ENDSELECT.
    IF price_after - price_before = incprice.
      cl_demo_output=>display( `Price increased succesfully` ).
    ENDIF.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
