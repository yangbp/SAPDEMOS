REPORT demo_asxml_structure.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA: BEGIN OF struct,
            num  TYPE i VALUE 20,
            dat  TYPE d VALUE '20060627',
          END OF struct,
          xmlstr TYPE xstring.

    CALL TRANSFORMATION id
                        SOURCE structure = struct
                        RESULT XML xmlstr.

    cl_demo_output=>display_xml( xmlstr ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
