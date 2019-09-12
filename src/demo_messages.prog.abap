REPORT demo_messages.

* Program to demonstrate the MESSAGE statement in different places

DATA: ok_code TYPE sy-ucomm,
      save_ok TYPE sy-ucomm,
      BEGIN OF place,
        report(1) TYPE c, function(1) TYPE c, list(1) TYPE c,
        selscreen(1) TYPE c, dynpro(1) TYPE c,
      END OF place,
      BEGIN OF type,
        a(1) TYPE c, e(1) TYPE c, i(1) TYPE c, s(1) TYPE c,
        w(1) TYPE c, x(1) TYPE c,
      END OF type,
      BEGIN OF event,
        pai(1) TYPE c, pbo(1) TYPE c,
      END OF event,
      BEGIN OF except,
        no(1) TYPE c, yes(1) TYPE c, catch(1) TYPE c, nocatch(1) TYPE c,
      END OF except,
      message_type(1) TYPE c, message_place(40) TYPE c,
      message_event(20) TYPE c.

DATA: field1(10) TYPE c, field2(10) TYPE c,
      field3(10) TYPE c, field4(10) TYPE c.

SELECTION-SCREEN BEGIN OF SCREEN 1100.
PARAMETERS: input1(10) TYPE c,
            input2(10) TYPE c.
SELECTION-SCREEN SKIP.
SELECTION-SCREEN BEGIN OF LINE.
SELECTION-SCREEN COMMENT 1(33) text-001.
PARAMETERS  funct AS CHECKBOX.
SELECTION-SCREEN END OF LINE.
SELECTION-SCREEN END OF SCREEN 1100.

START-OF-SELECTION.

  type-i = 'X'.
  event-pai = 'X'.
  except-no = 'X'.
  place-report = 'X'.

  DO.
    CALL SCREEN 100.
    IF place-report = 'X'.
      message_event = 'START-OF-SELECTION'.
      message_place = 'in main program'(002).
      PERFORM call_message.
    ELSEIF place-function = 'X'.
      message_event = 'START-OF-SELECTION'.
      message_place = 'in function module from main program'(011).
      PERFORM call_function.
    ENDIF.
  ENDDO.

************************************************************************
* Dialog Modules                                                       *
************************************************************************

MODULE status_0100 OUTPUT.
  SET PF-STATUS 'SCREEN_100'.
ENDMODULE.

MODULE cancel INPUT.
  LEAVE PROGRAM.
ENDMODULE.

MODULE user_command_0100 INPUT.
  save_ok = ok_code.
  CLEAR ok_code.
  PERFORM convert_user_input.
  CASE save_ok.
    WHEN 'TEST'.
      IF place-report = 'X' OR place-function = 'X'.
        LEAVE TO SCREEN 0.
      ELSEIF place-dynpro = 'X'.
        LEAVE TO SCREEN 200.
      ELSEIF place-selscreen = 'X'.
        CALL SELECTION-SCREEN 1100.
      ELSEIF place-list = 'X'.
        CALL SCREEN 300.
      ENDIF.
    WHEN OTHERS.
      LEAVE PROGRAM.
  ENDCASE.
ENDMODULE.

MODULE status_0200 OUTPUT.
  SET PF-STATUS 'SCREEN_200'.
  IF event-pbo = 'X'.
    message_event = 'PBO'.
    message_place = 'on dynpro'(003).
    PERFORM call_message.
  ENDIF.
ENDMODULE.

MODULE user_command_0200 INPUT.
  save_ok = ok_code.
  CLEAR ok_code.
  CASE save_ok.
    WHEN 'BACK_100'.
      LEAVE TO SCREEN 0.
    WHEN 'LAUNCH'.
      IF event-pai = 'X'.
        message_event = 'PAI'.
        message_place = 'on dynpro'(003).
        PERFORM call_message.
      ENDIF.
    WHEN 'FUNC'.
      message_event = 'PAI'.
      message_place = 'in function module on dynpro'(004).
      PERFORM call_function.
    WHEN 'EXIT'.
      LEAVE TO SCREEN 100.
  ENDCASE.
ENDMODULE.

