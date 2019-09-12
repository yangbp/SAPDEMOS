REPORT demo_set_handler_for_all.

CLASS cls DEFINITION.
  PUBLIC SECTION.
    EVENTS evt
      EXPORTING VALUE(p) TYPE string DEFAULT `nop`.
    METHODS meth
      IMPORTING p TYPE string.
ENDCLASS.

CLASS cls IMPLEMENTATION.
  METHOD meth.
    RAISE EVENT evt EXPORTING p = p.
  ENDMETHOD.
ENDCLASS.

CLASS hdl DEFINITION.
  PUBLIC SECTION.
    METHODS meth FOR EVENT evt OF cls
      IMPORTING p.
ENDCLASS.

CLASS hdl IMPLEMENTATION.
  METHOD meth.
    cl_demo_output=>write( p ).
  ENDMETHOD.
ENDCLASS.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA(href) = NEW hdl( ).
    SET HANDLER href->meth FOR ALL INSTANCES.

    NEW cls( )->meth( `Ping 1`).
    NEW cls( )->meth( `Ping 2`).
    NEW cls( )->meth( `Ping 3`).

    SET HANDLER href->meth FOR ALL INSTANCES ACTIVATION ' '.

    NEW cls( )->meth( `Ping 4`).
    NEW cls( )->meth( `Ping 5`).
    NEW cls( )->meth( `Ping 6`).

    cl_demo_output=>display( ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
