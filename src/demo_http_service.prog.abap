REPORT demo_http_service.

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

    DATA carrid TYPE spfli-carrid VALUE 'AA'.
    cl_demo_input=>request( CHANGING field = carrid ).

    DATA(url) = icf_node &&
                `?sap-client=` && sy-mandt &&
                `&sap-language=`
                  && cl_i18n_languages=>sap1_to_sap2( sy-langu ) &&
                `&carrid=`     && carrid.

    cl_demo_output=>display_html(
      |<html>| &&
      |<body>| &&
      |Link to HTTP-Service:<br><br>| &&
      |<a href="{ url }" target="_blank">{ url }</a>| &&
      |</body>| &&
      |</html>| ).
  ENDMETHOD.
  METHOD class_constructor.
    CONSTANTS path TYPE string VALUE `/sap/bc/abap/demo`.
    DATA(location) =
      cl_http_server=>get_location( application = path ).
    IF location IS NOT INITIAL.
      icf_node = location && path.
    ENDIF.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
