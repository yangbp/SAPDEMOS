REPORT demo_http_mime.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
    CLASS-METHODS class_constructor.
  PRIVATE SECTION.
    CLASS-DATA icf_node TYPE string.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    IF icf_node IS INITIAL.
      RETURN.
    ENDIF.

    DATA(url) = icf_node
                  && `?sap-client=`
                  && sy-mandt
                  && `&sap-language=`
                  && cl_i18n_languages=>sap1_to_sap2( sy-langu ).
    DATA(url_icf) = url && `&mime_access=icf`.
    DATA(url_api) = url && `&mime_access=api`.

    cl_demo_output=>display_html(
     |<html>| &&
     |<body>| &&
     |Link to HTTP-Service getting picture from ICF:<br><br>| &&
     |<a href="{ url_icf }" target="_blank">{ url_icf }</a><br><br>| &&
     |Link to HTTP-Service getting picture from API:<br><br>| &&
     |<a href="{ url_api }" target="_blank">{ url_api }</a><br><br>| &&
     |</body>| &&
     |</html>| ).
  ENDMETHOD.
  METHOD class_constructor.
    CONSTANTS path TYPE string VALUE `/sap/bc/abap/demo_mime`.
    DATA(location) =
      cl_http_server=>get_location( application = path ).
    IF location IS NOT INITIAL.
      icf_node = location && path.
    ENDIF.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
