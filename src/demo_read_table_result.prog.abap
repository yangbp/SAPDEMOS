REPORT demo_read_table_result.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.

    DATA: BEGIN OF line,
            col1 TYPE i,
            col2 TYPE i,
          END OF line.

    DATA itab LIKE SORTED TABLE OF line WITH UNIQUE KEY col1.

    DATA subrc TYPE sy-subrc.
    DATA tabix TYPE sy-tabix.

    FIELD-SYMBOLS <fs> LIKE LINE OF itab.

    DATA(out) = cl_demo_output=>new( ).

    itab = VALUE #( FOR j = 1 UNTIL j > 4
            ( col1 = j col2 = j ** 2 ) ).

    out->write_data( itab )->line( ).

* INTO line COMPARING

    line-col1 = 2.
    line-col2 = 3.

    READ TABLE itab FROM line INTO line COMPARING col2.
    subrc = sy-subrc.

    out->write( |sy-subrc: { subrc }| ).
    out->write_data( line )->line( ).

* INTO line TRANSPORTING

    CLEAR line.

    READ TABLE itab WITH TABLE KEY col1 = 3
                    INTO line TRANSPORTING col2.
    subrc = sy-subrc.
    tabix = sy-tabix.

    out->write( |sy-subrc: { subrc }|
      )->write( |sy-tabix: { tabix }|
      )->write_data( line
      )->line( ).

* TRANSPORTING NO FIELDS

    READ TABLE itab WITH KEY col2 = 16  TRANSPORTING NO FIELDS.
    subrc = sy-subrc.
    tabix = sy-tabix.
    out->write( |sy-subrc: { subrc }|
      )->write( |sy-tabix: { tabix }|
      )->line( ).

* ASSIGNING

    READ TABLE itab WITH TABLE KEY col1 = 2 ASSIGNING <fs>.

    <fs>-col2 = 100.

    out->write_data( itab ).

    out->display( ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
