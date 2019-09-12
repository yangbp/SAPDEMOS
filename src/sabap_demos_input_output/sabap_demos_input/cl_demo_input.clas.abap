CLASS cl_demo_input DEFINITION
  PUBLIC
  FINAL
  CREATE PRIVATE .

  PUBLIC SECTION.

    INTERFACES if_demo_input .

    CLASS-EVENTS html_completed
      EXPORTING
        VALUE(html) TYPE string .

    CLASS-METHODS class_constructor .
    CLASS-METHODS new
      RETURNING
        VALUE(input) TYPE REF TO if_demo_input .
    CLASS-METHODS add_field
      IMPORTING
        !text        TYPE string OPTIONAL
        !as_checkbox TYPE abap_bool OPTIONAL
      CHANGING
        !field       TYPE simple .
    CLASS-METHODS add_line .
    CLASS-METHODS request
      IMPORTING
        !text        TYPE string OPTIONAL
        !as_checkbox TYPE abap_bool OPTIONAL
      CHANGING
        !field       TYPE simple OPTIONAL .
    CLASS-METHODS add_text
      IMPORTING
        !text TYPE string .
  PRIVATE SECTION.

    TYPES:
      BEGIN OF field,
        name  TYPE string,
        value TYPE string,
        check TYPE abap_bool,
      END OF field .
    TYPES:
      fields TYPE STANDARD TABLE OF field WITH DEFAULT KEY .

    CLASS-DATA selfref TYPE REF TO if_demo_input .
    DATA inputs TYPE fields .
    DATA:
      bindings TYPE TABLE OF REF TO data .
    CLASS-DATA gui_flag TYPE abap_bool VALUE abap_false ##NO_TEXT.

    METHODS handle_sapevent
          FOR EVENT sapevent OF cl_abap_browser
      IMPORTING
          !action
          !query_table .
    METHODS handle_closed
        FOR EVENT closed OF cl_abap_browser .
    CLASS-METHODS get_name
      RETURNING
        VALUE(name) TYPE string .
    CLASS-METHODS check_checkbox
      IMPORTING
        VALUE(field) TYPE simple
      RETURNING
        VALUE(rc)    TYPE abap_bool .
ENDCLASS.



CLASS CL_DEMO_INPUT IMPLEMENTATION.


  METHOD add_field.
    DATA(name) = text.
    IF name IS INITIAL.
      name = get_name( ).
      IF name IS INITIAL.
        name = `Input` ##NO_TEXT.
      ENDIF.
    ENDIF.
    selfref->add_field( EXPORTING text = name as_checkbox = as_checkbox
                        CHANGING field = field ).
  ENDMETHOD.


  METHOD add_line.
    selfref->add_line( ).
  ENDMETHOD.


  METHOD add_text.
    selfref->add_text( text ).
  ENDMETHOD.


  METHOD check_checkbox.
    DESCRIBE FIELD field TYPE DATA(dtype).
    IF dtype <> 'C' AND dtype <> 'g'.
      RETURN.
    ENDIF.
    IF dtype = 'C'.
      DESCRIBE FIELD field LENGTH DATA(length) IN CHARACTER MODE.
      IF length <> 1.
        RETURN.
      ENDIF.
    ENDIF.
    IF dtype = 'g'.
      length = strlen( field ).
      IF length > 1.
        RETURN.
      ENDIF.
    ENDIF.
    IF field IS NOT INITIAL AND
       field <> 'X' AND field <> ` `.
      RETURN.
    ENDIF.
    rc = 'X'.
  ENDMETHOD.


  METHOD class_constructor.
    CALL FUNCTION 'GUI_IS_AVAILABLE'
      IMPORTING
        return = gui_flag.
    selfref = cl_demo_input=>new( ).
  ENDMETHOD.


  METHOD get_name.
    DATA: t_stack TYPE abap_callstack,
          s_stack TYPE LINE OF abap_callstack,
          t_lines TYPE TABLE OF abap_callstack_line-line.
    CALL FUNCTION 'SYSTEM_CALLSTACK'
      IMPORTING
        callstack = t_stack.
    LOOP AT t_stack INTO s_stack WHERE mainprogram CS 'CL_DEMO_INPUT' ##no_text.
      DATA(idx) = sy-tabix.
    ENDLOOP.
    LOOP AT t_stack INTO s_stack FROM idx + 1.
      APPEND s_stack-line TO t_lines.
    ENDLOOP.
    READ TABLE t_stack INTO s_stack INDEX idx + 1.
