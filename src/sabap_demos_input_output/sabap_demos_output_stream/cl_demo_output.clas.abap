class CL_DEMO_OUTPUT definition
  public
  final
  create private .

public section.

  interfaces IF_DEMO_OUTPUT_FORMATS .
  interfaces IF_DEMO_OUTPUT .

  constants HTML_MODE type STRING value 'HTML'. "#EC NOTEXT
  constants TEXT_MODE type STRING value 'TEXT'. "#EC NOTEXT

  methods CONSTRUCTOR
    importing
      !MODE type STRING default HTML_MODE .
  class-methods CLASS_CONSTRUCTOR .
  class-methods WRITE
    importing
      !DATA type ANY
      !NAME type STRING optional .
  class-methods WRITE_DATA
    importing
      !VALUE type DATA
      !NAME type STRING optional .
  class-methods DISPLAY_DATA
    importing
      !VALUE type DATA
      !NAME type STRING optional .
  class-methods WRITE_TEXT
    importing
      !TEXT type CLIKE .
  class-methods DISPLAY_TEXT
    importing
      !TEXT type CLIKE .
  class-methods DISPLAY
    importing
      !DATA type ANY optional
      !NAME type STRING optional
    preferred parameter DATA .
  class-methods WRITE_XML
    importing
      !XML type SIMPLE .
  class-methods WRITE_JSON
    importing
      !JSON type SIMPLE .
  class-methods DISPLAY_XML
    importing
      !XML type SIMPLE .
  class-methods DISPLAY_JSON
    importing
      !JSON type SIMPLE .
  class-methods WRITE_HTML
    importing
      !HTML type CSEQUENCE .
  class-methods DISPLAY_HTML
    importing
      !HTML type CSEQUENCE .
  class-methods BEGIN_SECTION
    importing
      !TITLE type CLIKE optional .
  class-methods END_SECTION .
  class-methods LINE .
  class-methods NEXT_SECTION
    importing
      !TITLE type CLIKE .
  class-methods SET_MODE
    importing
      !MODE type STRING default HTML_MODE .
  class-methods NEW
    importing
      !MODE type STRING default HTML_MODE
    returning
      value(OUTPUT) type ref to IF_DEMO_OUTPUT .
  class-methods GET
    importing
      !DATA type ANY optional
      !NAME type STRING optional
    preferred parameter DATA
    returning
      value(OUTPUT) type STRING .
  PROTECTED SECTION.
