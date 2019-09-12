REPORT demo_int_tables_sort_sec_key .

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.

    DATA: BEGIN OF struct,
            col1 TYPE c LENGTH 1,
            col2 TYPE c LENGTH 1,
          END OF struct.

    DATA itab LIKE STANDARD TABLE OF struct
         WITH NON-UNIQUE KEY col1
         WITH UNIQUE HASHED KEY sec_key COMPONENTS col2.

    DATA jtab LIKE itab.

    DATA(out) = cl_demo_output=>new( ).

    itab = VALUE #( ( col1 = 'A' col2 = '1' )
                    ( col1 = 'A' col2 = '2' )
                    ( col1 = 'B' col2 = '3' )
                    ( col1 = 'B' col2 = '4' ) ).

    LOOP AT itab INTO struct.
      APPEND struct TO jtab.
    ENDLOOP.
    out->write_data( jtab ).

    CLEAR jtab.
    SORT itab BY col2 DESCENDING.

    LOOP AT itab INTO struct.
      APPEND struct TO jtab.
    ENDLOOP.
    out->write_data( jtab ).

    CLEAR jtab.
    LOOP AT itab INTO struct USING KEY sec_key.
      APPEND struct TO jtab.
    ENDLOOP.
    out->write_data( jtab ).

    out->display( ).
  ENDMETHOD.

ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
