REPORT demo_sort_itab_exp.

CLASS cx_illegal_direction DEFINITION INHERITING FROM cx_static_check.
ENDCLASS.

CLASS demo_sort DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
  PRIVATE SECTION.
    CLASS-DATA itab TYPE TABLE OF string WITH EMPTY KEY.
    CLASS-METHODS sort_itab
      IMPORTING direction TYPE string
      RETURNING VALUE(r) LIKE itab
      RAISING   cx_illegal_direction.
ENDCLASS.

CLASS demo_sort IMPLEMENTATION.
  METHOD main.
    itab = VALUE #( ( `b` ) ( `a` ) ( `c` ) ).
    TRY.
        DATA(out) = cl_demo_output=>new( ).
        out->write( sort_itab( 'DOWN' )
          )->write( sort_itab( 'UP' )
          )->display( ).
      CATCH cx_illegal_direction.
        RETURN.
    ENDTRY.
  ENDMETHOD.
  METHOD sort_itab.
    SORT itab BY VALUE abap_sortorder_tab(
       ( name       = 'TABLE_LINE'
         descending = SWITCH #( direction
                                WHEN 'UP'   THEN ' '
                                WHEN 'DOWN' THEN 'X'
                                ELSE THROW cx_illegal_direction( ) )
         astext     = 'X ' ) ).
    r = itab.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo_sort=>main( ).
