REPORT  demo_java_script_mini_editor.

* Selection Screen -----------------------------------------------------

SELECTION-SCREEN: BEGIN OF SCREEN 500 TITLE sel_tit AS WINDOW,
                  BEGIN OF LINE.
PARAMETERS para(40) TYPE c LOWER CASE.
SELECTION-SCREEN: END OF LINE,
                  END OF SCREEN 500.

* Global Data ---------------------------------------------------------

DATA source_line  TYPE c LENGTH 80.
DATA source_table LIKE TABLE OF source_line.
DATA source       TYPE string.
DATA cursor       TYPE i.
DATA row          TYPE i.
DATA file_name    TYPE string VALUE `C:\temp\`.
DATA field_name   TYPE string.

* Processor class declaration ------------------------------------------

CLASS evaluate DEFINITION.
  PUBLIC SECTION.
    METHODS constructor.
    METHODS process IMPORTING js_source TYPE string
                              js_bp_line TYPE i OPTIONAL.
  PRIVATE SECTION.
    DATA js_processor TYPE REF TO cl_java_script.
ENDCLASS.                    "EVALUATE DEFINITION

* Processor class implementation ---------------------------------------

CLASS evaluate IMPLEMENTATION.
*
  METHOD constructor.
    js_processor = cl_java_script=>create( ).
  ENDMETHOD.                    "CONSTRUCTOR
*
  METHOD process.
    DATA return_value TYPE string.
    DATA get_value   TYPE string.
    js_processor->compile(
                  EXPORTING
                    script_name = 'JAVASCRIPT.JS'
                    script      = js_source ).
    IF js_bp_line <> 0.
      js_processor->set_breakpoint(
        script_name = 'JAVASCRIPT.JS'
        line_number = js_bp_line ).
    ENDIF.
    return_value = js_processor->execute( 'JAVASCRIPT.JS' ).
    IF js_processor->last_condition_code =
                       cl_java_script=>cc_breakpoint.
      MESSAGE i888(sabapdemos) WITH  'Breakpoint in'
                              js_processor->breakpoint_line_number.
      sel_tit = 'Enter field name'.
      para = field_name.
      CALL SELECTION-SCREEN 500 STARTING AT 10 10.
      IF sy-subrc = 0.
        field_name = para.
        CLEAR get_value.
        get_value = js_processor->get( name = field_name ).
        IF js_processor->last_condition_code = 0.
          MESSAGE i888(sabapdemos) WITH field_name ':'  get_value.
          js_processor->step( ).
          IF js_processor->last_condition_code =
                           cl_java_script=>cc_breakpoint.
            CLEAR get_value.
            get_value = js_processor->get( name = field_name ).
            IF js_processor->last_condition_code = 0.
              MESSAGE i888(sabapdemos) WITH field_name
                                           ' after single step:'
                                           get_value.
            ENDIF.
          ENDIF.
        ELSE.
          MESSAGE i888(sabapdemos) WITH field_name ' not accessible'.
        ENDIF.
      ENDIF.
    ELSEIF js_processor->last_condition_code <> 0.
      MESSAGE i888(sabapdemos) WITH js_processor->last_error_message.
    ELSE.
      MESSAGE i888(sabapdemos) WITH return_value.
    ENDIF.
    js_processor->clear_breakpoints( ).
    js_processor->destroy( 'JAVASCRIPT.JS' ).
  ENDMETHOD.                    "PROCESS
ENDCLASS.                    "EVALUATE IMPLEMENTATION

* Reference variables --------------------------------------------------

DATA area      TYPE REF TO cl_gui_custom_container.
DATA editor    TYPE REF TO cl_gui_textedit.
DATA processor TYPE REF TO evaluate.

* Program events -------------------------------------------------------

INITIALIZATION.

  source_line = 'var string = "Hello ABAP";'.
  APPEND source_line TO source_table.
  source_line = 'function Set_String()'.
  APPEND source_line TO source_table.
  source_line = '  {'.
  APPEND source_line TO source_table.
  source_line = '  string += ", this";'.
  APPEND source_line TO source_table.
  source_line = '  string += " is";'.
  APPEND source_line TO source_table.
  source_line = '  string += " JavaScript!";'.
  APPEND source_line TO source_table.
  source_line = '  }'.
  APPEND source_line TO source_table.
  source_line = 'Set_String();'.
  APPEND source_line TO source_table.
  source_line = 'string;'.
  APPEND source_line TO source_table.

START-OF-SELECTION.

  CALL SCREEN 100.

* Dialog Modules -------------------------------------------------------

MODULE status_0100 OUTPUT.
  SET PF-STATUS 'SCREEN_100'.
  SET TITLEBAR  'SCREEN_100'.
  IF area IS INITIAL.
    CREATE OBJECT area EXPORTING container_name = 'EDIT_CONTROL'.
  ENDIF.
  IF editor IS INITIAL.
    CREATE OBJECT editor EXPORTING parent = area.
  ENDIF.
  IF processor IS INITIAL.
    CREATE OBJECT processor.
  ENDIF.
  editor->set_wordwrap_behavior(
    EXPORTING
      wordwrap_mode     = 2
      wordwrap_position = 80 ).
  editor->set_text_as_r3table(
    EXPORTING
      table = source_table ).
  IF row <> 0.
    editor->highlight_lines(
      EXPORTING
        from_line = row
        to_line   = row ).
  ENDIF.
ENDMODULE.                    "STATUS_0100 OUTPUT

*

MODULE user_command_0100 INPUT.
  editor->get_text_as_r3table(
    IMPORTING
      table = source_table ).
  CLEAR source.
  LOOP AT source_table INTO source_line.
    IF source IS INITIAL.
      source = source_line.
    ELSE.
      source = |{ source }\n{ source_line }|.
    ENDIF.
  ENDLOOP.
  CASE sy-ucomm.
    WHEN 'CANCEL'.
      LEAVE PROGRAM.
    WHEN 'EXECUTE'.
      processor->process(
        EXPORTING
          js_source = source
          js_bp_line = row ).
    WHEN 'BREAKPOINT'.
      editor->get_selection_pos(
        IMPORTING
          from_line = cursor ).
      IF cursor <> row.
        row = cursor.
      ELSE.
        row = 0.
      ENDIF.
    WHEN 'JSLOAD'.
      sel_tit = 'Enter file name'.
      para = file_name.
      CALL SELECTION-SCREEN 500 STARTING AT 10 10.
      IF sy-subrc = 0.
        file_name = para.
        CALL FUNCTION 'GUI_UPLOAD'
          EXPORTING
            filename = file_name
          TABLES
            data_tab = source_table
          EXCEPTIONS
            OTHERS   = 4.
        IF sy-subrc <> 0.
          MESSAGE i888(sabapdemos) WITH 'Error when loading file'.
        ENDIF.
      ENDIF.
    WHEN 'JSDUMP'.
      sel_tit = 'Enter file name'.
      para = file_name.
      CALL SELECTION-SCREEN 500 STARTING AT 10 10.
      IF sy-subrc = 0.
        file_name = para.
        CALL FUNCTION 'GUI_DOWNLOAD'
          EXPORTING
            filename = file_name
          TABLES
            data_tab = source_table
          EXCEPTIONS
            OTHERS   = 4.
        IF sy-subrc <> 0.
          MESSAGE i888(sabapdemos) WITH 'Error when saving file'.
        ENDIF.
      ENDIF.
  ENDCASE.
  CLEAR sy-ucomm.
ENDMODULE.                    "USER_COMMAND_0100 INPUT
