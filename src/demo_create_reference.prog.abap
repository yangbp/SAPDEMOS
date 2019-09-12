REPORT demo_create_reference.

INTERFACE intf.
  CONSTANTS attr TYPE string VALUE `Interface constant`.
ENDINTERFACE.

CLASS cls DEFINITION.
  PUBLIC SECTION.
    INTERFACES intf.
ENDCLASS.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA intf_name TYPE string.
    DATA cls_name  TYPE string.
    DATA dref TYPE REF TO data.

    FIELD-SYMBOLS <ref>  TYPE any.
    FIELD-SYMBOLS <attr> TYPE any.

    intf_name = '\PROGRAM=DEMO_CREATE_REFERENCE\INTERFACE=INTF'.
    CREATE DATA dref TYPE REF TO (intf_name).
    ASSIGN dref->* TO <ref>.

    cls_name = '\PROGRAM=DEMO_CREATE_REFERENCE\CLASS=CLS'.
    CREATE OBJECT <ref> TYPE (cls_name).

    ASSIGN ('<REF>->ATTR') TO <attr>.
    cl_demo_output=>display_data( <attr> ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
