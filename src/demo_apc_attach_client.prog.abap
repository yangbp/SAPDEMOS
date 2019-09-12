REPORT demo_apc_attach_client.

CLASS apc_demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS apc_demo IMPLEMENTATION.
  METHOD main.
    DATA attach_handle TYPE string VALUE ' '.
    cl_demo_input=>add_field( CHANGING field  = attach_handle ).
    DATA(msg) = `Hello APC!`.
    cl_demo_input=>add_field( CHANGING field = msg ).
    DATA amc TYPE abap_bool VALUE ' '.
    cl_demo_input=>add_field( EXPORTING as_checkbox = 'X'
                              CHANGING field  = amc ).
    DATA close TYPE abap_bool VALUE ' '.
    cl_demo_input=>add_field( EXPORTING as_checkbox = 'X'
                              CHANGING field  = close ).
    cl_demo_input=>request( ).

    TRY.
        "Attached client
        DATA(client_attach) =
          cl_apc_wsp_client_conn_manager=>attach( attach_handle ).
        DATA(message_manager) =
          CAST if_apc_wsp_message_manager_pcp(
            client_attach->get_message_manager( ) ).
        DATA(message) = CAST if_ac_message_type_pcp(
          message_manager->create_message( ) ).
        TRY.
            IF amc = abap_true.
              message->set_field( i_name = 'amc' i_value = 'x' ).
            ENDIF.
            message->set_field(
              i_name = 'detached_client' i_value = 'x' ).
            message->set_text( msg ).
          CATCH cx_ac_message_type_pcp_error INTO DATA(pcp_error).
            cl_demo_output=>display( pcp_error->get_text( ) ).
            LEAVE PROGRAM.
        ENDTRY.
        message_manager->send( message ).
        IF close  = abap_true.
          client_attach->close(
            i_reason = 'Application closed connection!' ).
        ENDIF.
      CATCH cx_apc_error INTO DATA(apc_error).
        cl_demo_output=>display( apc_error->get_text( ) ).
        LEAVE PROGRAM.
    ENDTRY.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  apc_demo=>main( ).
