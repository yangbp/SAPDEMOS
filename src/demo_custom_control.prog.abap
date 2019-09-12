REPORT demo_custom_control .

* Declarations *****************************************************

CLASS event_handler DEFINITION.
  PUBLIC SECTION.
    METHODS: handle_f1 FOR EVENT f1 OF cl_gui_textedit
             IMPORTING sender,
             handle_f4 FOR EVENT f4 OF cl_gui_textedit
             IMPORTING sender.
ENDCLASS.

DATA: ok_code LIKE sy-ucomm,
      save_ok LIKE sy-ucomm.

DATA: init,
      container TYPE REF TO cl_gui_custom_container,
      editor    TYPE REF TO cl_gui_textedit.

DATA: event_tab TYPE cntl_simple_events,
      event     TYPE cntl_simple_event.

DATA: line(256) TYPE c,
      text_tab LIKE STANDARD TABLE OF line,
      field LIKE line.

DATA handle TYPE REF TO event_handler.


* Reporting Events ***************************************************

START-OF-SELECTION.

  line = 'First line in TextEditControl'.
  APPEND line TO text_tab.
  line = '--------------------------------------------------'.
  APPEND line TO text_tab.
  line = '...'.
  APPEND line TO text_tab.

  CALL SCREEN 100.

* Dialog Modules *****************************************************

MODULE status_0100 OUTPUT.
  SET PF-STATUS 'SCREEN_100'.
  IF init is initial.
    init = 'X'.
    CREATE OBJECT: container EXPORTING container_name = 'TEXTEDIT',
                   editor    EXPORTING parent = container,
                   handle.
    event-eventid = cl_gui_textedit=>event_f1.
    event-appl_event = ' '.                     "system event
    APPEND event TO event_tab.
    event-eventid = cl_gui_textedit=>event_f4.
    event-appl_event = 'X'.                     "application event
    APPEND event TO event_tab.
    editor->set_registered_events(
                 EXPORTING events = event_tab ).
    SET HANDLER handle->handle_f1
                handle->handle_f4 FOR editor.
  ENDIF.
  editor->set_text_as_stream( EXPORTING text = text_tab ).
ENDMODULE.

MODULE cancel INPUT.
  LEAVE PROGRAM.
ENDMODULE.

MODULE user_command_0100 INPUT.
  save_ok = ok_code.
  CLEAR ok_code.
  CASE save_ok.
    WHEN 'INSERT'.
      editor->get_text_as_stream( IMPORTING text = text_tab ).
    WHEN 'F1'.
      MESSAGE i888(sabapdemos) WITH text-001.
    WHEN OTHERS.
      MESSAGE i888(sabapdemos) WITH text-002.
      cl_gui_cfw=>dispatch( ).                "for application events
      MESSAGE i888(sabapdemos) WITH text-003.
  ENDCASE.
  SET SCREEN 100.
ENDMODULE.

* Class Implementations **********************************************

CLASS event_handler IMPLEMENTATION.
  METHOD handle_f1.
    DATA row TYPE i.
    MESSAGE i888(sabapdemos) WITH text-004.
    sender->get_selection_pos(
         IMPORTING from_line = row ).
    sender->get_line_text(
         EXPORTING line_number = row
         IMPORTING text = field ).
    cl_gui_cfw=>set_new_ok_code(                "raise PAI for
         EXPORTING new_code = 'F1' ).           "system events
    cl_gui_cfw=>flush( ).
  ENDMETHOD.
  METHOD handle_f4.
    DATA row TYPE i.
    MESSAGE i888(sabapdemos) WITH text-005.
    sender->get_selection_pos(
         IMPORTING from_line = row ).
    sender->get_line_text(
         EXPORTING line_number = row
         IMPORTING text = field ).
    cl_gui_cfw=>flush( ).
  ENDMETHOD.
ENDCLASS.
