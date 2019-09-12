class CL_HTTP_EXT_SERVICE_DEMO definition
  public
  final
  create public .

public section.

  interfaces IF_HTTP_EXTENSION .
protected section.
private section.
ENDCLASS.



CLASS CL_HTTP_EXT_SERVICE_DEMO IMPLEMENTATION.


  METHOD if_http_extension~handle_request.
    DATA connections TYPE TABLE OF spfli.

    DATA(carrid) = to_upper(
      cl_abap_dyn_prg=>escape_quotes( val =
        escape( val = server->request->get_form_field( name = `carrid` )
                format = cl_abap_format=>e_xss_ml ) ) ) ##no_text.

    SELECT *
           FROM spfli
           INTO TABLE @connections
           WHERE carrid = @carrid.

    "cl_demo_output=>get converts ABAP data to HTML and is secure
    server->response->set_cdata(
      data = cl_demo_output=>get( connections ) ).

  ENDMETHOD.
ENDCLASS.
