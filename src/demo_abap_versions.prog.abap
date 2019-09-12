REPORT demo_abap_versions.

CLASS display DEFINITION FINAL.
  PUBLIC SECTION.
    TYPES: txt_line TYPE c LENGTH 72,
           txt      TYPE STANDARD TABLE OF txt_line
                    WITH DEFAULT KEY.

    CLASS-METHODS:
      main,
      fill_abap_editor   IMPORTING editor TYPE REF TO cl_gui_abapedit
                                   text   TYPE  txt,
      read_abap_editor   IMPORTING editor TYPE REF TO cl_gui_abapedit
                         EXPORTING text   TYPE txt,
      show_docu,
      show_info.

  PRIVATE SECTION.
    CLASS-METHODS:
      prepare_editor,
      create_abap_editor
        IMPORTING parent_container TYPE REF TO cl_gui_custom_container
        RETURNING VALUE(editor)    TYPE REF TO cl_gui_abapedit.

ENDCLASS.

CLASS program DEFINITION FINAL.
  PUBLIC SECTION.
    CLASS-METHODS
      check.
  PRIVATE SECTION.
    CONSTANTS:
      prog TYPE sy-repid VALUE `DEMO_ABAP_VERSION_TEST`.
ENDCLASS.

TABLES sych_version.

DATA:
  g_ok_code        TYPE sy-ucomm,
  g_method         TYPE abap_bool,
  g_program        TYPE abap_bool,
  g_lines          TYPE display=>txt,
  g_editor         TYPE REF TO cl_gui_abapedit,
  g_links          TYPE TABLE OF tline,
  g_docu_container TYPE REF TO cl_gui_control.

START-OF-SELECTION.
  display=>main( ).

CLASS program IMPLEMENTATION.
  METHOD check.
    DATA:
      mess TYPE string,
      lin  TYPE i,
      wrd  TYPE string.

    SELECT SINGLE @abap_true
           FROM trdir
           WHERE name = @prog
           INTO @DATA(prog_flag).
    SELECT SINGLE @abap_true
           FROM trdir
           WHERE name = @( 'CL_' && prog && '=====CM001' )
           INTO @DATA(clpo_flag).
    IF prog_flag IS INITIAL OR clpo_flag IS INITIAL.
      MESSAGE TEXT-msp TYPE 'I' DISPLAY LIKE 'E'.
      RETURN.
    ENDIF.

    IF sych_version-version <> 'X' AND sych_version-version IS NOT INITIAL.
      SELECT SINGLE @abap_true
             FROM sych_version
             WHERE version = @sych_version-version
             INTO @DATA(version_flag).
      IF version_flag <> abap_true.
        MESSAGE TEXT-wrv TYPE 'S' DISPLAY LIKE 'E'.
        RETURN.
      ENDIF.
    ENDIF.

    DATA meth TYPE sy-repid.
    DATA code TYPE TABLE OF string.
    DATA program TYPE TABLE OF string.
    IF g_method = abap_true.
      meth = `CL_` && prog && `=====CM001`.
      READ REPORT meth INTO code.
      code = VALUE #( LET first_line = code[ 1 ]
                          last_line  = code[ lines( code ) ] IN
                      ( first_line )
                      ( LINES OF CONV #( g_lines ) )
                      ( last_line ) ).
      program = VALUE #(
      ( `CLASS-POOL.` )
      ( `INCLUDE cl_` && prog && `=====cu.` ) "Public
      ( `INCLUDE cl_` && prog && `=====co.` ) "Protected
      ( `INCLUDE cl_` && prog && `=====ci.` ) "Private
      ( `ENDCLASS.` )
      ( `CLASS cl_` && prog && ` IMPLEMENTATION.` )
      ( LINES OF code )
      ( `ENDCLASS.` ) ) ##NO_TEXT.
      SELECT SINGLE *
             FROM trdir
             WHERE name = @( 'CL_' && prog && '=====CP' )
             INTO @DATA(direntry).
    ELSE.
      READ REPORT prog INTO code.
      program = VALUE #( LET first_line = code[ 1 ] IN
                      ( first_line )
                      ( LINES OF CONV #( g_lines ) ) ).
      SELECT SINGLE *
             FROM trdir
             WHERE name = @prog
             INTO @direntry.
    ENDIF.

    direntry-uccheck = sych_version-version.
    SYNTAX-CHECK FOR program
       MESSAGE mess LINE lin WORD wrd
       DIRECTORY ENTRY direntry.

    IF sy-subrc = 0.
      MESSAGE TEXT-sok TYPE 'S'.
    ELSE.
      MESSAGE mess TYPE 'I' DISPLAY LIKE 'E'.
    ENDIF.

  ENDMETHOD.
ENDCLASS.

CLASS display IMPLEMENTATION.
  METHOD main.
    prepare_editor( ).
    sych_version-version = 'X'.
    CALL SCREEN 100.
  ENDMETHOD.

  METHOD prepare_editor.
    g_lines = VALUE #(
      ( '* Enter some ABAP code here ...' ) ) ##no_text.

    g_editor = display=>create_abap_editor( NEW cl_gui_custom_container( container_name = 'CUSTOM_CONTAINER' ) ).
  ENDMETHOD.

  METHOD create_abap_editor.
    CREATE OBJECT editor
      EXPORTING
        parent = parent_container.
    editor->set_toolbar_mode( 0 ).
    editor->set_statusbar_mode( 0 ).
    editor->set_readonly_mode( 0 ).
  ENDMETHOD.

  METHOD fill_abap_editor.
    editor->set_text( text ).
  ENDMETHOD.

  METHOD read_abap_editor.
    editor->get_text( IMPORTING table = text ).
  ENDMETHOD.

  METHOD show_docu.
    cl_abap_docu=>pop_up(
       EXPORTING
         version       =  sych_version-version
         keyword       = `` "otherwise parameter is c of length 1
      IMPORTING
        docu_container =  g_docu_container ).
  ENDMETHOD.

  METHOD show_info.
    CALL FUNCTION 'HELP_OBJECT_SHOW'
      EXPORTING
        dokclass = 'RE'
        doklangu = sy-langu
        dokname  = 'DEMO_ABAP_VERSIONS'
      TABLES
        links    = g_links.
  ENDMETHOD.

ENDCLASS.

MODULE status_0100 OUTPUT.
  SET PF-STATUS 'STATUS_100'.
  SET TITLEBAR  'TITLE_100'.
  display=>fill_abap_editor( editor = g_editor
                             text   = g_lines ).
  IF g_docu_container IS NOT INITIAL.
    cl_gui_control=>set_focus( g_docu_container ).
    cl_gui_cfw=>flush( ).
    CLEAR g_docu_container.
  ENDIF.
ENDMODULE.

MODULE cancel_0100 INPUT.
  LEAVE PROGRAM.
ENDMODULE.

MODULE user_command_0100.
  IF g_ok_code = 'INFO'.
    display=>show_info( ).
    CLEAR g_ok_code.
    RETURN.
  ENDIF.
  IF g_ok_code = 'DOCU'.
    display=>show_docu( ).
    CLEAR g_ok_code.
    RETURN.
  ENDIF.
  display=>read_abap_editor( EXPORTING editor = g_editor
                             IMPORTING text   = g_lines ).
  CASE g_ok_code.
    WHEN 'CHECK'.
      program=>check( ).
    WHEN 'CLEAR'.
      CLEAR g_lines.
  ENDCASE.
  CLEAR g_ok_code.
ENDMODULE.

MODULE help_request_0100.
  display=>show_info( ).
ENDMODULE.
