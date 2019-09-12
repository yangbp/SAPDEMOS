REPORT demo_create_html_modern.

CLASS html_table DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS: class_constructor,
      main.
  PRIVATE SECTION.
    CLASS-DATA: scarr_tab TYPE TABLE OF scarr,
                html      TYPE string.
    CLASS-METHODS display.
ENDCLASS.

CLASS html_table IMPLEMENTATION.
  METHOD class_constructor.
    SELECT * FROM scarr INTO TABLE scarr_tab.
  ENDMETHOD.
  METHOD main .
    CONSTANTS spc TYPE string VALUE `&nbsp;&nbsp;`.

    html = |<html><body><table border=1>|                      &&
           |<tr bgcolor="#D3D3D3">|                            &&
           |<td><b>{ spc }ID</b></td>|                         &&
           |<td><b>{ spc }Name</b></td>|                       &&
           |<td><b>{ spc }URL</b></td>|                        &&
           |</tr>|                                             &&
           REDUCE string(
             INIT h TYPE string
             FOR <scarr> IN scarr_tab
             NEXT h = h &&
               |<tr bgcolor="#F8F8FF">| &
               |<td width={ 10 * strlen( <scarr>-carrid )
                 } >{ spc }{ <scarr>-carrid }</td>| &
               |<td width={ 10 * strlen( <scarr>-carrname )
                 } >{ spc }{ <scarr>-carrname }</td>| &
               |<td width={ 10 * strlen( <scarr>-url )
                 } >{ spc }<a href="{ <scarr>-url
                 }">{ <scarr>-url }</a></td>| &
               |</tr>| )                                       &&
           |{ html }</table></body><html>|.

    display( ).
  ENDMETHOD.
  METHOD display.
    cl_abap_browser=>show_html(
      html_string  = html
      buttons      = cl_abap_browser=>navigate_html
      context_menu = abap_true
      check_html   = abap_false ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  html_table=>main( ).
