REPORT demo_assign_component.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA:
      BEGIN OF struc,
        comp1 TYPE i,
        comp2 TYPE i,
        comp3 TYPE i,
      END OF struc,
      name TYPE string,
      t1 TYPE i,
      t2 TYPE i,
      tr TYPE i.
    FIELD-SYMBOLS: <struc> TYPE any,
                   <comp>  TYPE any.

    ASSIGN struc TO <struc>.

    name = `<STRUC>-COMP1`.
    GET RUN TIME FIELD t1.
    DO 1000 TIMES.
      ASSIGN (name) TO <comp>.
    ENDDO.
    GET RUN TIME FIELD t2.
    tr = t2 - t1.
    cl_demo_output=>write( |ASSIGN (name): { tr }| ).

    name = `COMP1`.
    GET RUN TIME FIELD t1.
    DO 1000 TIMES.
      ASSIGN COMPONENT name OF STRUCTURE <struc> TO <comp>.
    ENDDO.
    GET RUN TIME FIELD t2.
    tr = t2 - t1.
    cl_demo_output=>write( |ASSIGN COMPONENT name: { tr }| ).

    GET RUN TIME FIELD t1.
    DO 1000 TIMES.
      ASSIGN COMPONENT 1 OF STRUCTURE <struc> TO <comp>.
    ENDDO.
    GET RUN TIME FIELD t2.
    tr = t2 - t1.
    cl_demo_output=>display( |ASSIGN COMPONENT 1: { tr }| ).

  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
