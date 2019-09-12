REPORT demo_corresponding_class_strtb.

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

    DATA: BEGIN OF struc1,
            itab TYPE TABLE OF line1 WITH EMPTY KEY,
          END OF struc1.

    DATA: BEGIN OF struc2,
            itab TYPE TABLE OF line2 WITH EMPTY KEY,
          END OF struc2.

    data(out) = cl_demo_output=>new( ).

    struc1-itab = VALUE #(
      ( col1 = 11 col2 = 12 )
      ( col1 = 21 col2 = 22 ) ).

    MOVE-CORRESPONDING struc1 TO struc2.
    out->write( struc2-itab ).

    CLEAR struc2-itab.
    MOVE-CORRESPONDING struc1 TO struc2 EXPANDING NESTED TABLES.
    out->write( struc2-itab ).

    CLEAR struc2-itab.
    struc2 = CORRESPONDING #( struc1 ).
    out->write( struc2-itab ).

    CLEAR struc2-itab.
    struc2 = CORRESPONDING #( DEEP struc1 ).
    out->write( struc2-itab ).

    CLEAR struc2-itab.
    cl_abap_corresponding=>create(
      source            = struc1
      destination       = struc2
      mapping           = VALUE cl_abap_corresponding=>mapping_table(  )
      )->execute( EXPORTING source      = struc1
                  CHANGING  destination = struc2 ).
    out->write( struc2-itab ).

    out->display( ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
