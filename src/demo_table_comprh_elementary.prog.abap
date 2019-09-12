REPORT demo_table_comprh_elementary.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
    TYPES:
      BEGIN OF line1,
        col1 TYPE i,
        col2 TYPE i,
        col3 TYPE i,
        col4 TYPE i,
      END OF line1,
      itab1 TYPE STANDARD TABLE OF line1 WITH EMPTY KEY
                                         WITH UNIQUE SORTED KEY
                                              key COMPONENTS col1,
      BEGIN OF line2,
        col1 TYPE i,
        col2 TYPE i,
      END OF line2,
      itab2 TYPE STANDARD TABLE OF line1 WITH EMPTY KEY,
      itab3 TYPE STANDARD TABLE OF line1 WITH EMPTY KEY,
      itab4 TYPE STANDARD TABLE OF line2 WITH EMPTY KEY,
      itab5 TYPE STANDARD TABLE OF i     WITH EMPTY KEY.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.

    DATA(out) = cl_demo_output=>new( ).

    DATA(itab1) = VALUE itab1(
      FOR j = 41 THEN j - 10 UNTIL j < 10
      ( col1 = j col2 = j + 1 col3 = j + 2 col4 = j + 3 ) ).
    out->write( itab1 ).

    DATA(itab2) = VALUE itab2(
      FOR wa IN itab1 WHERE ( col1 < 30 )
        ( wa ) ).
    out->write( itab2 ).

    DATA(itab3) = VALUE itab3(
      FOR wa IN itab1 INDEX INTO idx WHERE ( col1 = 21 ) ##PRIMKEY[key]
        ( LINES OF itab1 from idx ) ).
    out->write( itab3 ).

    DATA(itab4) = VALUE itab4(
       FOR wa IN itab1 FROM 2 TO 3
         ( col1 = wa-col2 col2 = wa-col3 ) ).
    out->write( itab4 ).

    DATA(base)  = VALUE itab5( ( 1 ) ( 2 ) ( 3 ) ).
    DATA(itab5) = VALUE itab5(
       BASE base
       FOR wa IN itab1 USING KEY key
          ( wa-col1 ) ).
    out->write( itab5 ).

    out->display( ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
