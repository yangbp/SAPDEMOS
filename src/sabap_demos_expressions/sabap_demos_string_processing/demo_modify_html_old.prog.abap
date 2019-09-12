REPORT demo_modify_html_old.

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

    DATA html_supplied TYPE string.
    DATA position TYPE i.
    DATA part1 TYPE string.
    DATA part2 TYPE string.

    CALL METHOD cl_demo_create_html=>get
      RECEIVING
        html = html_supplied.

    WHILE html_supplied CS '<a'.
      SEARCH html_supplied FOR '<a'.
      position = sy-fdpos.
      SEARCH html_supplied+position FOR '>'.
      position = position + sy-fdpos + 1.
      part1 = html_supplied(position).
      part2 = html_supplied+position.
      SEARCH part2 FOR '</a>'.
      html_supplied = part2+sy-fdpos.
      part2 = part2(sy-fdpos).
      CONCATENATE html
        part1 '<font color="#' color '">' part2 '</font>'
        INTO html.
    ENDWHILE.
    CONCATENATE html html_supplied INTO html.

    CALL METHOD display.

  ENDMETHOD.
  METHOD display.
    CALL METHOD cl_abap_browser=>show_html
      EXPORTING
        html_string  = html
        buttons      = cl_abap_browser=>navigate_html
        context_menu = abap_true
        check_html   = abap_false.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  html_table=>main( ).
