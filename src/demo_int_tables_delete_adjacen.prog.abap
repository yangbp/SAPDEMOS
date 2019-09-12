REPORT demo_int_tables_delete_adjacen.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.

    DATA: BEGIN OF line,
            col1 TYPE i,
            col2 TYPE c LENGTH 1,
          END OF line.

    DATA itab LIKE STANDARD TABLE OF line
              WITH NON-UNIQUE KEY col2.

    itab = VALUE #( ( col1 = 1 col2 = 'A' )
                    ( col1 = 1 col2 = 'A' )
                    ( col1 = 1 col2 = 'B' )
                    ( col1 = 2 col2 = 'B' )
                    ( col1 = 3 col2 = 'B' )
                    ( col1 = 4 col2 = 'B' )
                    ( col1 = 5 col2 = 'A' ) ).

    DATA(out) = cl_demo_output=>new(
      )->write_data( itab ).

    DELETE ADJACENT DUPLICATES FROM itab COMPARING ALL FIELDS.
    out->write_data( itab ).

    DELETE ADJACENT DUPLICATES FROM itab COMPARING col1.
    out->write_data( itab ).

    DELETE ADJACENT DUPLICATES FROM itab.
    out->write_data( itab
       )->display( ).

  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
