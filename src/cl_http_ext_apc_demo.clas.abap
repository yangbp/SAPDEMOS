CLASS cl_http_ext_apc_demo DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_http_extension .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS CL_HTTP_EXT_APC_DEMO IMPLEMENTATION.


  METHOD if_http_extension~handle_request.
    TRY.
        DATA(url) = escape( val    = cl_apc_ws_utility=>get_access_url(
                                       i_application_id = 'DEMO_APC'
                                       i_http_server = server )
                            format = cl_abap_format=>e_url ).
        IF to_upper( server->request->get_form_field( name = `amc` ) ) = abap_true.
          url =  COND string(
                   WHEN url CS `/demo_apc?` THEN url && `&amc=x`
                   ELSE url && `?amc=x` ).
        ENDIF.
      CATCH cx_apc_error.
        server->response->set_cdata(
          |<html><body>APC URL cannot be received</body></html>| ).
        RETURN.
    ENDTRY.

    server->response->set_cdata(
    |<!DOCTYPE HTML> \n| &&
    |<html> \n| &&
    |<head> \n| &&
    |<script type="text/javascript"> \n| &&
    |var ws;| &&
    |function WebSocketDemo(para) \n| &&
    |\{ \n| &&
    |  if ("WebSocket" in window) \n| &&
    |  \{ \n| &&
    |     if (para == "open" ) \n| &&
    |     \{ \n| &&
    |        ws = new WebSocket("{ url }"); \n| &&
    |     \}; \n| &&
    |     if (para == "send" ) \n| &&
    |     \{ \n| &&
    |        ws.send( ">" + document.getElementById("input").value + "<" + \n| &&
    |                 " from " + window.location.host + window.location.pathname ); \n| &&
    |     \}; \n| &&
    |     if (para == "close" ) \n| &&
    |     \{ \n| &&
    |        ws.close( ); \n| &&
    |     \}; \n| &&
    |     ws.onopen = function() \n| &&
    |     \{ \n| &&
    |        alert("WebSocket opened"); \n| &&
    |     \}; \n| &&
    |     ws.onmessage = function (evt) \n| &&
    |     \{  \n| &&
    |        var received_msg = evt.data; \n| &&
    |        prompt("APC-Message",evt.data); \n| &&
    |     \}; \n| &&
    |     ws.onclose = function() \n| &&
    |     \{  \n| &&
    |        alert("WebSocket closed");  \n| &&
    |     \}; \n| &&
    |  \} \n| &&
    |  else \n| &&
    |  \{ \n| &&
    |     alert("Browser does not support WebSocket!"); \n| &&
    |  \} \n| &&
    |\} \n| &&
    |</script> \n| &&
    |</head> \n| &&
    |<body style="font-family:arial;font-size:80%;"> \n| &&
    |<h3> \n| &&
    |   WebSocket Communication with ABAP Push Channel using Text Messages \n| &&
    |</h3> \n| &&
    |<p> \n| &&
    |   <a href="javascript:WebSocketDemo('open')">Open WebSocket</a> \n| &&
    |</p> \n| &&
    |<p> \n| &&
    |  <form name="input"> \n| &&
    |   <a href="javascript:WebSocketDemo('send')">Send message to APC</a>&nbsp;&nbsp; \n| &&
    |    <input name="input" id="input" value ="Hello APC!" type="text" size="20" maxlength="20" > \n| &&
    |  </form> \n| &&
    |</p> \n| &&
    |<p> \n| &&
    |   <a href="javascript:WebSocketDemo('close')">Close WebSocket</a> \n| &&
    |</p> \n| &&
    |<p><br> \n| &&
    |If the form field <i>amc</i> of the URL contains "x",  an opened WebSocket receives text messages from the ABAP Messaging Channel DEMO_AMC.<br> \n| &&
    |Such messages are then sent in the APC handler class but can also be sent by program DEMO_SEND_AMC.<br> \n| &&
    |The program DEMO_RECEIVE_AMC can receive text messages sent by the APC handler class. \n| &&
    |</p> \n| &&
    |<p><br> \n| &&
    |If you send the message <i>get handle</i>, you will receive the <b>connection attach handle</b> of the APC-server. <br> \n| &&
    |</p> \n| &&
    |</body> \n| &&
    |</html>| ) ##NO_TEXT.

  ENDMETHOD.
ENDCLASS.