private section.

  class-data STATIC_STREAM_HANDLE type ref to CL_DEMO_OUTPUT_STREAM .
  class-data STATIC_HEADING_LEVEL type I .
  class-data STATIC_MODE type STRING value HTML_MODE ##NO_TEXT.
  data STREAM_HANDLE type ref to CL_DEMO_OUTPUT_STREAM .
  data HEADING_LEVEL type I .
  data MODE type STRING value HTML_MODE ##NO_TEXT.
  class-data STATIC_HTML_STRING type STRING .
  class-data STATIC_TEXT_STRING type STRING .
  class-data HTML_STRING type STRING .
  class-data TEXT_STRING type STRING .

  class-methods EXEC_WRITE
    importing
      !DATA type ANY
      !STREAM_HANDLE type ref to CL_DEMO_OUTPUT_STREAM
      !NAME type STRING optional .
  methods SET_INSTANCE_HANDLER
    importing
      value(MODE) type STRING default HTML_MODE .
  class-methods EXEC_WRITE_DATA
    importing
      !VALUE type DATA
      !STREAM_HANDLE type ref to CL_DEMO_OUTPUT_STREAM
      !NAME type STRING optional .
  class-methods EXEC_WRITE_TEXT
    importing
      !TEXT type CLIKE
      !STREAM_HANDLE type ref to CL_DEMO_OUTPUT_STREAM .
  class-methods EXEC_WRITE_XML
    importing
      !XML type SIMPLE
      !STREAM_HANDLE type ref to CL_DEMO_OUTPUT_STREAM .
  class-methods EXEC_WRITE_JSON
    importing
      !JSON type SIMPLE
      !STREAM_HANDLE type ref to CL_DEMO_OUTPUT_STREAM .
  class-methods EXEC_WRITE_HTML
    importing
      !HTML type CSEQUENCE
      !STREAM_HANDLE type ref to CL_DEMO_OUTPUT_STREAM .
  class-methods EXEC_BEGIN_SECTION
    importing
      !TITLE type CLIKE
      !STREAM_HANDLE type ref to CL_DEMO_OUTPUT_STREAM
    changing
      !HEADING_LEVEL type I .
  class-methods EXEC_END_SECTION
    changing
      !HEADING_LEVEL type I .
  class-methods SET_STATIC_HTML
    for event COMPLETED of CL_DEMO_OUTPUT_HTML
    importing
      !EV_HTML .
  class-methods SET_STATIC_TEXT
    for event COMPLETED of CL_DEMO_OUTPUT_TEXT
    importing
      !EV_TEXT .
  methods SET_INSTANCE_HTML
    for event COMPLETED of CL_DEMO_OUTPUT_HTML
    importing
      !EV_HTML .
  methods SET_INSTANCE_TEXT
    for event COMPLETED of CL_DEMO_OUTPUT_TEXT
    importing
      !EV_TEXT .
  class-methods SET_STATIC_HANDLER
    importing
      value(MODE) type STRING default HTML_MODE .
  class-methods GET_NAME
    returning
      value(NAME) type STRING .
  class-methods GET_ADT_CONSOLE_FLAG
    returning
      value(ADT_CONSOLE_FLAG) type ABAP_BOOL .
ENDCLASS.



