REPORT demo_apc_client.

CLASS apc_handler DEFINITION FINAL.
  PUBLIC SECTION.
    INTERFACES if_apc_wsp_event_handler_pcp.
    DATA       message TYPE string.
ENDCLASS.

CLASS apc_handler IMPLEMENTATION.
  METHOD if_apc_wsp_event_handler_pcp~on_open.
  ENDMETHOD.

  METHOD if_apc_wsp_event_handler_pcp~on_message.
    TRY.
        me->message = i_message->get_text( ).
      CATCH cx_apc_error INTO DATA(apc_error).
        me->message = apc_error->get_text( ).
      CATCH cx_ac_message_type_pcp_error INTO DATA(pcp_error).
        cl_demo_output=>display( pcp_error->get_text( ) ).
        LEAVE PROGRAM.
    ENDTRY.
  ENDMETHOD.

  METHOD if_apc_wsp_event_handler_pcp~on_close.
    me->message = 'Connection closed!'.
  ENDMETHOD.

  METHOD if_apc_wsp_event_handler_pcp~on_error.
    cl_demo_output=>display( 'Error!' ).
    LEAVE PROGRAM.
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
    DATA messages TYPE i VALUE '5'.
    cl_demo_input=>add_field(  CHANGING field  = messages ).
    DATA wait TYPE i VALUE '10'.
    cl_demo_input=>add_field(  CHANGING field  = wait ).
    cl_demo_input=>request( ).

    TRY.
        DATA(event_handler) = NEW apc_handler( ).

        "Client
        DATA(client) =
          cl_apc_wsp_client_manager=>create_by_destination(
            i_destination = 'NONE'
            i_event_handler = event_handler
            i_protocol =
              if_apc_wsp_event_handler_pcp=>co_event_handler_type ).

        "Server
        DATA(request) =
          client->get_context( )->get_initial_request( ).
        request->set_path_and_query(
          i_relative_uri =
            `/sap/bc/apc/sap/demo_apc_pcp` &&
            COND #(
               WHEN stateful_server = abap_true THEN `_stateful` ) &&
            COND #(
              WHEN amc = abap_true THEN `?amc=x` ) ).
        client->connect( ).

        "Sending messages
        DATA(message_manager) =
          CAST if_apc_wsp_message_manager_pcp(
            client->get_message_manager( ) ).
        DATA(message) =
          CAST if_ac_message_type_pcp(
            message_manager->create_message( ) ).
        TRY.
            IF amc = abap_true.
              message->set_field( i_name = 'amc' i_value = 'x' ).
            ENDIF.
            message->set_text( msg ).
          CATCH cx_ac_message_type_pcp_error INTO DATA(pcp_error).
            cl_demo_output=>display( pcp_error->get_text( ) ).
            LEAVE PROGRAM.
        ENDTRY.
        DO messages TIMES.
          message_manager->send( message ).
        ENDDO.

        "Receiving messages
        DO wait TIMES.
          out->line( ).
          CLEAR event_handler->message.
          WAIT FOR PUSH CHANNELS
               UNTIL event_handler->message IS NOT INITIAL
               UP TO 1 SECONDS.
          IF sy-subrc = 4.
            out->write_text(
              'No handler for APC messages registered' ).
          ELSEIF sy-subrc = 8.
            out->write_text(
              'Timeout occured!' ).
          ELSE.
            out->write_text(
             |Received APC message: \n\n{
               event_handler->message } | ).
          ENDIF.
        ENDDO.
        out->line( ).

        "Close connection
        client->close( i_reason = 'Application closed connection!' ).

        out->display( ).
      CATCH cx_apc_error INTO DATA(apc_error).
        cl_demo_output=>display( apc_error->get_text( ) ).
        LEAVE PROGRAM.
    ENDTRY.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  apc_demo=>main( ).
