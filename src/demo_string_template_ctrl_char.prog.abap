REPORT demo_string_template_ctrl_char.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.

    cl_demo_output=>display(
      |First line.\r\ttab\ttab\ttab\n\ttab\ttab\ttab\rLast line.| ).

  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
