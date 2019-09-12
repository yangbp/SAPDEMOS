REPORT demo_apc_show_pcp_api_js.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
    CLASS-METHODS get_mime_obj
      IMPORTING
        mime_url  TYPE csequence
      RETURNING
        VALUE(js) TYPE string.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    cl_demo_output=>display( get_mime_obj(
      mime_url = '/sap/public/bc/ur/sap-pcp-websocket.js' ) ).
  ENDMETHOD.
  METHOD get_mime_obj.
    cl_mime_repository_api=>get_api( )->get(
      EXPORTING i_url = mime_url
      IMPORTING e_content = DATA(mime_wa)
      EXCEPTIONS OTHERS = 4 ).
    IF sy-subrc = 0.
      js = cl_abap_codepage=>convert_from( mime_wa ).
    ELSE.
      js = `Source not found`.
    ENDIF.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
