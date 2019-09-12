REPORT demo_int_tables_delete_ind_1.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.

    DATA itab TYPE SORTED TABLE OF i WITH UNIQUE KEY table_line.

    FIELD-SYMBOLS <line> LIKE LINE OF itab.

    DATA(out) = cl_demo_output=>new( ).

    itab = VALUE #( FOR j = 1 UNTIL j > 5 ( j ) ).

    DELETE itab INDEX: 2, 3, 4.

    out->write( |sy-subrc: { sy-subrc }| ).

    LOOP AT itab ASSIGNING <line>.
      out->write( |{ sy-tabix } { <line> }| ).
    ENDLOOP.

    out->display( ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
