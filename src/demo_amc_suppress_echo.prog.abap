REPORT demo_amc_suppress_echo.

CLASS message_receiver DEFINITION.
  PUBLIC SECTION.
    INTERFACES:
      if_amc_message_receiver_text.
    DATA text_message TYPE string.
ENDCLASS.

CLASS message_receiver IMPLEMENTATION.
  METHOD if_amc_message_receiver_text~receive.
    text_message = i_message.
  ENDMETHOD.
ENDCLASS.

CLASS amc_demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS amc_demo IMPLEMENTATION.
  METHOD main.
    DATA(receiver) = NEW message_receiver( ).
    TRY.
        cl_amc_channel_manager=>create_message_consumer(
            i_application_id = 'DEMO_AMC'
            i_channel_id     = '/demo_text'
            )->start_message_delivery( i_receiver = receiver ).
      CATCH cx_amc_error INTO DATA(text_exc).
        cl_demo_output=>display( text_exc->get_text( ) ).
    ENDTRY.

    "Check 'Send text message' and toggle 'Suppress echo'
    SUBMIT demo_send_amc AND RETURN.

    WAIT FOR MESSAGING CHANNELS
      UNTIL receiver->text_message IS NOT INITIAL
      UP TO 1 SECONDS.

    IF receiver->text_message IS NOT INITIAL.
      cl_demo_output=>display( receiver->text_message ).
    ENDIF.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  amc_demo=>main( ).
