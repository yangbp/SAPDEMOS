CLASS cl_apc_ws_ext_demo_apc DEFINITION
  PUBLIC
  INHERITING FROM cl_apc_wsp_ext_stateless_base
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS if_apc_wsp_extension~on_message
        REDEFINITION .
    METHODS if_apc_wsp_extension~on_start
        REDEFINITION .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS CL_APC_WS_EXT_DEMO_APC IMPLEMENTATION.


  METHOD if_apc_wsp_extension~on_message.
    TRY.
        DATA(amc_flag) =
            COND abap_bool( WHEN to_upper(
                                 i_context->get_initial_request(
                                 )->get_form_field( i_name = 'amc' )
                                 ) = abap_true
                            THEN abap_true
                            ELSE abap_false ).
      CATCH cx_apc_error.
        amc_flag = abap_false.
    ENDTRY.

    TRY.
        IF to_upper( i_message->get_text( ) ) CS '>GET HANDLE<'.
          DATA(attach_handle) = i_context->get_connection_attach_handle(  ).
        ENDIF.
      CATCH cx_apc_error.
        CLEAR attach_handle.
    ENDTRY.

    TRY.
        DATA(msg) = COND #( WHEN attach_handle IS INITIAL THEN
                      |Message from APC on { sy-host }: Received "{ i_message->get_text( ) }|
                      ELSE |Connection Attach Handle: { attach_handle }| ).
        IF amc_flag = abap_true AND attach_handle IS INITIAL.
          CAST if_amc_message_producer_text(
                cl_amc_channel_manager=>create_message_producer(
                  i_application_id = 'DEMO_AMC'
                  i_channel_id     = '/demo_text' )
           )->send( i_message = `AMC-` && msg  ) ##NO_TEXT.
        ELSE.
          DATA(message) = i_message_manager->create_message( ).
          message->set_text( COND #( WHEN attach_handle IS INITIAL THEN `Default ` ) && msg ) ##NO_TEXT.
          i_message_manager->send( message ).
        ENDIF.
      CATCH cx_amc_error cx_apc_error INTO DATA(exc).
        MESSAGE exc->get_text( ) TYPE 'X'.
    ENDTRY.

  ENDMETHOD.


  METHOD if_apc_wsp_extension~on_start.
    TRY.
        DATA(amc_flag) =
            COND abap_bool( WHEN to_upper(
                                 i_context->get_initial_request(
                                 )->get_form_field( i_name = 'amc' )
                                 ) = abap_true
                            THEN abap_true
                            ELSE abap_false ).
      CATCH cx_apc_error.
        amc_flag = abap_false.
    ENDTRY.

    IF amc_flag = abap_true.
      TRY.
          i_context->get_binding_manager(
            )->bind_amc_message_consumer(
              i_application_id =  'DEMO_AMC'
              i_channel_id     = '/demo_text' ).
        CATCH cx_apc_error INTO DATA(exc).
          MESSAGE exc->get_text( ) TYPE 'X'.
      ENDTRY.
    ELSE.
      "Default behavior
    ENDIF.
  ENDMETHOD.
ENDCLASS.
