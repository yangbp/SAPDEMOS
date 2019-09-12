REPORT demo_apc_wsp.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
    CLASS-METHODS class_constructor.
  PRIVATE SECTION.
    CLASS-DATA url TYPE string.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    IF url IS INITIAL.
      RETURN.
    ENDIF.
    DATA amc TYPE abap_bool VALUE 'X'.
    cl_demo_input=>add_field( EXPORTING as_checkbox = 'X'
                              CHANGING field  = amc ).
    cl_demo_input=>add_line( ).
    DATA pcp TYPE abap_bool VALUE ' '.
    cl_demo_input=>add_field( EXPORTING as_checkbox = 'X'
                              CHANGING field  = pcp ).
    DATA pcp_stateful TYPE abap_bool VALUE ' '.
    cl_demo_input=>add_field( EXPORTING as_checkbox = 'X'
                              CHANGING field  = pcp_stateful ).
    cl_demo_input=>request( ).
    amc = to_upper( amc ).
    cl_demo_output=>display_html(
      |<html>| &&
      |<body>| &&
      |<a href="{ COND string( WHEN pcp IS INITIAL AND
                                    pcp_stateful IS INITIAL THEN url
                               ELSE url && `_pcp` )
        }?sap-client={ sy-mandt
        }&sap-language={ cl_i18n_languages=>sap1_to_sap2( sy-langu )
        }{ COND string( WHEN amc = abap_true
             THEN `&amc=x`
             ELSE `` )
        }{ COND string( WHEN pcp_stateful = abap_true
             THEN `&pcp_stateful=x`
             ELSE `` )
        }" target="_blank">| &&
        |Open demo web page with standard browser</a><br><br>| &&
      |If your browser does not support WebSocket, | &&
      |copy the URL to another browser.| &&
      |</body>| &&
      |</html>| ).
  ENDMETHOD.
  METHOD class_constructor.
    CONSTANTS path TYPE string VALUE `/sap/bc/abap/demo_apc`.
    DATA(location) =
      cl_http_server=>get_location( application = path ).
    IF location IS NOT INITIAL.
      url = location && path.
    ENDIF.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
