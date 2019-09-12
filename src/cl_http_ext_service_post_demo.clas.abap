class CL_HTTP_EXT_SERVICE_POST_DEMO definition
  public
  final
  create public .

public section.

  interfaces IF_HTTP_EXTENSION .
  PROTECTED SECTION.

ENDCLASS.



CLASS CL_HTTP_EXT_SERVICE_POST_DEMO IMPLEMENTATION.


  METHOD if_http_extension~handle_request.
    DATA html TYPE string.

    DATA(path) = server->request->get_header_field( '~PATH_TRANSLATED' ).
    DATA(address) =
      cl_http_server=>get_location( server      = server
                                    application = path ) &&
      path && `?` && server->request->get_header_field( '~QUERY_STRING'  ).

    IF server->request->get_form_field( 'input' ) <> 'X'.
      html =
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
      && `    <form name="INPUT"  accept-charset="utf-8" `
      && `          method="post" action="` && address && `&input=X"> `
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
    ELSE.
      SPLIT server->request->get_cdata( )
            AT `&` INTO TABLE DATA(query_table).
      LOOP AT query_table ASSIGNING FIELD-SYMBOL(<query>).
        <query> = cl_http_utility=>unescape_url( <query> ).
      ENDLOOP.
      "cl_demo_output=>get converts ABAP data to HTML and is secure
      html = cl_demo_output=>get( query_table ).
    ENDIF.

    server->response->set_cdata( data = html ).

  ENDMETHOD.
ENDCLASS.
