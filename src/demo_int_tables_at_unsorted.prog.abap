REPORT demo_int_tables_at_unsorted.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS: main,
      class_constructor .
  PRIVATE SECTION.
    TYPES: BEGIN OF t_line,
             col1 TYPE string,
             col2 TYPE string,
           END OF t_line,
           t_itab TYPE STANDARD TABLE OF t_line WITH EMPTY KEY.
    CLASS-DATA itab TYPE t_itab.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA(out) = cl_demo_output=>new( ).

    out->begin_section(
      `Control Level Processing for Unsorted Table` ).
    DATA group TYPE t_itab.
    LOOP AT itab INTO DATA(wa).
      AT NEW col1.
        CLEAR group.
      ENDAT.
      group = VALUE #( BASE group ( wa ) ).
      AT END OF col1.
        out->write( group ).
      ENDAT.
    ENDLOOP.

    out->next_section(
      `Grouping for Unsorted Table` ).
    LOOP AT itab INTO wa GROUP BY wa-col1.
      group = VALUE #( FOR <wa> IN GROUP wa ( <wa> ) ).
      out->write( group ).
    ENDLOOP.

    out->begin_section(
      `Control Level Processing for Sorted Table` ).
    SORT itab BY col1 ASCENDING.
    LOOP AT itab INTO wa.
      AT NEW col1.
        CLEAR group.
      ENDAT.
      group = VALUE #( BASE group ( wa ) ).
      AT END OF col1.
        out->write( group ).
      ENDAT.
    ENDLOOP.

    out->display( ).
  ENDMETHOD.
  METHOD class_constructor.
    itab = VALUE t_itab( ( col1 = `a` col2 = `0` )
                         ( col1 = `a` col2 = `1` )
                         ( col1 = `a` col2 = `2` )
                         ( col1 = `a` col2 = `3` )
                         ( col1 = `b` col2 = `4` )
                         ( col1 = `b` col2 = `5` )
                         ( col1 = `b` col2 = `6` )
                         ( col1 = `b` col2 = `7` )
                         ( col1 = `a` col2 = `8` )
                         ( col1 = `a` col2 = `9` ) ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
