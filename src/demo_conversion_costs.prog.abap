REPORT demo_conversion_costs.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA: num   TYPE n LENGTH 10,
          int   TYPE i,
          itab  TYPE STANDARD TABLE OF i,
          t1    TYPE i,
          t2    TYPE i,
          toff  TYPE i,
          tn    TYPE i,
          ti    TYPE i,
          msg   TYPE string.
    CONSTANTS n TYPE i VALUE 100000.

    GET RUN TIME FIELD t1.
    DO n TIMES.
    ENDDO.
    GET RUN TIME FIELD t2.
    toff = t2 - t1.

    GET RUN TIME FIELD t1.
    DO n TIMES.
      num = sy-index.
    ENDDO.
    GET RUN TIME FIELD t2.
    tn = t2 - t1 - toff.

    GET RUN TIME FIELD t1.
    DO n TIMES.
      int = sy-index.
    ENDDO.
    GET RUN TIME FIELD t2.
    ti = t2 - t1 - toff.

    cl_demo_output=>write(
      |Ratio of conversion to copy during assignment: | &&
      |{ tn / ti DECIMALS = 2 }| ).

    itab = VALUE #( ( 1 ) ).
    CLEAR: tn, ti.

    num = '1'.
    GET RUN TIME FIELD t1.
    DO n TIMES.
      READ TABLE itab TRANSPORTING NO FIELDS INDEX num.
    ENDDO.
    GET RUN TIME FIELD t2.
    tn = t2 - t1 - toff.

    int = 1.
    GET RUN TIME FIELD t1.
    DO n TIMES.
      READ TABLE itab TRANSPORTING NO FIELDS INDEX int.
    ENDDO.
    GET RUN TIME FIELD t2.
    ti = t2 - t1 - toff.

    cl_demo_output=>display(
      |Ratio of conversion to copy during assignment: | &&
      |{ tn / ti DECIMALS = 2 }| ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