*    TRY.
*        name = code_scan=>get_par_name( stack_frame = s_stack
*                                        lines       = t_lines  ).
*      CATCH cx_name.
*        IF cl_abap_docu_system=>techdev = abap_true.
*          MESSAGE 'Notify owner of CL_DEMO_INPUT' TYPE 'X' ##no_text.
*        ENDIF.
*        TRY.
*            name = introspection=>get_par_name( s_stack ).
*          CATCH cx_name.
*            CLEAR name.
*        ENDTRY.
*    ENDTRY.
    TRY.
        name = code_analysis=>get_par_name( stack_frame = s_stack
                                            lines       = t_lines ).
      CATCH cx_name.
*        IF cl_abap_docu_system=>id >= cl_abap_docu_system=>techdev.
*          MESSAGE 'Notify owner of CL_DEMO_INPUT' TYPE 'X' ##no_text.
*        ELSE.
        CLEAR name.
*        ENDIF.
    ENDTRY.
*    ENDIF.
  ENDMETHOD.


  METHOD handle_closed.
    SET HANDLER handle_sapevent ACTIVATION ' '.
    SET HANDLER handle_closed   ACTIVATION ' '.
    CLEAR inputs.
    CLEAR bindings.
    LEAVE PROGRAM.
  ENDMETHOD.


  METHOD handle_sapevent.
    cl_abap_browser=>close_browser( ).
    IF action = 'INPUT'.
      DELETE inputs where name = '@@br@@'.
      DELETE inputs where name = '@@tx@@'.
      " add unchecked (hence unsent) checkbox inputs with initial value
      LOOP AT inputs ASSIGNING FIELD-SYMBOL(<inp>) WHERE check IS NOT INITIAL.
        DATA(name) = CONV w3_qname( |input{ sy-tabix }| ).
        IF NOT line_exists( query_table[ name = name ] ).
          APPEND VALUE #( name = name ) TO query_table.
        ENDIF.
      ENDLOOP.
      LOOP AT query_table ASSIGNING FIELD-SYMBOL(<qry>).
        DATA(dref) = bindings[ CONV i( substring_after( val = <qry>-name sub = `input` ) ) ] ##NO_TEXT.
        ASSIGN dref->* TO FIELD-SYMBOL(<value>).
        TRY.
            DESCRIBE FIELD <value> TYPE DATA(ft).
            IF ft <> 'k'.
              <value> = <qry>-value.
            ELSE. "Enumerated type
