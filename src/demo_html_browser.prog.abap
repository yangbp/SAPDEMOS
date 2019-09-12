REPORT demo_html_browser.

PARAMETERS: modal  AS CHECKBOX DEFAULT 'X',
            no_box AS CHECKBOX.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
  PRIVATE SECTION.
    TYPES: pict_line(1022) TYPE x,
           pict_tab        TYPE STANDARD TABLE OF pict_line
                                WITH EMPTY KEY.
    CLASS-METHODS get_pict_tab
      IMPORTING
        mime_url        TYPE csequence
      RETURNING
        VALUE(pict_tab) TYPE pict_tab.
    CLASS-METHODS handle_sapevent
      FOR EVENT sapevent
                  OF cl_abap_browser
      IMPORTING action.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA error_list TYPE cl_abap_browser=>html_table.

    DATA(title) = CONV cl_abap_browser=>title( 'HTML Browser Demo' ).

    SET HANDLER handle_sapevent.

    DATA(pict_tab) = get_pict_tab(
      mime_url = '/SAP/PUBLIC/BC/ABAP/mime_demo/ABAP_Docu_Logo.gif' ).

    DATA(ext_data) =
      VALUE cl_abap_browser=>load_tab( ( name = 'PICT.GIF'
                                         type = 'image'
                                         dref = REF #( pict_tab ) ) ).

    DATA(html_str) =
      '<htm1 lang="EN">' &&
      '<head>' &&
      '<meta name="Demo" content="Test">' &&
      '<style type="text/css">' &&
      'span.h1 {font-size: 150%; color:#000080; ' &&
      'font-weight:bold;}' &&
      '</style>' &&
      '</head>' &&
      '<body>' &&
      '<p><span class="h1">HTML</span></p>' &&
      '<A HREF="http://help.sap.com/">Weblink</A>' &&
      '<br><br><A href=sapevent:"ActionCode">SAPevent</A>' &&
      '<br><br>External Picture:' &&
      '<br><br><img src="PICT.GIF" alt="An example figure" >' &&
      '</body>' &&
      '</html>'.

    cl_abap_browser=>show_html(
      EXPORTING
        html_string = html_str
        modal       = modal
        dialog      = COND #( WHEN no_box = abap_false
                                   THEN abap_true )
        title       = title
        buttons     = cl_abap_browser=>navigate_html
        format      = cl_abap_browser=>landscape
        size        = cl_abap_browser=>medium
        data_table  = ext_data
      IMPORTING
         html_errors = error_list ).

    IF modal IS INITIAL AND no_box IS INITIAL.
      MESSAGE 'First call of browser' TYPE 'I'.
    ENDIF.

    IF error_list IS NOT INITIAL.
      LOOP AT error_list ASSIGNING FIELD-SYMBOL(<error>).
        <error> = escape( val    = <error>
                          format = cl_abap_format=>e_html_text ).
        <error> = <error> && '<br>'.
      ENDLOOP.
      INSERT '<html><body>' INTO error_list INDEX 1.
      APPEND '</body></html>' TO error_list.
      cl_abap_browser=>show_html(
        EXPORTING
          html       = error_list
          modal       = modal
          dialog      = COND #( WHEN no_box = abap_false
                                     THEN abap_true )
          title      = 'HTML Validation Errors'
          check_html = abap_false
          printing   = abap_true ).

      IF modal IS INITIAL AND no_box IS INITIAL.
        MESSAGE 'Second call of browser' TYPE 'I'.
      ENDIF.

    ENDIF.

    REPLACE '<htm1'  IN html_str WITH  '<html'.

    cl_abap_browser=>show_html(
      EXPORTING
        html_string = html_str
        modal       = modal
        dialog      = COND #( WHEN no_box = abap_false
                                   THEN abap_true )
        title      = title
        buttons    = cl_abap_browser=>navigate_html
        format     = cl_abap_browser=>landscape
        size       = cl_abap_browser=>medium
        data_table = ext_data
        check_html = abap_true
      IMPORTING
         html_errors = error_list ).

    IF modal IS INITIAL AND no_box IS INITIAL.
      MESSAGE 'Third call of browser' TYPE 'I'.
    ENDIF.

    IF error_list IS INITIAL.
      MESSAGE 'No errors in HTML' TYPE 'S'.
    ENDIF.
  ENDMETHOD.
  METHOD handle_sapevent.
    MESSAGE `Handling: ` && action TYPE 'I'.
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
  demo=>main( ).
