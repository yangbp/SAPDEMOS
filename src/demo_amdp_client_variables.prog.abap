REPORT demo_amdp_client_variables.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    IF NOT cl_abap_dbfeatures=>use_features(
          EXPORTING
            requested_features =
              VALUE #( ( cl_abap_dbfeatures=>call_amdp_method )
                       ( cl_abap_dbfeatures=>amdp_table_function ) ) ).
      cl_demo_output=>display(
        `System does not support AMDP or CDS table functions` ).
      RETURN.
    ENDIF.

    SELECT mandt
           FROM t000
           WHERE mandt <> @sy-mandt
           ORDER BY mandt
           INTO (@DATA(clnt))
           UP TO 1 ROWS.
    ENDSELECT.
    IF sy-subrc <> 0.
      cl_demo_output=>write( 'No other client available' ).
      clnt = sy-mandt.
    ENDIF.

    SELECT *
           FROM demo_cds_get_client_variables USING CLIENT @clnt
           INTO TABLE @DATA(result)
           ##db_feature_mode[amdp_table_function].

    cl_demo_output=>display( result ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
