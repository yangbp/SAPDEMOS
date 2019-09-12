REPORT demo_int_tables_append.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA(out) = cl_demo_output=>new( ).

    "Part 1
    TYPES: BEGIN OF wa,
             col1 TYPE c LENGTH 1,
             col2 TYPE i,
           END OF wa.

    DATA wa_tab TYPE TABLE OF wa WITH EMPTY KEY.

    DO 3 TIMES.
      APPEND INITIAL LINE TO wa_tab.
      APPEND VALUE #( col1 = sy-index col2 = sy-index ** 2 ) TO wa_tab.
    ENDDO.

    out->write_data( wa_tab
      )->line( ).

    "Part 2
    TYPES: BEGIN OF line1,
             col1 TYPE c LENGTH 3,
             col2 TYPE n LENGTH 2,
             col3    TYPE i,
           END OF line1,
           BEGIN OF line2,
             field1 TYPE c LENGTH 1,
             field2 TYPE TABLE OF line1 WITH EMPTY KEY,
           END OF line2.

    DATA: tab1 TYPE TABLE OF line1 WITH EMPTY KEY,
          tab2 TYPE TABLE OF line2 WITH EMPTY KEY.

    APPEND VALUE #( col1 = 'abc' col2 = '12' col3 = 3 ) TO tab1.
    APPEND VALUE #( col1 = 'def' col2 = '34' col3 = 5 ) TO tab1.
    APPEND VALUE #( field1 = 'A' field2 = tab1 ) TO tab2.

    CLEAR tab1.
    APPEND VALUE #( col1 = 'ghi' col2 = '56' col3 = 7 ) TO tab1.
    APPEND VALUE #( col1 = 'jkl' col2 = '78' col3 = 9 ) TO tab1.
    APPEND VALUE #( field1 = 'B' field2 = tab1 ) TO tab2.

    LOOP AT tab2 ASSIGNING FIELD-SYMBOL(<line2>).
      out->write_data( <line2>-field1 ).
      out->write_data( <line2>-field2 ).
    ENDLOOP.
    out->line( ).

    "Part 3
    TYPES: BEGIN OF line,
             col1 TYPE c LENGTH 1,
             col2 TYPE i,
           END OF line.

    DATA: itab TYPE TABLE OF line WITH EMPTY KEY,
          jtab LIKE itab.

    DO 3 TIMES.
      APPEND VALUE #( col1 = sy-index col2 = sy-index ** 2 ) TO itab.
      APPEND VALUE #( col1 = sy-index col2 = sy-index ** 3 ) TO jtab.
    ENDDO.
    APPEND LINES OF jtab FROM 2 TO 3 TO itab.
    out->write_data( itab ).

    out->display( ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
