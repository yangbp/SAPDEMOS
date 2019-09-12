REPORT demo_amdp_session_client.

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

    DATA(client) = sy-mandt.
    cl_demo_input=>request( CHANGING field = client ).

    NEW cl_demo_amdp_session_client(
      )->get_spfli_view(
           EXPORTING clnt        = client
           IMPORTING connections = DATA(result) ).

    cl_demo_output=>display( result ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
