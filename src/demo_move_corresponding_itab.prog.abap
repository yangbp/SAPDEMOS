REPORT demo_move_corresponding_itab.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.

  PRIVATE SECTION.
    TYPES:
      c3 TYPE c LENGTH 3,

      BEGIN OF iline1,
        col1 TYPE c3,
        col2 TYPE c3,
      END OF iline1,

      BEGIN OF iline2,
        col2 TYPE c3,
        col3 TYPE c3,
      END OF iline2,

      BEGIN OF line1,
        col1 TYPE                   c3,
        col2 TYPE                   c3,
        col3 TYPE STANDARD TABLE OF iline1 WITH EMPTY KEY,
      END OF line1,

      BEGIN OF line2,
        col2 TYPE                   c3,
        col3 TYPE STANDARD TABLE OF iline2 WITH EMPTY KEY,
        col4 TYPE                   c3,
      END OF line2.

    CLASS-DATA:
      itab1 TYPE STANDARD TABLE OF line1 WITH EMPTY KEY,
      itab2 TYPE STANDARD TABLE OF line2 WITH EMPTY KEY,

      out   TYPE REF TO            if_demo_output.

    CLASS-METHODS:
      fill_tables,
      display_table1,
      display_table2.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA buffer LIKE itab2.
    out = cl_demo_output=>new( ).
    fill_tables( ).
    out->begin_section( `itab1` ).
    display_table1( ).
    out->next_section( `itab2` ).
    display_table2( ).
    buffer = itab2.

    out->begin_section(
      `MOVE-CORRESPONDING` ).

    MOVE-CORRESPONDING itab1 TO itab2.

    display_table2( ).
    itab2 = buffer.
    out->next_section(
      `MOVE-CORRESPONDING KEEPING TARGET LINES` ).

    MOVE-CORRESPONDING itab1 TO itab2 KEEPING TARGET LINES.

    display_table2( ).
    itab2 = buffer.
    out->next_section(
      `MOVE-CORRESPONDING EXPANDING NESTED TABLES` ).

    MOVE-CORRESPONDING itab1 TO itab2 EXPANDING NESTED TABLES.

    display_table2( ).
    itab2 = buffer.
    out->next_section(
      `MOVE-CORRESPONDING EXPANDING NESTED TABLES ` &&
      `KEEPING TARGET LINES` ).

    MOVE-CORRESPONDING itab1 TO itab2 EXPANDING NESTED TABLES
                                      KEEPING TARGET LINES.

    display_table2( ).
    out->display( ).
  ENDMETHOD.
  METHOD fill_tables.
    itab1 = VALUE #(
      ( col1 = 'a11'
        col2 = 'a12'
        col3 = VALUE #( ( col1 = 'a11'  col2 = 'a12' )
                        ( col1 = 'a21'  col2 = 'a22' ) ) )
      ( col1 = 'b21'
        col2 = 'b22'
        col3 = VALUE #( ( col1 = 'b11'  col2 = 'b12' )
                        ( col1 = 'b21'  col2 = 'b22' ) ) )
      ( col1 = 'c31'
        col2 = 'c32'
        col3 = VALUE #( ( col1 = 'c11'  col2 = 'c12' )
                        ( col1 = 'c21'  col2 = 'c22' ) ) ) ).

    itab2 = VALUE #(
      ( col2 = 'x11'
        col3 = VALUE #( ( col2 = 'x11'  col3 = 'x12' )
                        ( col2 = 'x21'  col3 = 'x22' )
                        ( col2 = 'x31'  col3 = 'x32' ) )
        col4 = 'x12' )
      ( col2 = 'y21'
        col3 = VALUE #( ( col2 = 'y11'  col3 = 'y12' )
                        ( col2 = 'y21'  col3 = 'y22' )
                        ( col2 = 'y31'  col3 = 'y32' ) )
        col4 = 'y22' ) ).
  ENDMETHOD.
  METHOD display_table1.
    DATA:
      BEGIN OF outl,
        col1  TYPE c3,
        col2  TYPE c3,
        col31 TYPE c3,
        col32 TYPE c3,
      END OF outl.
    DATA output LIKE STANDARD TABLE OF outl WITH EMPTY KEY.
    LOOP AT itab1 ASSIGNING FIELD-SYMBOL(<wa>).
      outl-col1 = <wa>-col1.
      outl-col2 = <wa>-col2.
      LOOP AT <wa>-col3 ASSIGNING FIELD-SYMBOL(<col3>).
        outl-col31 = <col3>-col1.
        outl-col32 = <col3>-col2.
        IF sy-tabix > 1.
          CLEAR outl-col1.
          CLEAR outl-col2.
        ENDIF.
        APPEND outl TO output.
      ENDLOOP.
    ENDLOOP.
    out->write( output ).
  ENDMETHOD.
  METHOD display_table2.
    DATA:
      BEGIN OF outl,
        col2  TYPE c3,
        col32 TYPE c3,
        col33 TYPE c3,
        col4  TYPE c3,
      END OF outl.
    DATA output LIKE STANDARD TABLE OF outl WITH EMPTY KEY.
    LOOP AT itab2 ASSIGNING FIELD-SYMBOL(<wa>).
      outl-col2 = <wa>-col2.
      outl-col4 = <wa>-col4.
      LOOP AT <wa>-col3 ASSIGNING FIELD-SYMBOL(<col3>).
        outl-col32 = <col3>-col2.
        outl-col33 = <col3>-col3.
        IF sy-tabix > 1.
          CLEAR outl-col2.
          CLEAR outl-col4.
        ENDIF.
        APPEND outl TO output.
      ENDLOOP.
    ENDLOOP.
    out->write( output ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
