REPORT demo_http_client.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA query TYPE string VALUE 'SAP'.
    cl_demo_input=>request( CHANGING field = query ).

    cl_http_client=>create(
      EXPORTING
        host =    'wikipedia.org'
        service = ''
      IMPORTING
        client = DATA(client)
      EXCEPTIONS
        OTHERS = 4 ).
    IF sy-subrc <> 0.
      RETURN.
    ENDIF.

    cl_http_utility=>set_request_uri(
      request = client->request
      uri     = `/wiki/` && query ).

    client->send(
      EXCEPTIONS
        OTHERS = 4 ).
    IF sy-subrc <> 0.
      client->get_last_error(
        IMPORTING message = DATA(smsg) ).
      cl_demo_output=>display( smsg ).
      RETURN.
    ENDIF.

    client->receive(
      EXCEPTIONS
        OTHERS = 4 ).
    IF sy-subrc <> 0.
      client->get_last_error(
        IMPORTING message = DATA(rmsg) ).
      cl_demo_output=>display( rmsg ).
      RETURN.
    ENDIF.

    DATA(html) = client->response->get_cdata( ).
    cl_demo_output=>display_html( html ).

    client->close( ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