*              DATA(enum) = CAST cl_abap_enumdescr( cl_abap_typedescr=>describe_by_data( <value> ) ).
*              DATA(members) = enum->members.
*              DATA(enumval) =  members[ name = to_upper( <qry>-value ) ]-value.
*              DATA(basetype) = enum->base_type_kind.
*              DATA enumref TYPE REF TO data.
*              CREATE DATA enumref TYPE (basetype).
*              ASSIGN enumref->* TO FIELD-SYMBOL(<enum>).
*              <enum> = enumval.
*              <value> = CONV #( <enum> ).
              CONSTANTS: xml1 TYPE string VALUE `<asx:abap xmlns:asx="http://www.sap.com/abapxml" version="1.0"><asx:values><R>` ##no_text,
                         xml2 TYPE string VALUE `</R></asx:values></asx:abap>` ##no_text.
              DATA(xml) = xml1 && to_upper( <qry>-value ) && xml2.
              TRY.
                  CALL TRANSFORMATION id SOURCE XML xml RESULT r = <value>.
                CATCH cx_transformation_error. "cx_sy_itab_line_not_found.
                  IF gui_flag IS NOT INITIAL.
                    MESSAGE `Wrong value for enumerated type` TYPE 'I' DISPLAY LIKE 'E' ##no_text.
                  ENDIF.
                  CLEAR <value>.
              ENDTRY.
            ENDIF.
          CATCH cx_sy_conversion_error. "cx_sy_itab_line_not_found.
            CLEAR <value>.
        ENDTRY.
      ENDLOOP.
    ENDIF.
    SET HANDLER handle_sapevent ACTIVATION ' '.
    SET HANDLER handle_closed   ACTIVATION ' '.
    CLEAR inputs.
    CLEAR bindings.
  ENDMETHOD.


  METHOD if_demo_input~add_field.
    DATA ok TYPE abap_bool VALUE 'X'.
    TRY.
        CAST cl_abap_elemdescr( cl_abap_typedescr=>describe_by_data( field ) ).
      CATCH cx_sy_move_cast_error.
        CLEAR ok.
    ENDTRY.
    IF as_checkbox = abap_true.
      field = to_upper( field ).
      ok = check_checkbox( field ).
    ENDIF.

    DATA wa LIKE LINE OF inputs.
    DATA(dref) = REF #( field ).
    APPEND dref TO bindings.

    IF ok = 'X'.
      wa-check = as_checkbox.
      wa-value = |{ field }|.
    ELSE.
      wa-check = |0|.
      CLEAR wa-value.
    ENDIF.
    IF text IS NOT INITIAL.
      wa-name = text.
    ELSE.
      wa-name = get_name( ).
      IF wa-name IS INITIAL.
        wa-name = `Input` ##NO_TEXT.
      ENDIF.
    ENDIF.
    APPEND wa TO inputs.
    input = me.
  ENDMETHOD.


  METHOD if_demo_input~add_line.
    inputs = VALUE #( BASE inputs ( name = '@@br@@' value = '<br>' ) ) ##no_text.
    input = me.
  ENDMETHOD.


  METHOD if_demo_input~add_text.
    inputs = VALUE #( BASE inputs ( name = '@@tx@@' value = text ) ) ##no_text.
    input = me.
  ENDMETHOD.


  METHOD if_demo_input~request.

    DATA html TYPE string.

    IF field IS SUPPLIED.
      if_demo_input~add_field( EXPORTING text = text as_checkbox = as_checkbox CHANGING field = field ).
    ENDIF.

    DATA exainp TYPE cl_http_ext_abap_docu=>exainp.
    IMPORT example_input = exainp FROM MEMORY ID 'EXAMPLE_INPUT'.
    IF sy-subrc = 0 AND exainp-flag = abap_true.
      DELETE FROM MEMORY ID 'EXAMPLE_INPUT'.
      handle_sapevent( action = 'INPUT'
                       query_table = exainp-query_table ).
      RETURN.
    ENDIF.

    DATA label_width TYPE i.
    LOOP AT inputs ASSIGNING FIELD-SYMBOL(<input>).
      DATA(name_width) = strlen( <input>-name ).
      IF name_width > 50.
        name_width = 50.
        <input>-name = <input>-name(50).
      ENDIF.
      IF name_width > label_width.
        label_width = name_width.
      ENDIF.
    ENDLOOP.

    DATA(err_idx) = line_index( inputs[ check = |0| ] ) ##WARN_OK.
    DATA input_fields TYPE string.
    IF inputs IS INITIAL.
      input_fields = `<br><span class="np">&nbsp;&nbsp;</span>No input fields defined`.
    ELSEIF err_idx > 0.
      input_fields = `<br><span class="np">&nbsp;&nbsp;</span>Illegal parameter at position ` && |{ err_idx }|.
    ELSE.
      FIELD-SYMBOLS <field> TYPE any.
      LOOP AT inputs INTO DATA(input).
        IF input-name = '@@br@@'.
          input_fields = input_fields && input-value.
          DELETE inputs.
          CONTINUE.
        ENDIF.
        IF input-name = '@@tx@@'.
          input_fields = input_fields && `<br><b>` && input-value && `</b><br>` ##NO_TEXT.
          DELETE inputs.
          CONTINUE.
        ENDIF.
        READ TABLE bindings INDEX sy-tabix INTO DATA(dref).
        ASSIGN dref->* TO <field>.
        DESCRIBE FIELD <field> OUTPUT-LENGTH DATA(outlen).
        IF outlen = 0. "Strings & Co.
          outlen = 255.
        ENDIF.
        DATA(value_width) = outlen.
        IF outlen <= 50.
          DATA(field_width) = outlen.
        ELSE.
          field_width = 50.
        ENDIF.
        input_fields = input_fields &&
                `<br>`  &&
                `&nbsp;<span class="np">` && replace( val = |{ input-name WIDTH = label_width }| sub = ` ` occ = 0 with = `&nbsp;` )  && `&nbsp;&nbsp;</span>` &&
                |<input name="input{ sy-tabix }" id="in{ sy-tabix }" type=| &&
                COND string( WHEN input-check IS INITIAL
                  THEN |"text" value="{ input-value }" size="{ field_width }" maxlength="{ value_width }" autocomplete="on"|
                  ELSE `"checkbox" value="X"` &&
                       COND #( WHEN to_upper( input-value ) = 'X' THEN ` checked` ) ) &&
                ` title="Input" onKeyDown="InputKeyDown(this.form);" >` ##NO_TEXT.
      ENDLOOP.
    ENDIF.

    html =
       `<html>`
    && `  <head>`
    && `    <meta http-equiv="content-type" `
    && `          content="text/html; `
    && `          charset=utf-8">`
    && `    <style type="text/css">`
    && `      body { font-family: arial; background-color: #FFFFFF; font-size: 80%; margin-left:2pt; margin-right:0pt; margin-top:0pt;  }`
    && `      button.F2F4F7 { background-color:#F2F4F7; outline:0; }`
    && `      span.np { font-family: Courier New; }`
    && `    </style>`
    && `    <script language="JavaScript">`
    && `      function sendInput(form) `
    && `          { fname=form.name;       `
    && `            document[fname].submit();} `
    && `      function InputKeyDown(form) {`
    && `        if(event.keyCode == 13) {`
    && `            fname=form.name;`
    && `            document[fname].submit();} }`
    && `    </script>`
    && `  </head>`
    && `  <body scroll="no" onload='javascript:document.getElementById("input1").focus()'>`
    && `    <form name="INPUT"  accept-charset="utf-8" `
    && `          method="post" action="SAPEVENT:INPUT"> `
    &&       input_fields
    && `     <br><br>`
    && COND string( WHEN err_idx = 0 THEN
       `     <span class="np">` && repeat( val = `&nbsp;` occ = label_width + 2 ) && `</span>`
    && `     <button id="enterButton" type="button" `
    && `             title="Enter" onClick="sendInput(INPUT);" `
    && `             onKeypress="if(event.keycode=13) `
    && `             sendInput(INPUT);" `
    && `             onfocus="if(this.blur) this.blur()" >`
    && `             Enter</button>` )
    && `    </form>`
    && `  </body>`
    && `</html>` ##no_text.



    SET HANDLER handle_sapevent.
    SET HANDLER handle_closed.

    IF gui_flag IS NOT INITIAL.
      cl_abap_browser=>show_html( html_string = html  context_menu = abap_true
                                  title = 'Input'
                                  check_html = ' ' )  ##no_text.
    ELSE.
      EXPORT input_html = html TO MEMORY ID 'INPUT_HTML'.
      RAISE EVENT html_completed EXPORTING html = html.
      LEAVE PROGRAM.
    ENDIF.

  ENDMETHOD.


  METHOD new.
    CREATE OBJECT input TYPE cl_demo_input.
  ENDMETHOD.


  METHOD request.
    DATA(name) = text.
    IF field IS SUPPLIED.
      IF name IS INITIAL.
        name = get_name( ).
        IF name IS INITIAL.
          name = `Input` ##NO_TEXT.
        ENDIF.
      ENDIF.
      selfref->request( EXPORTING text = name as_checkbox = as_checkbox CHANGING field = field ).
    ELSE.
      selfref->request( ).
    ENDIF.
  ENDMETHOD.
ENDCLASS.
