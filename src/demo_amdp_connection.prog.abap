REPORT demo_amdp_connection.

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

    DATA connection TYPE dbcon_name VALUE 'R/3*my_conn'.
    cl_demo_input=>request( CHANGING field = connection ).

    TRY.
        NEW cl_demo_amdp_connection(
              )->get_scarr( EXPORTING
                              connection = connection
                              clnt       = sy-mandt
                            IMPORTING
                              carriers = DATA(result) ).
      CATCH cx_amdp_error INTO DATA(amdp_error).
        cl_demo_output=>display( amdp_error->get_text( ) ).
        RETURN.
    ENDTRY.

    cl_demo_output=>display( result ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
