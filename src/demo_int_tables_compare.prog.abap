REPORT demo_int_tables_compare .

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.

    TYPES: BEGIN OF line,
             col1 TYPE i,
             col2 TYPE i,
           END OF line.

    DATA: itab TYPE TABLE OF line WITH EMPTY KEY,
          jtab TYPE TABLE OF line WITH EMPTY KEY.

    DATA(out) = cl_demo_output=>new( ).

    itab = VALUE #( FOR j = 1 UNTIL j > 3
      ( col1 = j col2 = j ** 2 ) ).

    jtab = itab.

    itab = VALUE #( BASE itab
                    ( col1 = 10 col2 = 20 ) ).

    IF itab > jtab.
      out->write( 'ITAB >  JTAB' ).
    ENDIF.

    jtab = VALUE #( BASE jtab
                    ( col1 = 10 col2 = 20 ) ).

    IF itab = jtab.
      out->write( 'ITAB =  JTAB' ).
    ENDIF.

    itab = VALUE #( BASE itab
                    ( col1 = 30 col2 = 80 ) ).

    IF jtab <= itab.
      out->write( 'JTAB <= ITAB' ).
    ENDIF.

    jtab = VALUE #( BASE jtab
                    ( col1 = 50 col2 = 60 ) ).

    IF itab <> jtab.
      out->write( 'ITAB <> JTAB' ).
    ENDIF.

    IF itab < jtab.
      out->write( 'ITAB <  JTAB' ).
    ENDIF.

    out->display( ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
