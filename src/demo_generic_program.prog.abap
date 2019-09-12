REPORT demo_generic_program.

CLASS display DEFINITION FINAL.
  PUBLIC SECTION.
    TYPES: txt_line TYPE c LENGTH 72,
           txt      TYPE STANDARD TABLE OF txt_line
                    WITH DEFAULT KEY.
    CLASS-DATA:
      read_only TYPE abap_bool READ-ONLY VALUE abap_true.

    CLASS-METHODS:
      class_constructor,
      main,
      fill_abap_editor   IMPORTING editor TYPE REF TO cl_gui_abapedit
                                   text TYPE  txt,
      read_abap_editor   IMPORTING editor TYPE REF TO cl_gui_abapedit
                         EXPORTING text TYPE txt.

  PRIVATE SECTION.
    CLASS-METHODS:
      prepare_editors,
      create_abap_editor
        IMPORTING parent_container TYPE REF TO cl_gui_custom_container
        RETURNING VALUE(editor)    TYPE REF TO cl_gui_abapedit.

ENDCLASS.

CLASS program DEFINITION FINAL.
  PUBLIC SECTION.
    CLASS-METHODS:
      execute IMPORTING check_only TYPE abap_bool DEFAULT abap_false,
      build_source          RETURNING VALUE(rc) TYPE sy-subrc,
      check_declarations    RETURNING VALUE(rc) TYPE sy-subrc,
      check_implementation  RETURNING VALUE(rc) TYPE sy-subrc,
      check_syntax          RETURNING VALUE(rc) TYPE sy-subrc.

  PRIVATE SECTION.
    CLASS-DATA:
      source TYPE display=>txt.

ENDCLASS.

DATA:
  g_links      TYPE TABLE OF tline,
  g_ok_code    TYPE sy-ucomm.

DATA:
  g_editor1    TYPE REF TO cl_gui_abapedit,
  g_editor2    TYPE REF TO cl_gui_abapedit.

DATA:
  g_declarations      TYPE display=>txt,
  g_implementation    TYPE display=>txt.

START-OF-SELECTION.
  display=>main( ).

