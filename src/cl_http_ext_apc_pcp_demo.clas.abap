class CL_HTTP_EXT_APC_PCP_DEMO definition
  public
  final
  create public .

public section.

  interfaces IF_HTTP_EXTENSION .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS CL_HTTP_EXT_APC_PCP_DEMO IMPLEMENTATION.


  METHOD if_http_extension~handle_request.
    TRY.
        DATA(pcp_stateful) = to_upper( server->request->get_form_field( name = `pcp_stateful` ) ).
        DATA(url) = escape( val    = cl_apc_ws_utility=>get_access_url(
                                       i_application_id = COND #( WHEN pcp_stateful IS INITIAL THEN 'DEMO_APC_PCP'
                                                                  ELSE 'DEMO_APC_PCP_STATEFUL' )
                                       i_http_server = server )
                            format = cl_abap_format=>e_url ).


        DATA(amc) = to_upper( server->request->get_form_field( name = `amc` ) ).
        IF amc = abap_true.
          url =  COND string(
           WHEN url CS `/demo_apc?` THEN url && `&amc=x`
           ELSE url && `?amc=x` ).
        ELSE.
          amc = abap_false.
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
    |<meta http-equiv='X-UA-Compatible' content='IE=edge' /> \n| &&
    |<meta http-equiv='Content-Type' content='text/html;charset=UTF-8'/> \n| &&
    |<script type="text/javascript" src="/sap/public/bc/ur/sap-pcp-websocket.js"></script> \n| &&
    |<script> \n| &&
    |var ws;| &&
    |function WebSocketDemo(para) \n| &&
    |\{ \n| &&
    |  if ("WebSocket" in window) \n| &&
    |  \{ \n| &&
    |     if (para == "open" ) \n| &&
    |     \{ \n| &&
    |        ws = new SapPcpWebSocket("{ url }", SapPcpWebSocket.SUPPORTED_PROTOCOLS.v10); \n| &&
    |     \}; \n| &&
    |     if (para == "send" ) \n| &&
    |     \{ \n| &&
    |        ws.send( ">" + document.getElementById("input").value + "<" + \n| &&
    |                 " from " + window.location.host + window.location.pathname, \{amc : '{ amc }' \}); \n| &&
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
    |        var received_fields = evt.pcpFields; \n| &&
    |        var received_body = evt.data; \n| &&
    |        alert(JSON.stringify(received_fields) + JSON.stringify(received_body)); \n| &&
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
    |   WebSocket Communication with ABAP Push Channel using the Push Channel Protocol (PCP)\n| &&
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
    |If the form field <i>amc</i> of the URL contains "x", an opened WebSocket receives PCP messages from the ABAP Messaging Channel DEMO_AMC.<br> \n| &&
    |Such messages are then sent in the APC handler class but can also be sent by program DEMO_SEND_AMC.<br> \n| &&
    |The program DEMO_RECEIVE_AMC can receive PCP messages sent by the APC handler class.<br><br> \n| &&
    |If the form field <i>pcp_stateful</i> of the URL contains "x", the ABAP Push Channel DEMO_APC_PCP_STATEFUL is used instead of DEMO_APC_PCP.<br> \n| &&
    |In  this case, the communication is stateful. The APC handler object stays alive as is shown by a counter that is incremented for each message. \n| &&
    |</p> \n| &&
    |</body> \n| &&
    |</html>| ) ##NO_TEXT.

  ENDMETHOD.
ENDCLASS.