CLASS CL_DEMO_OUTPUT IMPLEMENTATION.


  METHOD begin_section.
    exec_begin_section( EXPORTING
                          stream_handle = static_stream_handle
                          title         = title
                        CHANGING
                          heading_level = static_heading_level ).
  ENDMETHOD.


  METHOD class_constructor.
    static_stream_handle = cl_demo_output_stream=>open( ).
  ENDMETHOD.


  METHOD constructor.
    me->mode = mode.
    stream_handle = cl_demo_output_stream=>open( ).
  ENDMETHOD.


  METHOD display.

    IF data IS SUPPLIED.
      cl_demo_output=>write( data = data
                             name = name  ).
    ENDIF.

    set_static_handler( cl_demo_output=>static_mode ).
    CASE cl_demo_output=>static_mode.
      WHEN html_mode.
        cl_demo_output_html=>set_display( abap_true ).
      WHEN text_mode.
        cl_demo_output_text=>set_display( abap_true ).
      WHEN OTHERS.
        cl_demo_output_html=>set_display( abap_true ).
    ENDCASE.
    static_stream_handle->close( ).
    static_heading_level = 0.
    SET HANDLER cl_demo_output_html=>handle_output FOR static_stream_handle ACTIVATION ' '.
    SET HANDLER cl_demo_output_text=>handle_output FOR static_stream_handle ACTIVATION ' '.

    static_stream_handle = cl_demo_output_stream=>open( ).

  ENDMETHOD.


  METHOD display_data.
    write_data( value = value
                name  = name ).
    display( ).
  ENDMETHOD.


  METHOD display_html.
    write_html( html = html ).
    display( ).
  ENDMETHOD.


  METHOD display_json.
    write_json( json = json ).
    display( ).
  ENDMETHOD.


  METHOD display_text.
    write_text(
    EXPORTING
      text   = text ).
    display( ).
  ENDMETHOD.


  METHOD display_xml.
    write_xml( xml = xml ).
    display( ).
  ENDMETHOD.


  METHOD end_section.
    exec_end_section( CHANGING
                        heading_level = static_heading_level ).
  ENDMETHOD.


  METHOD exec_begin_section.
    DATA type TYPE c LENGTH 1.
    DATA str TYPE string.
    DESCRIBE FIELD title TYPE type.
    heading_level = heading_level + 1.
    IF heading_level > 4.
      heading_level = 4.
    ENDIF.
    IF title IS NOT INITIAL.
      CASE type.
        WHEN 'g'.
          stream_handle->write_text(
            EXPORTING
              iv_text   = title
              iv_format = if_demo_output_formats=>heading
              iv_level  = heading_level  ).
        WHEN OTHERS.
          str = title.
          stream_handle->write_text(
            EXPORTING
              iv_text   = str
              iv_format = if_demo_output_formats=>heading
              iv_level  = heading_level  ).
      ENDCASE.
    ENDIF.
  ENDMETHOD.


  METHOD exec_end_section.
    heading_level = heading_level - 1.
    IF heading_level < 0.
      heading_level = 0.
    ENDIF.
  ENDMETHOD.


  METHOD exec_write.
    DATA type TYPE c LENGTH 1.
    DATA str TYPE string.
    DATA comp TYPE i ##needed.
    DATA pass_name type string.

    pass_name = get_name( ). "must be called for stack counting
    IF name IS NOT INITIAL.
      pass_name = name.
    ENDIF.

    DESCRIBE FIELD data TYPE type COMPONENTS comp.
    IF data IS NOT INITIAL.
      CASE type.
        WHEN 'g'.
          stream_handle->write_text(
            EXPORTING
              iv_text   = data
              iv_format = if_demo_output_formats=>nonprop ).
        WHEN 'C'.
          str = data.
          stream_handle->write_text(
            EXPORTING
              iv_text   = str
              iv_format = if_demo_output_formats=>nonprop ).
        WHEN OTHERS.
          stream_handle->write_data(
            EXPORTING
              ia_value  = data
              iv_format = if_demo_output_formats=>nonprop
              iv_name   = pass_name ).
      ENDCASE.
    ELSE.
      stream_handle->write_data(
        EXPORTING
          ia_value  = data
          iv_format = if_demo_output_formats=>nonprop
          iv_name   = pass_name ).
    ENDIF.
  ENDMETHOD.


  METHOD exec_write_data.
    DATA pass_name type string.

    pass_name = get_name( ). "must be called for stack counting
    IF name IS NOT INITIAL.
      pass_name = name.
    ENDIF.

    stream_handle->write_data( ia_value = value
                               iv_name  = pass_name ).
  ENDMETHOD.


  METHOD exec_write_html.
    DATA type TYPE c LENGTH 1.
    DATA str TYPE string.
    DESCRIBE FIELD html TYPE type.
    CASE type.
      WHEN 'g'.
        stream_handle->write_html( iv_html = html ).
      WHEN OTHERS.
        str = html.
        stream_handle->write_html( iv_html = str ).
    ENDCASE.
  ENDMETHOD.


  METHOD exec_write_json.
    DATA type TYPE c LENGTH 1.
    DATA str TYPE string.
    DATA xstr TYPE xstring.
    DESCRIBE FIELD json TYPE type.
    CASE type.
      WHEN 'g'.
        stream_handle->write_json( iv_json = json ).
      WHEN 'C'.
        str = json.
        stream_handle->write_json( iv_json = str ).
      WHEN  'y'.
        stream_handle->write_json( iv_xjson = json ).
      WHEN 'X'.
        xstr = json.
        stream_handle->write_json( iv_xjson = xstr ).
      WHEN OTHERS.
        RETURN.
    ENDCASE.
  ENDMETHOD.


  METHOD exec_write_text.
    DATA type TYPE c LENGTH 1.
    DATA str TYPE string.
    DESCRIBE FIELD text TYPE type.
    CASE type.
      WHEN 'g'.
        stream_handle->write_text(
          EXPORTING
            iv_text   = text  ).
      WHEN OTHERS.
        str = text.
        stream_handle->write_text(
          EXPORTING
            iv_text   = str  ).
    ENDCASE.
  ENDMETHOD.


  METHOD exec_write_xml.
    DATA type TYPE c LENGTH 1.
    DATA str TYPE string.
    DATA xstr TYPE xstring.
    DESCRIBE FIELD xml TYPE type.
    CASE type.
      WHEN 'g'.
        stream_handle->write_xml( iv_xml = xml ).
      WHEN 'C'.
        str = xml.
        stream_handle->write_xml( iv_xml = str ).
      WHEN  'y'.
        stream_handle->write_xml( iv_xxml = xml ).
      WHEN 'X'.
        xstr = xml.
        stream_handle->write_xml( iv_xxml = xstr ).
      WHEN OTHERS.
        RETURN.
    ENDCASE.
  ENDMETHOD.


  METHOD get.

    IF data IS SUPPLIED.
      cl_demo_output=>write( data = data
                             name = name ).
    ENDIF.

    set_static_handler( cl_demo_output=>static_mode ).
    CASE cl_demo_output=>static_mode.
      WHEN html_mode.
        cl_demo_output_html=>set_display( abap_false ).
        SET HANDLER set_static_html ACTIVATION 'X'.
        static_stream_handle->close( ).
        output = static_html_string.
        CLEAR static_html_string.
      WHEN text_mode.
        cl_demo_output_text=>set_display( abap_false ).
        SET HANDLER set_static_text ACTIVATION 'X'.
        static_stream_handle->close( ).
        output = static_text_string.
        CLEAR static_text_string.
      WHEN OTHERS.
        cl_demo_output_html=>set_display( abap_false ).
        SET HANDLER set_static_html ACTIVATION 'X'.
        static_stream_handle->close( ).
        output = static_html_string.
        CLEAR static_html_string.
    ENDCASE.

    static_heading_level = 0.
    SET HANDLER set_static_html ACTIVATION ' '.
    SET HANDLER set_static_text ACTIVATION ' '.
    SET HANDLER cl_demo_output_html=>handle_output FOR static_stream_handle ACTIVATION ' '.
    SET HANDLER cl_demo_output_text=>handle_output FOR static_stream_handle ACTIVATION ' '.
    static_stream_handle = cl_demo_output_stream=>open( ).

  ENDMETHOD.


  METHOD get_adt_console_flag.
    "Special feature for programs submitted in ADT with F9
    TRY.
        IMPORT adt_console_flag = adt_console_flag FROM MEMORY ID 'ADT_CONSOLE_FLAG'.
        IF sy-subrc <> 0.
          CLEAR adt_console_flag.
        ENDIF.
      CATCH cx_root ##CATCH_ALL.
        CLEAR adt_console_flag.
    ENDTRY.
  ENDMETHOD.


  METHOD get_name.
    DATA: lt_stack TYPE abap_callstack,
          ls_stack TYPE LINE OF abap_callstack,
          lt_lines TYPE TABLE OF abap_callstack_line-line.
    CALL FUNCTION 'SYSTEM_CALLSTACK'
      IMPORTING
        callstack = lt_stack.
    LOOP AT lt_stack INTO ls_stack WHERE mainprogram CS 'CL_DEMO_OUTPUT' ##no_text ##INTO_OK.
      DATA(idx) = sy-tabix.
    ENDLOOP.
    LOOP AT lt_stack INTO ls_stack FROM idx + 1 ##INTO_OK.
      APPEND ls_stack-line TO lt_lines.
    ENDLOOP.
    READ TABLE lt_stack INTO ls_stack INDEX idx + 1.
