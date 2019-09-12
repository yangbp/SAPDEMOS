REPORT demo_send_amc.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    TYPES:
      BEGIN OF struct,
        name  TYPE string,
        value TYPE string,
      END OF struct,
      fields TYPE STANDARD TABLE OF struct WITH EMPTY KEY.

    DATA: text TYPE abap_bool,
          hex  TYPE abap_bool,
          pcp  TYPE abap_bool.

    DATA text_message   TYPE string VALUE `I am a text message`.
    DATA binary_message TYPE string VALUE `I am a binary message`.
    DATA pcp_body       TYPE string VALUE `I am a PCP body`.
    DATA field1         TYPE string VALUE `Field1`.
    DATA value1         TYPE string VALUE `Value1`.
    DATA field2         TYPE string VALUE `Field2`.
    DATA value2         TYPE string VALUE `Value2`.
    DATA no_echo        TYPE abap_bool.
    DATA session_id     TYPE amc_consumer_session_id.

    cl_demo_input=>new(
      )->add_field( EXPORTING text = 'Text message'
                    CHANGING  field = text_message
      )->add_field( EXPORTING text = 'Send text message'
                              as_checkbox = 'X'
                    CHANGING  field = text
      )->add_line(
      )->add_field( EXPORTING text = 'Binary message'
                    CHANGING  field = binary_message
      )->add_field( EXPORTING text = 'Send binary message'
                              as_checkbox = 'X'
                    CHANGING  field = hex
      )->add_line(
      )->add_field( EXPORTING text = 'Field1' CHANGING field = value1
      )->add_field( EXPORTING text = 'Field2' CHANGING field = value2
      )->add_field( EXPORTING text = 'PCP body'
                    CHANGING  field = pcp_body
      )->add_field( EXPORTING text = 'Send PCP message'
                              as_checkbox = 'X'
                    CHANGING  field = pcp
      )->add_line(
      )->add_field( EXPORTING text = 'Suppress echo'
                              as_checkbox = 'X'
                    CHANGING  field = no_echo
      )->add_line(
      )->add_field( EXPORTING text  = 'Consumer session id'
                    CHANGING  field = session_id
      )->request( ).

    IF text IS NOT INITIAL.
      TRY.
          IF session_id IS INITIAL.
            CAST if_amc_message_producer_text(
                   cl_amc_channel_manager=>create_message_producer(
                     i_application_id = 'DEMO_AMC'
                     i_channel_id     = '/demo_text'
                     i_suppress_echo  = no_echo )
              )->send( i_message = text_message ).
          ELSE.
            CAST if_amc_message_producer_text(
                 cl_amc_channel_manager=>create_message_producer_by_id(
                   i_consumer_session_id = session_id
                   i_communication_type  =
                       cl_amc_channel_manager=>co_comm_type_synchronous
                   i_application_id      = 'DEMO_AMC'
                   i_channel_id          = '/demo_text' )
              )->send( i_message = text_message ).
          ENDIF.
        CATCH cx_amc_error INTO DATA(text_exc).
          cl_demo_output=>display( text_exc->get_text( ) ).
      ENDTRY.
    ENDIF.

    IF hex IS NOT INITIAL.
      DATA(json_writer) = cl_sxml_string_writer=>create(
                          type = if_sxml=>co_xt_json ).
      CALL TRANSFORMATION id SOURCE message = binary_message
                             RESULT XML json_writer.
      DATA(json) = json_writer->get_output( ).

      TRY.
          IF session_id IS INITIAL.
            CAST if_amc_message_producer_binary(
                   cl_amc_channel_manager=>create_message_producer(
                     i_application_id = 'DEMO_AMC'
                     i_channel_id     = '/demo_binary'
                     i_suppress_echo  = no_echo )
              )->send( i_message = json ).
          ELSE.
            CAST if_amc_message_producer_binary(
                 cl_amc_channel_manager=>create_message_producer_by_id(
                   i_consumer_session_id = session_id
                   i_communication_type  =
                       cl_amc_channel_manager=>co_comm_type_synchronous
                   i_application_id = 'DEMO_AMC'
                   i_channel_id     = '/demo_binary' )
              )->send( i_message = json ).
          ENDIF.
        CATCH cx_amc_error INTO DATA(binary_exc).
          cl_demo_output=>display( binary_exc->get_text( ) ).
      ENDTRY.
    ENDIF.

    IF pcp IS NOT INITIAL.
      DATA(fields) = VALUE fields( ( name = 'Field1' value = value1 )
                                   ( name = 'Field2' value = value2 ) ).
      DATA(body)  = |<b>{ pcp_body }</b>|.
      TRY.
          DATA(pcp_message) = cl_ac_message_type_pcp=>create( ).
          pcp_message->set_field( i_name  = fields[ 1 ]-name
                             i_value = fields[ 1 ]-value ).
          pcp_message->set_field( i_name  = fields[ 2 ]-name
                             i_value = fields[ 2 ]-value ).
          pcp_message->set_text( body ).
          IF session_id IS INITIAL.
            CAST if_amc_message_producer_pcp(
                  cl_amc_channel_manager=>create_message_producer(
                    i_application_id = 'DEMO_AMC'
                    i_channel_id     = '/demo_pcp'
                    i_suppress_echo  = no_echo )
              )->send( i_message = pcp_message ).
          ELSE.
            CAST if_amc_message_producer_pcp(
                 cl_amc_channel_manager=>create_message_producer_by_id(
                   i_consumer_session_id = session_id
                   i_communication_type  =
                       cl_amc_channel_manager=>co_comm_type_synchronous
                   i_application_id = 'DEMO_AMC'
                   i_channel_id     = '/demo_pcp' )
              )->send( i_message = pcp_message ).
          ENDIF.
        CATCH cx_amc_error INTO DATA(amc_exc).
          cl_demo_output=>display( amc_exc->get_text( ) ).
        CATCH cx_ac_message_type_pcp_error INTO DATA(pcp_exc).
          cl_demo_output=>display( pcp_exc->get_text( ) ).
      ENDTRY.
    ENDIF.

  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
