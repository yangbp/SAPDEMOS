REPORT demo_corresponding_class_tb.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    TYPES: BEGIN OF line1,
             col1 TYPE i,
             col2 TYPE i,
           END OF line1,
           BEGIN OF line2,
             col2 TYPE i,
             col3 TYPE i,
           END OF line2.

    DATA: itab1 TYPE TABLE OF line1 WITH EMPTY KEY,
          itab2 TYPE TABLE OF line2 WITH EMPTY KEY.

    DATA(out) = cl_demo_output=>new( ).

    itab1 = VALUE #(
      ( col1 = 11 col2 = 12 )
      ( col1 = 21 col2 = 22 ) ).

    itab2 = VALUE #(
      ( col2 = 212 col3 = 312 )
      ( col2 = 222 col3 = 322 ) ).

   cl_abap_corresponding=>create(
      source            = itab1
      destination       = itab2
      mapping           = VALUE cl_abap_corresponding=>mapping_table(  )
      )->execute( EXPORTING source      = itab1
                  CHANGING  destination = itab2 ).
    out->write( itab2 ).

    cl_abap_corresponding=>create(
      source            = itab1
      destination       = itab2
      mapping           = VALUE cl_abap_corresponding=>mapping_table(
       ( level = 0 kind = 1 srcname = 'col1' dstname = 'col2' )
       ( level = 0 kind = 1 srcname = 'col2' dstname = 'col3' ) )
      )->execute( EXPORTING source      = itab1
                  CHANGING  destination = itab2 ).
    out->write( itab2 ).

    out->display( ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
