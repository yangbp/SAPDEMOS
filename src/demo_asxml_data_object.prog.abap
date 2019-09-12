REPORT demo_asxml_data_object.

CLASS serializable DEFINITION.
  PUBLIC SECTION.
ENDCLASS.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA dref   TYPE REF TO decfloat34.
    DATA xmlstr TYPE xstring.

    CREATE DATA dref.
    dref->* = '1.23456'.
    CALL TRANSFORMATION id SOURCE dref = dref
                           RESULT XML xmlstr.

    cl_demo_output=>display_xml( xmlstr ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