CLASS program IMPLEMENTATION.
  METHOD execute.
    DATA program TYPE progname.
    DATA class TYPE string.

    IF check_declarations( )   <> 0 OR
       check_implementation( ) <> 0.
      RETURN.
    ENDIF.

    IF build_source( ) <> 0.
      RETURN.
    ENDIF.

    IF check_only = abap_true.
      MESSAGE text-sok TYPE 'S'.
      RETURN.
    ENDIF.

    DATA(source_name) = 'SOURCE'.
    FIELD-SYMBOLS <source> TYPE STANDARD TABLE.
    ASSIGN (source_name) TO <source>.
    TRY.
        GENERATE SUBROUTINE POOL <source> NAME program.
      CATCH cx_sy_generate_subpool_full.
        MESSAGE text-srf TYPE 'I' DISPLAY LIKE 'E'.
        RETURN.
    ENDTRY.

    class = `\PROGRAM=` && program && `\CLASS=DEMO`.
    TRY.
        CALL METHOD (class)=>main.
      CATCH cx_root INTO DATA(exc) ##CATCH_ALL.
        MESSAGE exc->get_text( ) TYPE 'I' DISPLAY LIKE 'E'.
    ENDTRY.

  ENDMETHOD.

  METHOD build_source.
    DATA idx TYPE sy-tabix.
    DATA subrc TYPE sy-subrc.

    TRY.
        READ REPORT 'DEMO_GENERIC_TEMPLATE' INTO source.
        subrc = sy-subrc.
      CATCH cx_sy_read_src_line_too_long.
        subrc = 4.
    ENDTRY.

    IF subrc = 0.
      FIND '* declarations' IN TABLE source MATCH LINE idx.
      subrc = sy-subrc.
      DELETE source INDEX idx.
      INSERT LINES OF g_declarations INTO source INDEX idx.
    ENDIF.

    IF subrc = 0.
      FIND '* implementation' IN TABLE source MATCH LINE idx.
      subrc = sy-subrc.
      DELETE source INDEX idx.
      INSERT LINES OF g_implementation INTO source INDEX idx.
    ENDIF.

    IF subrc <> 0.
      MESSAGE text-wtl TYPE 'I' DISPLAY LIKE 'E'.
      LEAVE PROGRAM.
    ENDIF.

    rc = check_syntax( ).

  ENDMETHOD.

  METHOD check_declarations.
    DATA: code LIKE source,
          mess TYPE string,
          lin  TYPE i ##needed,
          wrd  TYPE string ##needed,
          warnings TYPE  STANDARD TABLE OF rslinlmsg.

    "Normal syntax check to get typos
    code = VALUE #( ( 'PROGRAM.' ) ).
    APPEND LINES OF g_declarations TO code.
    SYNTAX-CHECK FOR code MESSAGE mess LINE lin WORD wrd
                     ID 'MSG' TABLE warnings
                     PROGRAM sy-repid.
    rc = sy-subrc.
    IF rc <> 0.
      MESSAGE mess TYPE 'I' DISPLAY LIKE 'E'.
      RETURN.
    ENDIF.
    IF warnings IS NOT INITIAL.
      DATA(warning) = warnings[ 1 ].
      MESSAGE warning-message TYPE 'I' DISPLAY LIKE 'W'.
      RETURN.
    ENDIF.

    "Restrict to declarative statements
    code = VALUE #( ( 'PROGRAM.' )
                    ( 'CLASS class DEFINITION.' )
                    ( 'PUBLIC SECTION.' )
                    ( 'ENDCLASS.' ) ) ##no_text.
    INSERT LINES OF g_declarations INTO code INDEX lines( code ).
    SYNTAX-CHECK FOR code MESSAGE mess LINE lin WORD wrd
                     ID 'MSG' TABLE warnings
                     PROGRAM 'DEMO_GENERIC_TEMPLATE'.
    rc = sy-subrc.
    IF rc <> 0.
      MESSAGE text-dcl TYPE 'S' DISPLAY LIKE 'E'.
    ENDIF.
    IF warnings IS NOT INITIAL.
      warning = warnings[ 1 ].
      MESSAGE warning-message TYPE 'I' DISPLAY LIKE 'W'.
      RETURN.
    ENDIF.
  ENDMETHOD.

  METHOD check_implementation.
    "Only a very limited set of statements is allowed
    DATA black_list TYPE cl_demo_secure_abap_code=>string_table.
    DATA white_list TYPE cl_demo_secure_abap_code=>string_table.

    "Blacklist
    black_list = VALUE #(
      ( `->` )
      ( `=>` )
      ( `DATA(` ) ).

    "Whitelist
    white_list = VALUE #(
      ( `FIELD-SYMBOLS`        )

      ( `CHECK`                )
      ( `EXIT`                 )
      ( `RETURN`               )

      ( `DO`                   )
      ( `ENDDO`                )
      ( `WHILE`                )
      ( `ENDWHILE`             )
      ( `CASE`                 )
      ( `WHEN`                 )
      ( `ENDCASE`              )
      ( `IF`                   )
      ( `ELSEIF`               )
      ( `ELSE`                 )
      ( `ENDIF`                )

      ( `MOVE-CORRESPONDING`   )
      ( `ASSIGN`               )
      ( `UNASSIGN`             )
      ( `CLEAR`                )
      ( `FREE`                 )

      ( `FIND`                 )
      ( `REPLACE`              )

      ( `APPEND`               )
      ( `INSERT`               )
      ( `MODIFY`               )
      ( `DELETE`               )
      ( `COLLECT`              )
      ( `READ`                 )
      ( `LOOP`                 )
      ( `ENDLOOP`              )
      ( `SORT`                 ) ).

    rc = cl_demo_secure_abap_code=>check(
      source_code  = g_implementation
      black_list   = black_list
      white_list   = white_list
      declarations = g_declarations ).
    IF rc <> 0.
      MESSAGE text-exe TYPE 'S' DISPLAY LIKE 'E'.
    ENDIF.

  ENDMETHOD.

  METHOD check_syntax.
    DATA: mess TYPE string,
          lin  TYPE i ##needed,
          wrd  TYPE string ##needed,
          warnings TYPE  STANDARD TABLE OF rslinlmsg.
    "Syntax check for implementations with declarations
    SYNTAX-CHECK FOR source MESSAGE mess LINE lin WORD wrd
                     ID 'MSG' TABLE warnings
                     PROGRAM 'DEMO_GENERIC_TEMPLATE'.
    rc = sy-subrc.
    IF rc <> 0.
      MESSAGE mess TYPE 'I' DISPLAY LIKE 'E'.
    ENDIF.
    IF warnings IS NOT INITIAL.
      DATA(warning) = warnings[ 1 ].
      MESSAGE warning-message TYPE 'I' DISPLAY LIKE 'W'.
      RETURN.
    ENDIF.
  ENDMETHOD.
