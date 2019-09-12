class CL_APC_WSP_EXT_DEMO_APC_PCP definition
  public
  inheriting from CL_APC_WSP_EXT_STATELESS_PCP_B
  final
  create public .

public section.

  aliases ON_ACCEPT
    for IF_APC_WSP_EXT_PCP~ON_ACCEPT .
  aliases ON_CLOSE
    for IF_APC_WSP_EXT_PCP~ON_CLOSE .
  aliases ON_ERROR
    for IF_APC_WSP_EXT_PCP~ON_ERROR .
  aliases ON_MESSAGE
    for IF_APC_WSP_EXT_PCP~ON_MESSAGE .
  aliases ON_START
    for IF_APC_WSP_EXT_PCP~ON_START .

  methods IF_APC_WSP_EXT_PCP~ON_MESSAGE
    redefinition .
  methods IF_APC_WSP_EXT_PCP~ON_START
    redefinition .
  PROTECTED SECTION.
private section.

  data COUNTER type I .
ENDCLASS.



CLASS CL_APC_WSP_EXT_DEMO_APC_PCP IMPLEMENTATION.


  METHOD if_apc_wsp_ext_pcp~on_message.
    "Demonstration of stateful APC
    counter = counter + 1.

    TRY.
        DATA(amc_flag) =
            COND abap_bool( WHEN to_upper(
                                 i_message->get_field( i_name = 'amc' )
                                 ) = abap_true
                            THEN abap_true
                            ELSE abap_false ).
        DATA(detached_client_flag) =
            COND abap_bool( WHEN to_upper(
                                 i_message->get_field( i_name = 'detached_client' )
                                 ) = abap_true
                            THEN abap_true
                            ELSE abap_false ).
        DATA(connection_id) = i_context->get_connection_id( ).
        DATA(no_echo) = COND #( WHEN detached_client_flag = abap_true
                                THEN to_upper( i_message->get_field( 'no_echo' ) ) ).
      CATCH cx_apc_error.
        amc_flag = abap_false.
        detached_client_flag = abap_true.
      CATCH cx_ac_message_type_pcp_error.
        amc_flag = abap_false.
        detached_client_flag = abap_true.
    ENDTRY.

    "Prevent any echoing for detached clients
    IF detached_client_flag = abap_true AND no_echo = abap_true.
      RETURN.
    ENDIF.

    TRY.
        DATA(msg) = |message from APC on { sy-host }: Received "{ i_message->serialize( ) }"|.
        IF amc_flag = abap_true.
          i_message->set_text( i_message->get_text( ) && | [counter: { counter }]| ).

          IF detached_client_flag = abap_true.
            i_message->set_field( i_name = 'no_echo'
                                  i_value = 'x' ).
          ENDIF.
          CAST if_amc_message_producer_pcp(
                cl_amc_channel_manager=>create_message_producer(
                  i_application_id = 'DEMO_AMC'
                  i_channel_id     = '/demo_pcp' )
           )->send( i_message = i_message  ) ##NO_TEXT.
        ELSE.
          DATA(message) = i_message_manager->create_message( ).
          message->set_text( `Default ` && msg && | [counter: { counter }]| ) ##NO_TEXT.
          IF detached_client_flag = abap_true.
            message->set_field( i_name = 'no_echo'
                                i_value = 'x' ).
            message->set_field( i_name = 'detached_client'
                                i_value = 'x' ).
          ENDIF.
          i_message_manager->send( message ).
        ENDIF.
      CATCH cx_amc_error cx_apc_error INTO DATA(exc).
        MESSAGE exc->get_text( ) TYPE 'X'.
      CATCH cx_ac_message_type_pcp_error INTO DATA(pcp_exc).
        MESSAGE pcp_exc->get_text( ) TYPE 'X'.
    ENDTRY.
  ENDMETHOD.


  METHOD if_apc_wsp_ext_pcp~on_start.
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
              i_channel_id     = '/demo_pcp' ).
        CATCH cx_apc_error INTO DATA(exc).
          MESSAGE exc->get_text( ) TYPE 'X'.
      ENDTRY.
    ELSE.
      "Default behavior
    ENDIF.
  ENDMETHOD.
ENDCLASS.
