REPORT demo_usage_output_get.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS: main,
      show.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    "Necessary to hold amodal window
    WRITE 'Show' HOTSPOT COLOR COL_POSITIVE INTENSIFIED OFF.
  ENDMETHOD.
  METHOD show.
    "Output as usual
    DO 26 TIMES.
      cl_demo_output=>write(
        REDUCE string( INIT s = ``
                       FOR i = 1 THEN i + 1 UNTIL i > 17
                       NEXT s = s && ` blah` ) ).
    ENDDO.

    "Selfdefined output settings
    cl_abap_browser=>show_html(
      EXPORTING
         title        = 'Blahs'
         format       = cl_abap_browser=>portrait
         size         = cl_abap_browser=>large
         modal        = abap_false
         html_string  = cl_demo_output=>get( )
         position     = cl_abap_browser=>topleft ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).

AT LINE-SELECTION.
  demo=>show( ).
