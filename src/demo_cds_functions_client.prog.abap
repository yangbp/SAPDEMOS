REPORT demo_cds_functions_client.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    IF NOT cl_abap_dbfeatures=>use_features(
          EXPORTING
            requested_features =
              VALUE #( ( cl_abap_dbfeatures=>amdp_table_function ) ) ).
      cl_demo_output=>display(
        `System does not support CDS table functions` ).
      RETURN.
    ENDIF.

    DATA carrid TYPE s_carr_id VALUE 'LH'.
    cl_demo_input=>request( CHANGING field = carrid ).
    carrid = to_upper( carrid ).

    SELECT *
           FROM demo_cds_get_scarr_spfli( carrid = @carrid )
           INTO TABLE @DATA(result1)
           ##db_feature_mode[amdp_table_function].
    cl_demo_output=>write( result1 ).

    SELECT *
           FROM demo_cds_get_scarr_spfli_inpcl( carrid = @carrid )
           INTO TABLE @DATA(result2)
           ##db_feature_mode[amdp_table_function].
    ASSERT result2 = result1.

    SELECT *
           FROM demo_cds_get_scarr_spfli( carrid = @carrid )
                CLIENT SPECIFIED demo_cds_get_scarr_spfli~client
           WHERE client = @sy-mandt
           INTO TABLE @DATA(result3)
           ##db_feature_mode[amdp_table_function].
    cl_demo_output=>display( result3 ).

  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
