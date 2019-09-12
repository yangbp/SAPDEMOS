REPORT demo_receive_amc.

CLASS message_receiver DEFINITION.
  PUBLIC SECTION.
    INTERFACES:
      if_amc_message_receiver_text,
      if_amc_message_receiver_binary,
      if_amc_message_receiver_pcp.
    DATA: text_message   TYPE string,
          binary_message TYPE xstring,
          pcp_message    TYPE REF TO if_ac_message_type_pcp.
ENDCLASS.

CLASS message_receiver IMPLEMENTATION.
  METHOD if_amc_message_receiver_text~receive.
    text_message = i_message.
  ENDMETHOD.
  METHOD if_amc_message_receiver_binary~receive.
    binary_message = i_message.
  ENDMETHOD.
  METHOD if_amc_message_receiver_pcp~receive.
    pcp_message = i_message.
  ENDMETHOD.
ENDCLASS.

CLASS amc_demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS amc_demo IMPLEMENTATION.
  METHOD main.
   DATA(in) = cl_demo_input=>new( ).

    TRY.
        in->add_text( `Session id: ` &&
          cl_amc_channel_manager=>get_consumer_session_id( ) ).
      CATCH cx_amc_error INTO DATA(id_exc).
        cl_demo_output=>display( id_exc->get_text( ) ).
    ENDTRY.

    DATA(txt) = ` `.
    in->add_field(
      EXPORTING as_checkbox = 'X'
                text        = 'Wait for text messages'
      CHANGING  field       = txt ).
    DATA(hex) = ` `.
    in->add_field(
      EXPORTING as_checkbox = 'X'
                text        = 'Wait for binary messages'
      CHANGING  field       = hex ).
    DATA(pcp) = ` `.
    in->add_field(
      EXPORTING as_checkbox = 'X'
                text        = 'Wait for PCP message'
      CHANGING  field       = pcp ).
    DATA(time) = 60.
    in->request(
      EXPORTING  text        = 'Waiting time'
      CHANGING  field       = time ).
    DATA(patt) = |{ txt WIDTH = 1 }{ hex WIDTH = 1 }{ pcp WIDTH = 1 }|.

    DATA(receiver) = NEW message_receiver( ).

    TRY.
        cl_amc_channel_manager=>create_message_consumer(
            i_application_id = 'DEMO_AMC'
            i_channel_id     = '/demo_text'
            )->start_message_delivery( i_receiver = receiver ).
      CATCH cx_amc_error INTO DATA(text_exc).
        cl_demo_output=>display( text_exc->get_text( ) ).
    ENDTRY.

    TRY.
        cl_amc_channel_manager=>create_message_consumer(
            i_application_id = 'DEMO_AMC'
            i_channel_id     = '/demo_binary'
            )->start_message_delivery( i_receiver = receiver ).
      CATCH cx_amc_error INTO DATA(binary_exc).
        cl_demo_output=>display( binary_exc->get_text( ) ).
    ENDTRY.

    TRY.
        cl_amc_channel_manager=>create_message_consumer(
            i_application_id = 'DEMO_AMC'
            i_channel_id     = '/demo_pcp'
            )->start_message_delivery( i_receiver = receiver ).
      CATCH cx_amc_error INTO DATA(amc_exc).
        cl_demo_output=>display( amc_exc->get_text( ) ).
    ENDTRY.

    CASE patt.
      WHEN `X  `.
        WAIT FOR MESSAGING CHANNELS
             UNTIL receiver->text_message   IS NOT INITIAL
             UP TO time SECONDS.
      WHEN `XX `.
        WAIT FOR MESSAGING CHANNELS
             UNTIL receiver->text_message   IS NOT INITIAL AND
                   receiver->binary_message IS NOT INITIAL
             UP TO time SECONDS.
      WHEN `XXX`.
        WAIT FOR MESSAGING CHANNELS
             UNTIL receiver->text_message   IS NOT INITIAL AND
                   receiver->binary_message IS NOT INITIAL AND
                   receiver->pcp_message    IS BOUND
             UP TO time SECONDS.
      WHEN ` X `.
        WAIT FOR MESSAGING CHANNELS
             UNTIL receiver->binary_message IS NOT INITIAL
             UP TO time SECONDS.
      WHEN ` XX`.
        WAIT FOR MESSAGING CHANNELS
             UNTIL receiver->binary_message IS NOT INITIAL AND
                   receiver->pcp_message    IS BOUND
             UP TO time SECONDS.
      WHEN `  X`.
        WAIT FOR MESSAGING CHANNELS
             UNTIL receiver->pcp_message    IS BOUND
             UP TO time SECONDS.
      WHEN OTHERS.
        RETURN.
    ENDCASE.

    DATA(out) = cl_demo_output=>new( ).
    IF txt = 'X' AND receiver->text_message IS NOT INITIAL.
      out->next_section( `Text Message`
        )->write( receiver->text_message ).
    ENDIF.
    IF hex = 'X' AND receiver->binary_message IS NOT INITIAL.
      out->next_section( `Binary Message`
        )->write_json( receiver->binary_message ).
    ENDIF.
    IF pcp = 'X' AND receiver->pcp_message IS BOUND.
      DATA fields TYPE pcp_fields.
      TRY.
          receiver->pcp_message->get_fields(
            CHANGING c_fields = fields ).
          DATA(body) = receiver->pcp_message->get_text( ).
        CATCH cx_ac_message_type_pcp_error INTO DATA(pcp_exc).
          cl_demo_output=>display( pcp_exc->get_text( ) ).
      ENDTRY.
      IF fields IS NOT INITIAL OR
         body   IS NOT INITIAL.
        out->next_section( 'Push Channel Protocol (PCP)'
          )->write( fields
          )->write_html( body ).
      ENDIF.
    ENDIF.
    out->display( ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  amc_demo=>main( ).
