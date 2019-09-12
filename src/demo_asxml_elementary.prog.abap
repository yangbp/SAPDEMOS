REPORT demo_asxml_elementary.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA: num    TYPE i VALUE 20,
          dat    TYPE d VALUE '20060627',
          xmlstr TYPE xstring.

    CALL TRANSFORMATION id
                        SOURCE number = num
                               date   = dat
                        RESULT XML xmlstr.

    cl_demo_output=>display_xml( xmlstr ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
