REPORT demo_table_comprh_join.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    TYPES:
      BEGIN OF line1,
        key TYPE c LENGTH 1,
        col1 TYPE i,
        col2 TYPE i,
      END OF line1,
      itab1 TYPE STANDARD TABLE OF line1 WITH EMPTY KEY,
      BEGIN OF line2,
        key TYPE c LENGTH 1,
        col1 TYPE i,
        col2 TYPE i,
      END OF line2,
      itab2 TYPE STANDARD TABLE OF line2 WITH EMPTY KEY,
      BEGIN OF line3,
        key TYPE c LENGTH 1,
        col11 TYPE i,
        col12 TYPE i,
        col21 TYPE i,
        col22 TYPE i,
      END OF line3,
      itab3 TYPE STANDARD TABLE OF line3 WITH EMPTY KEY.

    DATA(out) = cl_demo_output=>new( ).

    DATA(itab1) = VALUE itab1(
      ( key = 'a' col1 = 11 col2 = 12 )
      ( key = 'b' col1 = 21 col2 = 22 )
      ( key = 'c' col1 = 31 col2 = 32 ) ).
    out->write( itab1 ).

    DATA(itab2) = VALUE itab2(
      ( key = 'a' col1 = 13 col2 = 14 )
      ( key = 'b' col1 = 23 col2 = 24 )
      ( key = 'c' col1 = 33 col2 = 34 ) ).
    out->write( itab2 ).

    DATA(itab3) = VALUE itab3(
      FOR wa IN itab1
        ( key   = wa-key
          col11 = wa-col1
          col12 = wa-col2
          col21 = itab2[ key = wa-key ]-col1
          col22 = itab2[ key = wa-key ]-col2 ) ).
    out->write( itab3 ).

    DATA(itab4) = VALUE itab3(
      FOR wa1 IN itab1 INDEX INTO idx
      FOR wa2 IN itab2 WHERE ( key = wa1-key )
        ( key   = wa1-key
          col11 = wa1-col1
          col12 = wa1-col2
          col21 = wa2-col1
          col22 = wa2-col2 ) ).
    out->write( itab4 ).

    out->display( ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