MODULE status_0300 OUTPUT.
  SUPPRESS DIALOG.
  SET PF-STATUS 'LIST'.
  LEAVE TO LIST-PROCESSING AND RETURN TO SCREEN 100.
  NEW-PAGE NO-TITLE.
  WRITE 'Basic List'(005).
ENDMODULE.

************************************************************************
* Selection screen events                                              *
************************************************************************

AT SELECTION-SCREEN OUTPUT.
  IF event-pbo = 'X'.
    message_event = 'PBO'.
    message_place = 'on selection screen'(006).
    PERFORM call_message.
  ENDIF.

AT SELECTION-SCREEN.
  IF funct = 'X'.
    message_event = 'PAI'.
    message_place = 'in function module on selection screen'(007).
    PERFORM call_function.
  ELSEIF event-pai = 'X'.
    message_event = 'PAI'.
    message_place = 'on selection screen'(006).
    PERFORM call_message.
  ENDIF.

************************************************************************
* List events
************************************************************************

AT USER-COMMAND.
  CASE sy-ucomm.
    WHEN 'MESSAGE'.
      message_event = 'AT USER-COMMAND'.
      message_place = 'on list'(008).
      WRITE: / 'Detail list, level:'(009), sy-lsind.
      PERFORM call_message.
    WHEN 'DETAIL'.
      WRITE: / 'Detail list, level:'(009), sy-lsind.
    WHEN 'FUNCT'.
      message_event = 'AT USER-COMMAND'.
      message_place = 'in funktion module on list'(010).
      PERFORM call_function.
      WRITE: / 'Detail list, level:'(009), sy-lsind.
  ENDCASE.

************************************************************************
* Subroutines                                                          *
************************************************************************

FORM call_message.
  MESSAGE ID 'SABAPDEMOS' TYPE message_type NUMBER '777'
          WITH message_type message_place message_event.
ENDFORM.

FORM call_function.
  IF except-no = 'X'.
    CALL FUNCTION 'DEMO_FUNCTION_MESSAGE_RAISING'
         EXPORTING
              message_type  = message_type
              message_place = message_place
              message_event = message_event.
  ELSEIF except-yes = 'X'.
    CALL FUNCTION 'DEMO_FUNCTION_MESSAGE_RAISING'
         EXPORTING
              message_type  = message_type
              message_place = message_place
              message_event = message_event
         EXCEPTIONS
              mess          = 4.
    CASE sy-subrc.
      WHEN 0.
        MESSAGE i888(sabapdemos)
                WITH 'No exception raised in function module'(012).
      WHEN 4.
        message_type = sy-msgty.
        MESSAGE i888(sabapdemos)
                WITH 'Handling exception from function module.'(013)
                     'Message type was '(014) message_type '.'.
    ENDCASE.
  ELSEIF except-catch = 'X'.
    CALL FUNCTION 'DEMO_FUNCTION_MESSAGE'
         EXPORTING
              message_type  = message_type
              message_place = message_place
              message_event = message_event
         EXCEPTIONS
              error_message = 4.
    CASE sy-subrc.
      WHEN 0.
        MESSAGE i888(sabapdemos)
                WITH 'No exception raised in function module'(012).
      WHEN 4.
        message_type = sy-msgty.
        MESSAGE i888(sabapdemos)
                WITH 'Handling exception from function module.'(013)
                     'Message type was '(014) message_type '.'.
    ENDCASE.
  ELSEIF except-nocatch = 'X'.
    CALL FUNCTION 'DEMO_FUNCTION_MESSAGE'
         EXPORTING
              message_type  = message_type
              message_place = message_place
              message_event = message_event.
  ENDIF.
ENDFORM.

FORM convert_user_input.
  IF type-a = 'X'.
    message_type = 'A'.
  ELSEIF type-e = 'X'.
    message_type = 'E'.
  ELSEIF type-i = 'X'.
    message_type = 'I'.
  ELSEIF type-s = 'X'.
    message_type = 'S'.
  ELSEIF type-w = 'X'.
    message_type = 'W'.
  ELSEIF type-x = 'X'.
    message_type = 'X'.
  ENDIF.
ENDFORM.
