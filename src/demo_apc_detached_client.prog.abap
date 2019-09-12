REPORT demo_apc_detached_client.

CLASS apc_handler DEFINITION FINAL.
  PUBLIC SECTION.
    INTERFACES if_apc_wsp_event_handler_pcp.
    DATA: connection_attach_handle TYPE string,
          message                  TYPE string.
ENDCLASS.

CLASS apc_handler IMPLEMENTATION.
  METHOD if_apc_wsp_event_handler_pcp~on_open.
    TRY.
        connection_attach_handle =
          i_context->get_connection_attach_handle(
            EXPORTING i_connection_security =
              i_context->co_con_security_by_user_id ).

      CATCH cx_apc_error INTO DATA(apc_error).
        me->message = apc_error->get_text( ).
    ENDTRY.
  ENDMETHOD.

  METHOD if_apc_wsp_event_handler_pcp~on_message.
  ENDMETHOD.

  METHOD if_apc_wsp_event_handler_pcp~on_close.
  ENDMETHOD.

  METHOD if_apc_wsp_event_handler_pcp~on_error.
  ENDMETHOD.
ENDCLASS.

CLASS apc_demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS apc_demo IMPLEMENTATION.
  METHOD main.
    DATA(out) = cl_demo_output=>new( ).

    DATA(msg) = `Hello APC!`.
    cl_demo_input=>add_field( CHANGING field = msg ).
    DATA amc TYPE abap_bool VALUE ' '.
    cl_demo_input=>add_field( EXPORTING as_checkbox = 'X'
                              CHANGING field  = amc ).
    DATA stateful_server TYPE abap_bool VALUE ' '.
    cl_demo_input=>add_field( EXPORTING as_checkbox = 'X'
                              CHANGING field  = stateful_server ).
    DATA show_attach_handle TYPE abap_bool VALUE ' '.
    cl_demo_input=>add_field( EXPORTING as_checkbox = 'X'
                              CHANGING field  = show_attach_handle ).
    cl_demo_input=>request( ).
    TRY.
        DATA(event_handler) = NEW apc_handler( ).

        "Detached client
        DATA(client_detach) =
          cl_apc_wsp_client_conn_manager=>create_by_destination(
            i_destination = 'NONE'
            i_application_id = `DEMO_APC_PCP`
            i_event_handler = event_handler
            i_protocol =
              if_apc_wsp_event_handler_pcp=>co_event_handler_type ).

        "Server
        DATA(request) =
          client_detach->get_context( )->get_initial_request( ).
        request->set_path_and_query(
          i_relative_uri =
            `/sap/bc/apc/sap/demo_apc_pcp` &&
            COND #(
               WHEN stateful_server = abap_true THEN `_stateful` ) &&
            COND #( WHEN amc = abap_true THEN `?amc=x` ) ).
        client_detach->connect_and_detach( ).

        IF event_handler->message IS NOT INITIAL.
          out->display(
            |Error during ON_OPEN: { event_handler->message }| ).
          LEAVE PROGRAM.
        ENDIF.

        IF show_attach_handle IS INITIAL.
          "Attached client
          DATA(client_attach) =
            cl_apc_wsp_client_conn_manager=>attach(
              event_handler->connection_attach_handle ).
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
          client_attach->close(
            i_reason = 'Application closed connection!' ).
        ELSE.
          out->display(
            |Attach Handle:\n\n{
            event_handler->connection_attach_handle
            }\n\nUse as input to DEMO_APC_ATTACH_CLIENT.| ).
        ENDIF.

      CATCH cx_apc_error INTO DATA(apc_error).
        cl_demo_output=>display( apc_error->get_text( ) ).
        LEAVE PROGRAM.
    ENDTRY.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  apc_demo=>main( ).
