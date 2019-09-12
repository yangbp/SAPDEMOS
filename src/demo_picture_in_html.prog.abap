REPORT demo_picture_in_html.

CLASS picture_demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS: main1, main2.
  PRIVATE SECTION.
    TYPES: html     TYPE c LENGTH 255,
           html_tab TYPE STANDARD TABLE OF html WITH EMPTY KEY.
    TYPES: pict_line(1022) TYPE x,
           pict_tab        TYPE STANDARD TABLE OF pict_line
                                WITH EMPTY KEY.
    CLASS-METHODS get_pict_tab
      IMPORTING
        mime_url        TYPE csequence
      RETURNING
        VALUE(pict_tab) TYPE pict_tab.
ENDCLASS.

CLASS picture_demo IMPLEMENTATION.
  METHOD main1.
    DATA html_url TYPE c LENGTH 255.
    DATA pict_url TYPE c LENGTH 255.

    DATA(custom_container) = NEW
      cl_gui_custom_container( container_name = 'CUSTOM_CONTAINER1' ).
    DATA(html_control) = NEW
     cl_gui_html_viewer( parent = custom_container ).

    DATA(pict_tab) = get_pict_tab(
      mime_url = '/SAP/PUBLIC/BC/ABAP/mime_demo/ABAP_Docu_Logo.gif' ).
    html_control->load_data(
      EXPORTING
        url          = 'picture_url'
        type         = 'image'
        subtype      = '.gif'
      IMPORTING
        assigned_url = pict_url
      CHANGING
        data_table   = pict_tab ).

    DATA(html_tab) = VALUE html_tab(
      ( '<html><body><basefont face="arial">' )
      ( 'Picture with CL_GUI_HTML_VIEWER<br><br>' )
      ( '<img src="' && pict_url && '">' )
      ( '</body></html>' ) ).
    html_control->load_data(
      IMPORTING
        assigned_url = html_url
      CHANGING
        data_table   = html_tab ).

    html_control->show_url(
       EXPORTING
         url = html_url ).
  ENDMETHOD.

  METHOD main2.
    DATA(custom_container) = NEW
      cl_gui_custom_container( container_name = 'CUSTOM_CONTAINER2' ).

    DATA(pict_tab) = get_pict_tab(
      mime_url = '/SAP/PUBLIC/BC/ABAP/mime_demo/ABAP_Docu_Logo.gif' ).
    DATA(ext_data) =
      VALUE cl_abap_browser=>load_tab( ( name = 'PICT.GIF'
                                         type = 'image'
                                         dref = REF #( pict_tab ) ) ).

    DATA(html_tab) = VALUE cl_abap_browser=>html_table(
      ( '<html><body><basefont face="arial">' )
      ( 'Picture with CL_ABAP_BROWSER<br><br>' )
      ( '<img src="PICT.GIF">' )
      ( '</body></html>' ) ).

    cl_abap_browser=>show_html( html = html_tab
                                container = custom_container
                                data_table  = ext_data ).
  ENDMETHOD.

  METHOD get_pict_tab.
    cl_mime_repository_api=>get_api( )->get(
      EXPORTING i_url = mime_url
      IMPORTING e_content = DATA(pict_wa)
      EXCEPTIONS OTHERS = 4 ).
    IF sy-subrc = 4.
      RETURN.
    ENDIF.
    pict_tab =
      VALUE #( LET l1 = xstrlen( pict_wa ) l2 = l1 - 1022 IN
               FOR j = 0 THEN j + 1022  UNTIL j >= l1
                 ( COND #( WHEN j <= l2 THEN
                                pict_wa+j(1022)
                           ELSE pict_wa+j ) ) ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  picture_demo=>main1( ).
  picture_demo=>main2( ).
  CALL SCREEN 100.
