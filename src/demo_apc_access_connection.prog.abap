REPORT demo_apc_access_connection.

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
    cl_demo_input=>request( ).

    TRY.
        DATA(access_object) =
          cl_apc_wsp_client_conn_manager=>attach( attach_handle ).
        DATA(message_manager) =
          CAST if_apc_wsp_message_manager(
            access_object->get_message_manager( ) ).
        DATA(message) = CAST if_apc_wsp_message(
          message_manager->create_message( ) ).
        message->set_text( msg ).
        message_manager->send( message ).
      CATCH cx_apc_error INTO DATA(apc_error).
        cl_demo_output=>display( apc_error->get_text( ) ).
        LEAVE PROGRAM.
    ENDTRY.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  apc_demo=>main( ).
