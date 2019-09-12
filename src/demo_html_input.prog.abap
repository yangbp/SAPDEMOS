REPORT demo_html_input.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
  PRIVATE SECTION.
    CLASS-METHODS handle_sapevent
      FOR EVENT sapevent
                  OF cl_abap_browser
      IMPORTING action
                  query_table.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA error_list TYPE cl_abap_browser=>html_table.

    SET HANDLER handle_sapevent.

    DATA(html_str) =
       `<html>`
    && `  <head>`
    && `    <meta http-equiv="content-type" `
    && `          content="text/html; `
    && `          charset=utf-8">`
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
    && `  <body>`
    && `    <form name="INPUT" accept-charset="utf-8" `
    && `          method="post" action="SAPEVENT:INPUT"> `
    && `      <input type="text" id="in1" name="field1" `
    && `             size=30 maxlength=30 title="" value="aaa" `
    && `             onKeyDown="InputKeyDown(this.form);"><br>`
    && `      <input type="text" id="in2" name="field2" `
    && `             size=30 maxlength=30 title="" value="bbb" `
    && `             onKeyDown="InputKeyDown(this.form);"><br>`
    && `      <input type="text" id="in3" name="field3" `
    && `             size=30 maxlength=30 title="" value="ccc" `
    && `             onKeyDown="InputKeyDown(this.form);"><br><br>`
    && `     <button id="enterButton" type="button" `
    && `             title="Enter" onClick="sendInput(INPUT);" `
    && `             onKeypress="if(event.keycode=13) `
    && `             sendInput(INPUT);">`
    && `             Enter</button>`
    && `    </form>`
    && `  </body>`
    && `</html>`.

    cl_abap_browser=>show_html(
      EXPORTING
        html_string = html_str
        title       = 'Input Demo'
      IMPORTING
         html_errors = error_list ).

    IF error_list IS NOT INITIAL.
      MESSAGE 'Error in HTML' TYPE 'I' DISPLAY LIKE 'E'.
    ENDIF.
  ENDMETHOD.
  METHOD handle_sapevent.
    DATA(out) = cl_demo_output_stream=>open( ).
    SET HANDLER cl_demo_output_html=>handle_output FOR out.
    out->write_data( iv_name = 'ACTION'      ia_value = action ).
    out->write_data( iv_name = 'QUERY_TABLE' ia_value = query_table ).
    out->close( ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
