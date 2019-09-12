class CL_HTTP_EXT_MIME_DEMO definition
  public
  final
  create public .

public section.

  interfaces IF_HTTP_EXTENSION .
protected section.
private section.
ENDCLASS.



CLASS CL_HTTP_EXT_MIME_DEMO IMPLEMENTATION.


  METHOD if_http_extension~handle_request.

    DATA(mime_access) =
       to_upper(
         cl_abap_dyn_prg=>escape_quotes_str( val =
           escape( val = server->request->get_form_field( name = `mime_access` )
                   format = cl_abap_format=>e_xss_ml ) ) ).

    DATA(pict_flag) =
       to_upper(
         cl_abap_dyn_prg=>escape_quotes_str( val =
           escape( val = server->request->get_form_field( name = `pict_flag` )
                   format = cl_abap_format=>e_xss_ml ) ) ).

    IF pict_flag <> abap_true.
      DATA(html) = `<html><body><basefont face="arial">`     &&
                   `text<br><br>`    &&
                   `<img src="picture">`                     &&
                   `</body></html>`.
      IF mime_access = `ICF`.
        REPLACE `text<br><br>` IN html WITH `Picture from ICF<br><br>`.
        REPLACE  `"picture"`   IN html WITH `"` &&
          cl_http_server=>get_location( server = server
                                        application = `/sap/public/bc/abap/mime_demo` )  &&
          `/sap/public/bc/abap/mime_demo/ABAP_Docu_Logo.gif"`.
      ELSEIF mime_access =  `API`.
        REPLACE `text<br><br>` IN html WITH `Picture from API<br><br>`.
        REPLACE  `"picture"`   IN html WITH `"` &&
          cl_http_server=>get_location( server = server
                                        application = `/sap/bc/abap/demo_mime` )  &&
          `/sap/bc/abap/demo_mime?pict_flag=X"`.
      ELSE.
        REPLACE `text<br><br>` IN html WITH `Invalid form field<br><br>`.
        REPLACE `<img src="picture">` in html with ``.
      ENDIF.
      server->response->set_cdata( data = html ).
    ELSE.
      cl_mime_repository_api=>get_api( )->get(
        EXPORTING i_url = `/SAP/PUBLIC/BC/ABAP/mime_demo/ABAP_Docu_Logo.gif`
        IMPORTING e_content = DATA(img) ).
      server->response->set_data( data = img ).
    ENDIF.

  ENDMETHOD.
ENDCLASS.