*      TRY.
*          name = code_scan=>get_par_name( stack_frame = ls_stack
*                                          lines       = lt_lines ).
*        CATCH cx_name.
**        IF cl_abap_docu_system=>techdev = abap_true.
**          MESSAGE 'Notify owner of CL_DEMO_OUPUT' TYPE 'X' ##no_text.
**        ENDIF.
*          TRY.
*              name = introspection=>get_par_name( ls_stack ).
*            CATCH cx_name.
*              CLEAR name.
*          ENDTRY.
*      ENDTRY.
    TRY.
        name = code_analysis=>get_par_name( stack_frame = ls_stack
                                            lines       = lt_lines ).
      CATCH cx_name.
*        IF cl_abap_docu_system=>techdev = abap_true.
*          MESSAGE 'Notify owner of CL_DEMO_OUPUT' TYPE 'X' ##no_text.
*        ELSE.
          CLEAR name.
*        ENDIF.
    ENDTRY.
*    ENDIF.
  ENDMETHOD.


  METHOD if_demo_output~begin_section.
    exec_begin_section( EXPORTING
                          stream_handle = stream_handle
                          title         = title
                        CHANGING
                          heading_level = heading_level ).
    output = me.
  ENDMETHOD.


  METHOD if_demo_output~display.

    IF data IS SUPPLIED.
      me->if_demo_output~write( data = data
                                name = name ).
    ENDIF.

    set_instance_handler( me->mode ).
    CASE me->mode.
      WHEN html_mode.
        cl_demo_output_html=>set_display( abap_true ).
      WHEN text_mode.
        cl_demo_output_text=>set_display( abap_true ).
      WHEN OTHERS.
        cl_demo_output_html=>set_display( abap_true ).
    ENDCASE.
    stream_handle->close( ).
    heading_level = 0.
    SET HANDLER cl_demo_output_html=>handle_output FOR stream_handle ACTIVATION ' '.
    SET HANDLER cl_demo_output_text=>handle_output FOR stream_handle ACTIVATION ' '.

    stream_handle = cl_demo_output_stream=>open( ).

    output = me.

  ENDMETHOD.


  METHOD if_demo_output~end_section.
    exec_end_section( CHANGING
                        heading_level = heading_level ).
    output = me.
  ENDMETHOD.


  METHOD if_demo_output~get.

    IF data IS SUPPLIED.
      me->if_demo_output~write( data = data
                                name = name ).
    ENDIF.

    set_instance_handler( me->mode ).
    CASE me->mode.
      WHEN html_mode.
        cl_demo_output_html=>set_display( abap_false ).
        SET HANDLER set_instance_html ACTIVATION 'X'.
        stream_handle->close( ).
        output = html_string.
        CLEAR html_string.
      WHEN text_mode.
        cl_demo_output_text=>set_display( abap_false ).
        SET HANDLER set_instance_text ACTIVATION 'X'.
        stream_handle->close( ).
        output = text_string.
        CLEAR text_string.
      WHEN OTHERS.
        cl_demo_output_html=>set_display( abap_false ).
        SET HANDLER set_instance_html ACTIVATION 'X'.
        stream_handle->close( ).
        output = html_string.
        CLEAR html_string.
    ENDCASE.

    heading_level = 0.
    SET HANDLER set_instance_html ACTIVATION ' '.
    SET HANDLER set_instance_text ACTIVATION ' '.
    SET HANDLER cl_demo_output_html=>handle_output FOR stream_handle ACTIVATION ' '.
    SET HANDLER cl_demo_output_text=>handle_output FOR stream_handle ACTIVATION ' '.
    stream_handle = cl_demo_output_stream=>open( ).

  ENDMETHOD.


  METHOD if_demo_output~line.
    if_demo_output~write_html( `<hr>` ).
    output = me.
  ENDMETHOD.


  METHOD if_demo_output~next_section.
    if_demo_output~end_section( ).
    if_demo_output~begin_section( title ).
    output = me.
  ENDMETHOD.


  METHOD if_demo_output~write.
    exec_write( stream_handle = stream_handle
                data          = data
                name          = name ).
    output = me.
  ENDMETHOD.


  METHOD if_demo_output~write_data.
    exec_write_data( stream_handle = stream_handle
                     value         = value
                     name          = name ).
    output = me.
  ENDMETHOD.


  METHOD if_demo_output~write_html.
    exec_write_html( stream_handle = stream_handle
                     html          = html ).
    output = me.
  ENDMETHOD.


  METHOD if_demo_output~write_json.
    exec_write_json( stream_handle = stream_handle
                     json          = json ).
    output = me.
  ENDMETHOD.


  METHOD if_demo_output~write_text.
    exec_write_text( stream_handle = stream_handle
                     text          = text ).
    output = me.
  ENDMETHOD.


  METHOD if_demo_output~write_xml.
    exec_write_xml( stream_handle = stream_handle
                    xml           = xml ).
    output = me.
  ENDMETHOD.


  METHOD line.
    write_html( `<hr>` ).
  ENDMETHOD.


  METHOD new.
    output = NEW cl_demo_output( mode ).
  ENDMETHOD.


  METHOD next_section.
    end_section( ).
    begin_section( title ).
  ENDMETHOD.


  METHOD set_instance_handler.

    IF get_adt_console_flag( ).
      mode = text_mode.
    ENDIF.

    CASE mode.
      WHEN html_mode.
        SET HANDLER cl_demo_output_html=>handle_output FOR stream_handle ACTIVATION 'X'.
        SET HANDLER cl_demo_output_text=>handle_output FOR stream_handle ACTIVATION ' '.
      WHEN text_mode.
        SET HANDLER cl_demo_output_html=>handle_output FOR stream_handle ACTIVATION ' '.
        SET HANDLER cl_demo_output_text=>handle_output FOR stream_handle ACTIVATION 'X '.
      WHEN OTHERS.
        SET HANDLER cl_demo_output_html=>handle_output FOR stream_handle ACTIVATION 'X'.
        SET HANDLER cl_demo_output_text=>handle_output FOR stream_handle ACTIVATION ' '.
    ENDCASE.
  ENDMETHOD.


  METHOD set_instance_html.
    html_string = ev_html.
  ENDMETHOD.


  METHOD set_instance_text.
    text_string = ev_text.
  ENDMETHOD.


  METHOD set_mode.
    cl_demo_output=>static_mode = mode.
  ENDMETHOD.


  METHOD set_static_handler.

    IF get_adt_console_flag( ).
      mode = text_mode.
    ENDIF.

    CASE mode.
      WHEN html_mode.
        SET HANDLER cl_demo_output_html=>handle_output FOR static_stream_handle ACTIVATION 'X'.
        SET HANDLER cl_demo_output_text=>handle_output FOR static_stream_handle ACTIVATION ' '.
      WHEN text_mode.
        SET HANDLER cl_demo_output_html=>handle_output FOR static_stream_handle ACTIVATION ' '.
        SET HANDLER cl_demo_output_text=>handle_output FOR static_stream_handle ACTIVATION 'X '.
      WHEN OTHERS.
        SET HANDLER cl_demo_output_html=>handle_output FOR static_stream_handle ACTIVATION 'X'.
        SET HANDLER cl_demo_output_text=>handle_output FOR static_stream_handle ACTIVATION ' '.
    ENDCASE.
  ENDMETHOD.


  METHOD set_static_html.
    static_html_string = ev_html.
  ENDMETHOD.


  METHOD set_static_text.
    static_text_string = ev_text.
  ENDMETHOD.


  METHOD write.
    exec_write( stream_handle = static_stream_handle
                data          = data
                name   = name ).
  ENDMETHOD.


  METHOD write_data.
    exec_write_data( stream_handle = static_stream_handle
                     value         = value
                     name          = name ).
  ENDMETHOD.


  METHOD write_html.
    exec_write_html( stream_handle = static_stream_handle
                     html          = html ).
  ENDMETHOD.


  METHOD write_json.
    exec_write_json( stream_handle = static_stream_handle
                     json          = json ).
  ENDMETHOD.


  METHOD write_text.
    exec_write_text( stream_handle = static_stream_handle
                     text          = text ).
  ENDMETHOD.


  METHOD write_xml.
    exec_write_xml( stream_handle = static_stream_handle
                    xml           = xml ).
  ENDMETHOD.
ENDCLASS.
