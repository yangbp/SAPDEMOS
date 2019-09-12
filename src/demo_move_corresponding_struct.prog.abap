REPORT demo_move_corresponding_struct.

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
      struct1 TYPE        line1,
      struct2 TYPE        line2,

      out     TYPE REF TO if_demo_output.

    CLASS-METHODS:
      fill_structures,
      display_structure1,
      display_structure2.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    out = cl_demo_output=>new( ).
    fill_structures( ).
    out->begin_section( `struct1` ).
    display_structure1( ).
    out->next_section( `struct2` ).
    display_structure2( ).

    out->begin_section(
      `MOVE-CORRESPONDING` ).

    MOVE-CORRESPONDING struct1 TO struct2.

    display_structure2( ).
    out->next_section(
      `MOVE-CORRESPONDING EXPANDING NESTED TABLES` ).

    MOVE-CORRESPONDING struct1 TO struct2 EXPANDING NESTED TABLES.

    display_structure2( ).
    out->display( ).
  ENDMETHOD.
  METHOD fill_structures.
    struct1 = VALUE #(
       col1 = 'a1'
       col2 = 'a2'
       col3 = VALUE #( ( col1 = 'a11'  col2 = 'a12' )
                       ( col1 = 'a21'  col2 = 'a22' ) ) ).

    struct2 = VALUE #(
       col2 = 'x11'
       col3 = VALUE #( ( col2 = 'x11'  col3 = 'x12' )
                       ( col2 = 'x21'  col3 = 'x22' )
                       ( col2 = 'x31'  col3 = 'x32' ) )
       col4 = 'x12'  ).
  ENDMETHOD.
  METHOD display_structure1.
    DATA:
      BEGIN OF outl,
        col1  TYPE c3,
        col2  TYPE c3,
        col31 TYPE c3,
        col32 TYPE c3,
      END OF outl.
    DATA output LIKE STANDARD TABLE OF outl WITH EMPTY KEY.
    outl-col1 = struct1-col1.
    outl-col2 = struct1-col2.
    LOOP AT struct1-col3 ASSIGNING FIELD-SYMBOL(<col3>).
      outl-col31 = <col3>-col1.
      outl-col32 = <col3>-col2.
      IF sy-tabix > 1.
        CLEAR outl-col1.
        CLEAR outl-col2.
      ENDIF.
      APPEND outl TO output.
    ENDLOOP.
    out->write( output ).
  ENDMETHOD.
  METHOD display_structure2.
    DATA:
      BEGIN OF outl,
        col2  TYPE c3,
        col32 TYPE c3,
        col33 TYPE c3,
        col4  TYPE c3,
      END OF outl.
    DATA output LIKE STANDARD TABLE OF outl WITH EMPTY KEY.
    outl-col2 = struct2-col2.
    outl-col4 = struct2-col4.
    LOOP AT struct2-col3 ASSIGNING FIELD-SYMBOL(<col3>).
      outl-col32 = <col3>-col2.
      outl-col33 = <col3>-col3.
      IF sy-tabix > 1.
        CLEAR outl-col2.
        CLEAR outl-col4.
      ENDIF.
      APPEND outl TO output.
    ENDLOOP.
    out->write( output ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
