CLASS cl_demo_wrap_browser DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    TYPES:
      BEGIN OF ENUM size STRUCTURE sz,
        s, m, l, xl,
      END OF ENUM size STRUCTURE sz.
    TYPES:
      BEGIN OF ENUM format STRUCTURE fmt,
        l, p,
      END OF ENUM format STRUCTURE fmt.

    CLASS-METHODS show
      IMPORTING
        html   TYPE string
        size   TYPE size OPTIONAL
        format TYPE format OPTIONAL .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS CL_DEMO_WRAP_BROWSER IMPLEMENTATION.


  METHOD show.
    cl_abap_browser=>show_html(
      html_string = html
      size    = SWITCH #(  size
                           WHEN sz-s  THEN cl_abap_browser=>small
                           WHEN sz-m  THEN cl_abap_browser=>medium
                           WHEN sz-l  THEN cl_abap_browser=>large
                           WHEN sz-xl THEN cl_abap_browser=>xlarge )
      format  = SWITCH #(  format
                           WHEN fmt-l THEN cl_abap_browser=>landscape
                           WHEN fmt-p THEN cl_abap_browser=>portrait )
      buttons = abap_true ).
  ENDMETHOD.
ENDCLASS.
