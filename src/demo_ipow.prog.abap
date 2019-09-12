REPORT demo_ipow.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA n TYPE i.
    DATA arg1 TYPE p DECIMALS 1.
    DATA arg2 TYPE int8.

    n = 2.
    arg1 = `1.2`.
    DATA(out) = cl_demo_output=>new(
      )->write( |**  : { arg1 ** n }|
      )->write( |ipow: { ipow( base = arg1 exp = n ) }| ).

    cl_demo_output=>line( ).

    n = 62.
    arg2 = 2.
    out->write( |**  : { arg2 ** n }|
      )->write( |ipow: { ipow( base = arg2 exp = n ) }| ).

    out->display( ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
