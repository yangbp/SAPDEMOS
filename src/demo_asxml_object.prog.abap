REPORT demo_asxml_object.

CLASS serializable DEFINITION.
  PUBLIC SECTION.
    INTERFACES if_serializable_object.
    DATA attr TYPE string VALUE `Attribute`.
ENDCLASS.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA: oref TYPE REF TO serializable,
          xmlstr TYPE xstring.

    CREATE OBJECT oref.

    CALL TRANSFORMATION id
                        SOURCE object = oref
                        RESULT XML xmlstr.

    cl_demo_output=>display_xml( xmlstr ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
