REPORT demo_virtual_sort_combined.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    TYPES:
      BEGIN OF line1,
        col1 TYPE i,
        col2 TYPE i,
      END OF line1,
      itab1 TYPE STANDARD TABLE OF line1 WITH EMPTY KEY,
      BEGIN OF line2,
        col1 TYPE string,
        col2 TYPE string,
      END OF line2,
      itab2 TYPE STANDARD TABLE OF line2 WITH EMPTY KEY.

    TYPES:
      BEGIN OF test_line,
        col11 TYPE i,
        col12 TYPE i,
        col21 TYPE string,
        col22 TYPE string,
      END OF test_line,
      test_tab TYPE STANDARD TABLE OF test_line WITH EMPTY KEY.

    DATA(rnd) = cl_abap_random_int=>create( seed = + sy-uzeit
                                            min  = 0
                                            max  = 1 ).

    DATA(itab1) = VALUE itab1( FOR i = 1 UNTIL i > 10
                               ( col1 = rnd->get_next( )
                                 col2 = rnd->get_next( ) ) ).

    DATA(itab2) =
      VALUE itab2( FOR i = 1 UNTIL i > 10
        ( col1 = cond #( when rnd->get_next( ) = 0 THEN `X`
                                                   ELSE `Y` )
          col2 = cond #( when rnd->get_next( ) = 0 THEN `X`
                                                   ELSE `Y` ) ) ).

    DATA(out) = cl_demo_output=>new( ).

    out->write( itab1
      )->write( itab2 ).

    out->next_section(  `Virtual Sort of Combined Tables`
      )->begin_section( `itab1 by col1, col2, Ascending`
      )->next_section(  `itab2 by col1, col2, Descending` ).

    DATA(v_index) =
      cl_abap_itab_utilities=>virtual_sort(
        im_virtual_source = VALUE #(
         ( source     = REF #( itab1 )
           components = VALUE #( ( name = 'col1' )
                                 ( name = 'col2' ) ) )
         ( source     = REF #( itab2 )
           components = VALUE #( ( name = 'col1'
                                   astext = abap_true
                                   descending = abap_true )
                                 ( name = 'col2'
                                   astext = abap_true
                                   descending = abap_true ) ) ) ) ).

    out->write( v_index ).

    DATA sorted_tab1 TYPE itab1.
    sorted_tab1 = VALUE #( FOR idx IN v_index ( itab1[ idx ] ) ).
    DATA sorted_tab2 TYPE itab2.
    sorted_tab2 = VALUE #( FOR idx IN v_index ( itab2[ idx ] ) ).

    DATA(comb_tab) = VALUE test_tab( FOR i = 1 UNTIL i > 10
                        ( col11 = sorted_tab1[ i ]-col1
                          col12 = sorted_tab1[ i ]-col2
                          col21 = sorted_tab2[ i ]-col1
                          col22 = sorted_tab2[ i ]-col2 ) ).

    DATA(test_tab) = VALUE test_tab( FOR i = 1 UNTIL i > 10
                        ( col11 = itab1[ i ]-col1
                          col12 = itab1[ i ]-col2
                          col21 = itab2[ i ]-col1
                          col22 = itab2[ i ]-col2 ) ).
    SORT test_tab STABLE BY col11
                            col12
                            col21 DESCENDING AS TEXT
                            col22 DESCENDING AS TEXT.

    ASSERT comb_tab = test_tab.

    out->write( comb_tab ).

    out->display( ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
