REPORT demo_asxml_table.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA itab TYPE TABLE OF i.

    itab = VALUE #( FOR j = 1 UNTIL j > 3 ( j ) ).

    CALL TRANSFORMATION id
                        SOURCE table = itab
                        RESULT XML DATA(xmlstr).

    cl_demo_output=>display_xml( xmlstr ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
