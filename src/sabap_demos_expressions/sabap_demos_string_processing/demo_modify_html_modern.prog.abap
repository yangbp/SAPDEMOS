REPORT demo_modify_html_modern.

CLASS html_table DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
  PRIVATE SECTION.
    CLASS-DATA html TYPE string.
    CLASS-METHODS display.
ENDCLASS.

CLASS html_table IMPLEMENTATION.
  METHOD main.
    CONSTANTS color TYPE c LENGTH 6 VALUE '000000'.

    html = replace( val   = cl_demo_create_html=>get( )
                    regex = `(<a[^>]*>)([^<]+)(</a>)`
                    WITH  = `$1<font color="#` && color && `">$2</font>$3`
                    occ   = 0 ).

    display( ).
  ENDMETHOD.
  METHOD display.
    cl_abap_browser=>show_html(
      html_string  = html
      buttons      = cl_abap_browser=>navigate_html
      context_menu = abap_true ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  html_table=>main( ).
