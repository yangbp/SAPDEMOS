REPORT demo_int_tables_sort.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.

    TYPES: BEGIN OF line,
             land   TYPE c LENGTH 3,
             name   TYPE c LENGTH 10,
             age    TYPE i,
             weight TYPE p LENGTH 8 DECIMALS 2,
           END OF line.

    DATA itab TYPE STANDARD TABLE OF line WITH NON-UNIQUE KEY land.

    itab =
      VALUE #(
        ( land = 'D'   name = 'Hans'    age = 20 weight = '80.00' )
        ( land = 'USA' name = 'Nancy'   age = 35 weight = '45.00' )
        ( land = 'USA' name = 'Howard'  age = 40 weight = '95.00' )
        ( land = 'GB'  name = 'Jenny'   age = 18 weight = '50.00' )
        ( land = 'F'   name = 'Michele' age = 30 weight = '60.00' )
        ( land = 'G'   name = 'Karl'    age = 60 weight = '75.00' ) ).

    DATA(out) = cl_demo_output=>new( )->write_data( itab ).

    SORT itab.
    out->write_data( itab ).

    SORT itab.
    out->write_data( itab ).

    SORT itab STABLE.
    out->write_data( itab ).

    SORT itab DESCENDING BY land weight ASCENDING.
    out->write_data( itab )->display( ).

  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
