REPORT demo_typing.

CLASS demo_typing DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS start.
  PRIVATE SECTION.
    TYPES: BEGIN OF struc1,
             cola TYPE i,
             colb TYPE i,
           END OF struc1,
           BEGIN OF struc2,
             colb TYPE i,
             cola TYPE i,
           END OF struc2,
           itab1g TYPE STANDARD TABLE OF struc1,
           itab2g TYPE STANDARD TABLE OF struc2,
           itab2c TYPE STANDARD TABLE OF struc2
                       WITH NON-UNIQUE DEFAULT KEY.
    CLASS-METHODS sort_itab IMPORTING VALUE(pg) TYPE itab2g
                                      VALUE(pc) TYPE itab2c.
ENDCLASS.

CLASS demo_typing IMPLEMENTATION.
  METHOD start.
    DATA: tab TYPE itab1g,
          wa  LIKE LINE OF tab.
    tab = VALUE #(
      FOR j = 1 UNTIL j > 5
        ( cola = j colb = 6 - j ) ).
    sort_itab( pg = tab
               pc = tab ).
  ENDMETHOD.
  METHOD sort_itab.
    DATA(out) = cl_demo_output=>new( ).
    SORT pg BY cola.
    out->write_data( pg ).
    SORT pg BY ('COLA').
    out->write_data( pg ).
    SORT pc BY cola.
    out->write_data( pc ).
    SORT pc BY ('COLA').
    out->write_data( pc ).
    out->display( ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo_typing=>start( ).
