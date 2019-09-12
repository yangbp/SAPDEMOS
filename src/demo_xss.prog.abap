REPORT demo_xss.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS:
       main,
       class_constructor.
  PRIVATE SECTION.
    CLASS-DATA:
      in  TYPE REF TO if_demo_input,
      icf_node TYPE string.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    CONSTANTS xss_demo TYPE string
                       VALUE `foo" onmouseover="alert('Gotcha!')`.

    DATA: query TYPE string VALUE `ABAP Objects`,
          esc_flag  TYPE abap_bool VALUE abap_true,
          xss_flag  TYPE abap_bool VALUE abap_false.

    DO.
      in->add_field( EXPORTING text = 'Input'
                     CHANGING field = query
       )->add_field( EXPORTING text = 'Escape'
                               as_checkbox = abap_true
                     CHANGING field =  esc_flag
       )->request(   EXPORTING text = 'XSS-Demo'
                               as_checkbox = abap_true
                     CHANGING field =  xss_flag ).
      IF query IS INITIAL AND xss_flag = abap_false.
        EXIT.
      ENDIF.

      IF xss_flag = abap_true.
        query = escape( val    = xss_demo
                        format = cl_abap_format=>e_xss_ml ).
        xss_flag = abap_false.
        CONTINUE.
      ENDIF.

      IF esc_flag = abap_true.
        query = escape( val    = query
                        format = cl_abap_format=>e_xss_ml ).
      ELSEIF query <> xss_demo.
        MESSAGE
          `Without escaping only the prepared XSS-Demo is allowed.`
          TYPE 'I'.
        CONTINUE.
      ENDIF.

      DATA(html) =
        `<html>`  &&
        `<body>`  &&
        `<p><a href="` && icf_node &&
        `?query=` && query &&
        `">Search in ABAP Documentation</a></p>` &&
        `<p><a href="http://www.google.com/search?q=` &&
        query && `">Search with Google</a></p>` &&
        `</body>` &&
        `</html>` ##no_text.
      cl_abap_browser=>show_html( html_string  = html
                                  buttons      = abap_true
                                  check_html   = abap_false
                                  context_menu = abap_true ).
    ENDDO.
  ENDMETHOD.
  METHOD class_constructor.
    CONSTANTS path TYPE string VALUE `/sap/public/bc/abap/docu`.
    DATA(location) =
      cl_http_server=>get_location( application = path ).
    IF location IS NOT INITIAL.
      icf_node = location && path.
    ENDIF.
    in  = cl_demo_input=>new( ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
