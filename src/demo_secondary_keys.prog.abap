REPORT demo_secondary_keys.

DATA:
  g_lines      TYPE i,
  g_rtime1     TYPE decfloat34,
  g_rtime2     TYPE decfloat34,
  g_crtime1    TYPE char25,
  g_crtime2    TYPE char25,
  g_links      TYPE TABLE OF tline,
  g_ok_code    TYPE sy-ucomm.

CLASS demo DEFINITION FINAL.
  PUBLIC SECTION.
    CLASS-METHODS main.
  PRIVATE SECTION.
    TYPES: src_line TYPE c LENGTH 72,
           src      TYPE STANDARD TABLE OF src_line
                    WITH NON-UNIQUE DEFAULT KEY.
    CLASS-METHODS:
     load_source IMPORTING im_prog TYPE progname
                 RETURNING value(source) TYPE src,
     create_editor IMPORTING source TYPE src
                             parent_container TYPE REF TO cl_gui_custom_container
                   RETURNING value(editor)    TYPE REF TO cl_gui_abapedit.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA: container1 TYPE REF TO cl_gui_custom_container,
          container2 TYPE REF TO cl_gui_custom_container,
          srcedit1   TYPE REF TO cl_gui_abapedit,
          srcedit2   TYPE REF TO cl_gui_abapedit,
          source1    TYPE demo=>src,
          source2    TYPE demo=>src.
    source1 = demo=>load_source( im_prog = 'DEMO_SECONDARY_KEYS_NO_KEY' ).
    CREATE OBJECT container1
      EXPORTING
        container_name = 'CUSTOM_CONTAINER1'.
    srcedit1 = demo=>create_editor( source = source1 parent_container = container1 ).
    source2 = demo=>load_source( im_prog = 'DEMO_SECONDARY_KEYS_WITH_KEY' ).
    CREATE OBJECT container2
      EXPORTING
        container_name = 'CUSTOM_CONTAINER2'.
    srcedit2 = demo=>create_editor( source = source2 parent_container = container2 ).
    g_lines = 1000.
    CALL SCREEN 100.
  ENDMETHOD.

  METHOD load_source.
    DATA: tabix   TYPE sy-tabix,
          buffer  LIKE source,
          line    LIKE LINE OF source.
    READ REPORT im_prog INTO buffer.
    LOOP AT buffer TRANSPORTING NO FIELDS WHERE table_line CS 'CLASS measure IMPLEMENTATION'.
      tabix = sy-tabix + 1.
      LOOP AT buffer FROM tabix INTO line.
        IF line CS 'ENDCLASS.'.
          EXIT.
        ENDIF.
        APPEND line TO source.
      ENDLOOP.
      EXIT.
    ENDLOOP.
  ENDMETHOD.

  METHOD create_editor.
    CREATE OBJECT editor
      EXPORTING
        parent = parent_container.
    editor->set_text( source ).
    editor->set_readonly_mode( editor->true ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).

MODULE status_0100 OUTPUT.
  SET PF-STATUS 'STATUS_100'.
  SET TITLEBAR  'TITLE_100'.
  IF g_crtime1 IS INITIAL.
    g_crtime1 = '0'.
  ENDIF.
  IF g_crtime2 IS INITIAL.
    g_crtime2 = '0'.
  ENDIF.
ENDMODULE.

MODULE cancel_0100 INPUT.
  LEAVE PROGRAM.
ENDMODULE.

MODULE user_command_0100.
  CASE g_ok_code.
    WHEN 'INFO'.
      CALL FUNCTION 'HELP_OBJECT_SHOW'
        EXPORTING
          dokclass = 'RE'
          doklangu = sy-langu
          dokname  = 'DEMO_SECONDARY_KEYS'
        TABLES
          links    = g_links.
    WHEN 'RUN1'.
      CALL METHOD ('\PROGRAM=DEMO_SECONDARY_KEYS_NO_KEY\CLASS=MEASURE')=>runtime
        EXPORTING
          lines = g_lines
        RECEIVING
          rtime = g_rtime1.
      g_crtime1 = |{ g_rtime1 style = scientific }|.
    WHEN 'RUN2'.
      CALL METHOD ('\PROGRAM=DEMO_SECONDARY_KEYS_WITH_KEY\CLASS=MEASURE')=>runtime
        EXPORTING
          lines = g_lines
        RECEIVING
          rtime = g_rtime2.
      g_crtime2 = |{ g_rtime2 style = scientific }|.
  ENDCASE.
ENDMODULE.
