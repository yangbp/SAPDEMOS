REPORT demo_html_from_mime.

CLASS mime_demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
  PRIVATE SECTION.
    TYPES: mime_line(1022) TYPE x,
           mime_tab        TYPE STANDARD TABLE OF mime_line
                                WITH EMPTY KEY.
    CLASS-METHODS get_mime_obj
      IMPORTING
        mime_url        TYPE csequence
      RETURNING
        VALUE(mime_tab) TYPE mime_tab.
ENDCLASS.

CLASS mime_demo IMPLEMENTATION.
  METHOD main.
    DATA html_url TYPE c LENGTH 255.

    DATA(custom_container) = NEW
      cl_gui_custom_container( container_name = 'CUSTOM_CONTAINER' ).
    DATA(html_control) = NEW
     cl_gui_html_viewer( parent = custom_container ).

    DATA(pict_tab) = get_mime_obj(
      mime_url = '/SAP/PUBLIC/BC/ABAP/mime_demo/ABAP_Docu_Logo.gif' ).
    html_control->load_data(
      EXPORTING
        url          = 'picture_url'
        type         = 'image'
        subtype      = '.gif'
      CHANGING
        data_table   = pict_tab ).

    DATA(html_tab) = get_mime_obj(
      mime_url = '/SAP/PUBLIC/BC/ABAP/mime_demo/demo_html.html' ).
    html_control->load_data(
      IMPORTING
        assigned_url = html_url
      CHANGING
        data_table   = html_tab ).

    html_control->show_url(
       EXPORTING
         url = html_url ).
  ENDMETHOD.

  METHOD get_mime_obj.
    cl_mime_repository_api=>get_api( )->get(
      EXPORTING i_url = mime_url
      IMPORTING e_content = DATA(mime_wa)
      EXCEPTIONS OTHERS = 4 ).
    IF sy-subrc = 4.
      RETURN.
    ENDIF.
    mime_tab =
      VALUE #( LET l1 = xstrlen( mime_wa ) l2 = l1 - 1022 IN
               FOR j = 0 THEN j + 1022  UNTIL j >= l1
                 ( COND #( WHEN j <= l2 THEN
                                mime_wa+j(1022)
                           ELSE mime_wa+j ) ) ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  mime_demo=>main( ).
  CALL SCREEN 100.
