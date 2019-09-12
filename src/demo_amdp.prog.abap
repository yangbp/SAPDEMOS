REPORT demo_amdp.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    IF NOT cl_abap_dbfeatures=>use_features(
          EXPORTING
            requested_features =
              VALUE #( ( cl_abap_dbfeatures=>call_amdp_method ) ) ).
      cl_demo_output=>display(
        `Current database system does not support AMDP procedures` ).
      RETURN.
    ENDIF.

    DATA incprice TYPE sflight-price VALUE '0.1'.
    DATA(client)     = abap_false.
    DATA(cds_client) = abap_false.
    cl_demo_input=>new(
      )->add_field( CHANGING
                      field = incprice
      )->add_field( EXPORTING
                      as_checkbox = abap_true
                      text        = `Use session variable CLIENT`
                    CHANGING
                      field = client
      )->add_field( EXPORTING
                      as_checkbox = abap_true
                      text        = `Use session variable CDS_CLIENT`
                    CHANGING
                      field = cds_client
      )->request( ).

    IF incprice IS INITIAL OR
       client IS NOT INITIAL AND cds_client IS NOT INITIAL.
      RETURN.
    ENDIF.

    SELECT price
           FROM sflight
           ORDER BY carrid, connid, fldate
           INTO @DATA(price_before)
           UP TO 1 ROWS.
    ENDSELECT.

    IF client IS INITIAL AND cds_client IS INITIAL.
      TRY.
          NEW cl_demo_amdp(
            )->increase_price( clnt = sy-mandt
                               inc  = incprice ).
        CATCH cx_amdp_error INTO DATA(amdp_error).
          cl_demo_output=>display( amdp_error->get_text( ) ).
          RETURN.
      ENDTRY.
    ELSEIF client IS NOT INITIAL.
      TRY.
          NEW cl_demo_amdp(
            )->increase_price_client( inc  = incprice ).
        CATCH cx_amdp_error INTO amdp_error.
          cl_demo_output=>display( amdp_error->get_text( ) ).
          RETURN.
      ENDTRY.
    ELSEIF cds_client IS NOT INITIAL.
      TRY.
          NEW cl_demo_amdp(
            )->increase_price_cds_client( inc  = incprice ).
        CATCH cx_amdp_error INTO amdp_error.
          cl_demo_output=>display( amdp_error->get_text( ) ).
          RETURN.
      ENDTRY.
    ENDIF.

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
