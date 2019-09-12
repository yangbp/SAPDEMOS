*"* use this source file for your ABAP unit test classes

CLASS mock_server DEFINITION FOR TESTING FINAL.
  PUBLIC SECTION.
    INTERFACES if_http_server PARTIALLY IMPLEMENTED.
ENDCLASS.

CLASS mock_server IMPLEMENTATION.
ENDCLASS.

CLASS mock_request DEFINITION FOR TESTING FINAL.
  PUBLIC SECTION.
    INTERFACES if_http_request PARTIALLY IMPLEMENTED.
ENDCLASS.

CLASS mock_request IMPLEMENTATION.
  METHOD if_http_request~get_form_field.
    value = SWITCH spfli-carrid( name WHEN 'carrid' THEN 'LH'
                                      ELSE space ) ##no_text.
  ENDMETHOD.
ENDCLASS.

CLASS mock_response DEFINITION FOR TESTING FINAL.
  PUBLIC SECTION.
    INTERFACES if_http_response PARTIALLY IMPLEMENTED.
    DATA output TYPE string.
ENDCLASS.

CLASS mock_response IMPLEMENTATION.
  METHOD if_http_response~set_cdata.
    me->output = data.
  ENDMETHOD.
ENDCLASS.

CLASS test_http_service DEFINITION FOR TESTING
                        DURATION SHORT
                        RISK LEVEL HARMLESS
                        FINAL.
  PRIVATE SECTION.
    DATA mock_request  TYPE REF TO mock_request.
    DATA mock_response TYPE REF TO mock_response.
    DATA mock_server   TYPE REF TO mock_server.
    DATA handler  TYPE REF TO cl_http_ext_service_demo.
    METHODS test_service FOR TESTING.
ENDCLASS.

CLASS test_http_service IMPLEMENTATION.
  METHOD test_service.
    CREATE OBJECT mock_request.
    CREATE OBJECT mock_response.
    CREATE OBJECT mock_server.
    CREATE OBJECT handler.
    mock_server->if_http_server~request  = mock_request.
    mock_server->if_http_server~response = mock_response.
    handler->if_http_extension~handle_request( mock_server ).
    " here it would be nice to work with test seams and injections
    " to fill the mock output independent from the database
    IF mock_response->output NS `<meta name="Output" content="Data">`.
      cl_abap_unit_assert=>fail( msg    = `Wrong output data` ).
    ENDIF.
  ENDMETHOD.
ENDCLASS.
