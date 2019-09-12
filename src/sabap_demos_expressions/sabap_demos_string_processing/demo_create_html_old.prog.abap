REPORT demo_create_html_old.


CLASS html_table DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS: class_constructor,
                   main.
  PRIVATE SECTION.
    CLASS-DATA: scarr_tab TYPE TABLE OF scarr,
                html TYPE string.
    CLASS-METHODS display.
ENDCLASS.

CLASS html_table IMPLEMENTATION.
  METHOD class_constructor.
    SELECT * FROM scarr INTO TABLE scarr_tab.
  ENDMETHOD.
  METHOD main.
    CONSTANTS spc TYPE string VALUE `&nbsp;&nbsp;`.
    FIELD-SYMBOLS <scarr> LIKE LINE OF scarr_tab.
    DATA: ilength TYPE i,
          clength TYPE c LENGTH 10.
    CONCATENATE
      '<html><body><table border=1>'
      '<tr bgcolor="#D3D3D3">'
      '<td><b>' spc 'ID</b></td>'
      '<td><b>' spc 'Name</b></td>'
      '<td><b>' spc 'URL</b></td>'
      '<tr>'
      INTO html.
    LOOP AT scarr_tab ASSIGNING <scarr>.
      CONCATENATE html
        '<tr bgcolor="#F8F8FF">'
        INTO html.
      ilength = 10 * strlen( <scarr>-carrid ).
      WRITE ilength TO clength LEFT-JUSTIFIED.
      CONDENSE clength.
      CONCATENATE html
        '<td width=' clength ' >' spc <scarr>-carrid '</td>'
       INTO html.
      ilength = 10 * strlen( <scarr>-carrname ).
      WRITE ilength TO clength LEFT-JUSTIFIED.
      CONDENSE clength.
      CONCATENATE html
        '<td width=' clength ' >' spc <scarr>-carrname '</td>'
       INTO html.
      ilength = 10 * strlen( <scarr>-url ).
      WRITE ilength TO clength LEFT-JUSTIFIED.
      CONDENSE clength.
      CONCATENATE html
        '<td width=' clength ' >' spc
        '<a href="' <scarr>-url '">' <scarr>-url '</a></td>'
         INTO html.
      CONCATENATE html
        '</tr>'
        INTO html.
    ENDLOOP.
    CONCATENATE html
      '</table></body><html>'
      INTO html.
    display( ).
  ENDMETHOD.
  METHOD display.
    CALL METHOD cl_abap_browser=>show_html
      EXPORTING
        html_string  = html
        buttons      = cl_abap_browser=>navigate_html
        context_menu = abap_true
        check_html = abap_false.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  html_table=>main( ).
