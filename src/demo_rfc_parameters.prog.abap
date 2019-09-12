REPORT demo_rfc_parameters.

CLASS demo_rfc DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS:
      main,
      callback IMPORTING p_task TYPE clike.
  PRIVATE SECTION.
    CLASS-DATA:
      val_in     TYPE string,
      val_out    TYPE string,
      val_in_out TYPE string,
      msg        TYPE c LENGTH 80,
      out        TYPE REF TO if_demo_output.
ENDCLASS.

CLASS demo_rfc IMPLEMENTATION.
  METHOD main.
    out = cl_demo_output=>new( ).

    "Synchronous RFC
    val_in     = `val_in`.
    val_out    = ``.
    val_in_out = `val_in_out`.
    CALL FUNCTION 'DEMO_RFM_PARAMETERS'
      DESTINATION 'NONE'
      EXPORTING
        p_in                  = val_in
      IMPORTING
        p_out                 = val_out
      CHANGING
        p_in_out              = val_in_out
      EXCEPTIONS
        system_failure        = 2 MESSAGE msg
        communication_failure = 4 MESSAGE msg.
    IF sy-subrc <> 0.
      out->display( |Error when calling sRFC.\n{ msg }| ).
      RETURN.
    ENDIF.
    out->next_section( 'sRFC'
      )->write( |{ val_out }\n{ val_in_out }| ).

    "Asynchronous RFC
    val_in     = `val_in`.
    val_out    = ``.
    val_in_out = `val_in_out`.
    CALL FUNCTION 'DEMO_RFM_PARAMETERS'
      DESTINATION 'NONE'
      STARTING NEW TASK 'DEMO'
      CALLING demo_rfc=>callback ON END OF TASK
      EXPORTING
        p_in                  = val_in
      CHANGING
        p_in_out              = val_in_out
      EXCEPTIONS
        system_failure        = 2 MESSAGE msg
        communication_failure = 4 MESSAGE msg.
    IF sy-subrc <> 0.
      out->display( |Error when calling aRFC.\n{ msg }| ).
      RETURN.
    ENDIF.
    WAIT FOR ASYNCHRONOUS TASKS UNTIL val_out IS NOT INITIAL
                                UP TO 10 SECONDS.
    out->next_section( 'aRFC'
      )->write( |{ val_out }\n{ val_in_out }| ).

    out->display( ).
  ENDMETHOD.
  METHOD callback.
    val_out    = ``.
    val_in_out = ``.
    RECEIVE RESULTS FROM FUNCTION 'DEMO_RFM_PARAMETERS'
      IMPORTING
        p_out                 = val_out
      CHANGING
        p_in_out              = val_in_out
      EXCEPTIONS
        system_failure        = 2 MESSAGE msg
        communication_failure = 4 MESSAGE msg.
    IF sy-subrc <> 0.
      out->display( '|Error when receiving aRFC.\n{ msg }|' ).
      RETURN.
    ENDIF.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo_rfc=>main( ).
