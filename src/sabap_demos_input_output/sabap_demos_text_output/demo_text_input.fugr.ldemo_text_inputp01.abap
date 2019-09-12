*----------------------------------------------------------------------*
***INCLUDE LDEMO_INPUT_TEXTP01.
*----------------------------------------------------------------------*
CLASS input_text_string IMPLEMENTATION.
  METHOD pbo.
    SET TITLEBAR  'SCREEN_100' WITH g_title.
    SET PF-STATUS 'SCREEN_100'.
    IF container IS INITIAL.
      CREATE OBJECT container
        EXPORTING
          container_name = 'TEXT_STRING'.
    ENDIF.
    IF editor IS INITIAL.
      CREATE OBJECT editor
        EXPORTING
          parent = container.
      editor->set_toolbar_mode( 0 ).
      editor->set_font_fixed( 1 ).
      editor->set_statusbar_mode( 0 ).
      editor->set_wordwrap_behavior( wordwrap_mode = 2 ).
      editor->set_readonly_mode( 0 ).
    ENDIF.
  ENDMETHOD.

  METHOD write_text_control.
    editor->set_text_as_r3table( table = text_table ).
  ENDMETHOD.

  METHOD read_text_control.
    editor->get_text_as_r3table( IMPORTING table = text_table ).
  ENDMETHOD.

  METHOD user_command.
    CASE ok_code.
      WHEN 'EXECUTE'.
        LEAVE TO SCREEN 0.
    ENDCASE.
  ENDMETHOD.

ENDCLASS.               "input_text_string