ENDCLASS.

CLASS display IMPLEMENTATION.
  METHOD class_constructor.
    "Security checks

    "Not allowed in production systems
    IF cl_abap_demo_services=>is_production_system( ).
      MESSAGE text-prs TYPE 'S' DISPLAY LIKE 'W'.
      RETURN.
    ENDIF.

    "Only users who are allowed to use the ABAP Editor
    CALL FUNCTION 'AUTHORITY_CHECK_TCODE'
      EXPORTING
        tcode  = 'SE38'
      EXCEPTIONS
        ok     = 1
        not_ok = 2
        OTHERS = 3.

    "Only users who are allowed to create and run $TMP programs
    IF sy-subrc < 2.
      AUTHORITY-CHECK OBJECT 'S_DEVELOP'
        ID 'DEVCLASS' FIELD '$TMP'
        ID 'OBJTYPE'  FIELD 'PROG'
        ID 'OBJNAME'  DUMMY
        ID 'P_GROUP'  DUMMY
        ID 'ACTVT'    FIELD '02'.
      IF sy-subrc =  0.
        read_only = abap_false.
        RETURN.
      ENDIF.
    ENDIF.

    MESSAGE text-aut TYPE 'S' DISPLAY LIKE 'E'.

  ENDMETHOD.

  METHOD main.

    prepare_editors( ).
    CALL SCREEN 100.

  ENDMETHOD.

  METHOD prepare_editors.
    DATA:
      container1 TYPE REF TO cl_gui_custom_container,
      container2 TYPE REF TO cl_gui_custom_container.

    g_declarations = VALUE #(
      ( 'DATA text TYPE string VALUE `Hello, I''m generic!`.' ) )
      ##no_text.
    g_implementation = VALUE #(
      ( 'cl_demo_output' && '=>display_text( text ).' ) )
      ##no_text.

    CREATE OBJECT container1
      EXPORTING
        container_name = 'CUSTOM_CONTAINER1'.
    g_editor1 = display=>create_abap_editor( container1 ).
    CREATE OBJECT container2
      EXPORTING
        container_name = 'CUSTOM_CONTAINER2'.
    g_editor2 = display=>create_abap_editor( container2 ).
  ENDMETHOD.

  METHOD create_abap_editor.
    CREATE OBJECT editor
      EXPORTING
        parent = parent_container.
    editor->set_toolbar_mode( 0 ).
    editor->set_statusbar_mode( 0 ).
    IF read_only = abap_true.
      editor->set_readonly_mode( 1 ).
    ELSE.
      editor->set_readonly_mode( 0 ).
    ENDIF.
  ENDMETHOD.

  METHOD fill_abap_editor.
    editor->set_text( text ).
  ENDMETHOD.

  METHOD read_abap_editor.
    editor->get_text( IMPORTING table = text ).
  ENDMETHOD.

ENDCLASS.

MODULE status_0100 OUTPUT.
  SET PF-STATUS 'STATUS_100'.
  SET TITLEBAR  'TITLE_100'.
  display=>fill_abap_editor( editor = g_editor1
                             text   = g_declarations ).
  display=>fill_abap_editor( editor = g_editor2
                             text   = g_implementation ).
ENDMODULE.

MODULE cancel_0100 INPUT.
  LEAVE PROGRAM.
ENDMODULE.

MODULE user_command_0100.
  IF g_ok_code = 'INFO'.
    CALL FUNCTION 'HELP_OBJECT_SHOW'
      EXPORTING
        dokclass = 'RE'
        doklangu = sy-langu
        dokname  = 'DEMO_GENERIC_PROGRAM'
      TABLES
        links    = g_links.
    CLEAR g_ok_code.
    RETURN.
  ENDIF.
  IF display=>read_only = abap_true.
    MESSAGE text-aut TYPE 'S' DISPLAY LIKE 'E'.
    CLEAR g_ok_code.
    RETURN.
  ENDIF.
  display=>read_abap_editor( EXPORTING editor = g_editor1
                             IMPORTING text   = g_declarations ).
  display=>read_abap_editor( EXPORTING editor = g_editor2
                             IMPORTING text   = g_implementation ).
  CASE g_ok_code.
    WHEN 'EXECUTE'.
      program=>execute( ).
    WHEN 'CHECK'.
      program=>execute( check_only = abap_true ).
    WHEN 'CLEAR'.
      CLEAR: g_declarations,
             g_implementation.
  ENDCASE.
  CLEAR g_ok_code.
ENDMODULE.
