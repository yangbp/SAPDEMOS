REPORT demo_int_tables_sort_text .

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.

    DATA: BEGIN OF line,
            text(6) TYPE c,
            xtext TYPE xstring,
          END OF line.

    DATA itab LIKE HASHED TABLE OF line WITH UNIQUE KEY text.

    DATA(out) = cl_demo_output=>new( ).

    line-text = 'Muller'(001).
    CONVERT TEXT line-text INTO SORTABLE CODE line-xtext.
    INSERT line INTO TABLE itab.

    line-text = 'Möller'(002).
    CONVERT TEXT line-text INTO SORTABLE CODE line-xtext.
    INSERT line INTO TABLE itab.

    line-text = 'Moller'(003).
    CONVERT TEXT line-text INTO SORTABLE CODE line-xtext.
    INSERT line INTO TABLE itab.

    line-text = 'Miller'(004).
    CONVERT TEXT line-text INTO SORTABLE CODE line-xtext.
    INSERT line INTO TABLE itab.

    SORT itab.
    out->write_data( itab ).

    SORT itab BY xtext.
    out->write_data( itab ).

    SORT itab AS TEXT.
    out->write_data( itab ).

    out->display( ).
  ENDMETHOD.

ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
