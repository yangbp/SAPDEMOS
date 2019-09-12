REPORT demo_apc_tcp_client.

CLASS apc_handler DEFINITION FINAL .
  PUBLIC SECTION.
    INTERFACES if_apc_wsp_event_handler.
    DATA       message TYPE string.
ENDCLASS.

CLASS apc_handler IMPLEMENTATION.
  METHOD if_apc_wsp_event_handler~on_open.
  ENDMETHOD.

  METHOD if_apc_wsp_event_handler~on_message.
    TRY.
        message = i_message->get_text( ).
      CATCH cx_apc_error INTO DATA(apc_error).
        message = apc_error->get_text( ).
    ENDTRY.
  ENDMETHOD.

  METHOD if_apc_wsp_event_handler~on_close.
    message = 'Connection closed!'.
  ENDMETHOD.

  METHOD if_apc_wsp_event_handler~on_error.
  ENDMETHOD.
ENDCLASS.

CLASS apc_demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS apc_demo IMPLEMENTATION.
  METHOD main.
    DATA(tcp_server) = `C:\ncat\ncat.exe`.
    DATA(ip_adress)  = cl_gui_frontend_services=>get_ip_address( ).
    DATA(port)       = `12345`.
    DATA(terminator) = `0A`.
    DATA(msg)        = `Hello TCP, answer me!`.

    cl_demo_input=>new(
      )->add_text(
         |For the TCP server, download the freely available NCAT.EXE|
      )->add_field( CHANGING field = tcp_server
      )->add_field( CHANGING field = ip_adress
      )->add_field( CHANGING field = port
      )->add_field( CHANGING field = terminator
      )->add_field( CHANGING field = msg
      )->request( ).

    "Server
    IF cl_gui_frontend_services=>file_exist(
         file = tcp_server ) IS INITIAL.
      cl_demo_output=>display( 'TCP Server not found!' ).
      LEAVE PROGRAM.
    ENDIF.
    cl_gui_frontend_services=>execute(
    EXPORTING
      application = `cmd.exe`
      parameter  =  `/c ` && tcp_server &&
                   ` -l ` && ip_adress && ` -p ` && port ).
    WAIT UP TO 1 SECONDS.

    TRY.
        DATA(event_handler) = NEW apc_handler( ).

        "Client
        DATA(client) = cl_apc_tcp_client_manager=>create(
          i_host   = ip_adress
          i_port  = port
          i_frame = VALUE apc_tcp_frame(
            frame_type =
              if_apc_tcp_frame_types=>co_frame_type_terminator
            terminator =
              terminator )
          i_event_handler = event_handler ).

        client->connect( ).

        "Send mesasage from client
        DATA(message_manager) = CAST if_apc_wsp_message_manager(
          client->get_message_manager( ) ).
        DATA(message) = CAST if_apc_wsp_message(
          message_manager->create_message( ) ).
        DATA(binary_terminator) = CONV xstring( terminator ).
        DATA(binary_msg) = cl_abap_codepage=>convert_to( msg ).
        CONCATENATE binary_msg binary_terminator
               INTO binary_msg IN BYTE MODE.
        message->set_binary( binary_msg ).
        message_manager->send( message ).

        "Wait for a message from server
        CLEAR event_handler->message.
        WAIT FOR PUSH CHANNELS
             UNTIL event_handler->message IS NOT INITIAL
             UP TO 10 SECONDS.
        IF sy-subrc = 4.
          cl_demo_output=>display(
            'No handler for APC messages registered!' ).
        ELSEIF sy-subrc = 8.
          cl_demo_output=>display(
            'Timeout occured!' ).
        ELSE.
          cl_demo_output=>display(
            |TCP client received:\n\n{ event_handler->message }| ).
        ENDIF.

        client->close(
          i_reason = 'Application closed connection!' ).

      CATCH cx_apc_error INTO DATA(apc_error).
        cl_demo_output=>display( apc_error->get_text( ) ).
    ENDTRY.

  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  apc_demo=>main( ).
