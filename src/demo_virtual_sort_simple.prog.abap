REPORT demo_virtual_sort_simple.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    TYPES:
      BEGIN OF line,
        col1 TYPE i,
        col2 TYPE i,
        col3 TYPE string,
        col4 TYPE string,
      END OF line,
      itab TYPE STANDARD TABLE OF line WITH EMPTY KEY.

    DATA(rnd) = cl_abap_random_int=>create( seed = + sy-uzeit
                                            min  = 1
                                            max  = 10 ).

    DATA(itab) = VALUE itab( FOR i = 1 UNTIL i > 10
                             ( col1 = rnd->get_next( )
                               col2 = rnd->get_next( )
                               col3 = substring(
                                        val = sy-abcde
                                        off = rnd->get_next( ) - 1
                                        len = 1 )
                               col4 = substring(
                                        val = sy-abcde
                                        off = rnd->get_next( ) - 1
                                        len = 1 ) ) ).

    DATA(out) = cl_demo_output=>new( ).

    out->write( itab ).

    out->next_section( `Virtual Sort by col1, col2, Ascending` ).

    DATA(v_index) =
      cl_abap_itab_utilities=>virtual_sort(
        im_virtual_source = VALUE #(
         ( source     = REF #( itab )
           components = VALUE #( ( name = 'col1' )
                                 ( name = 'col2' ) ) ) ) ).

    out->write( v_index ).

    DATA sorted_tab TYPE itab.
    sorted_tab = VALUE #( FOR idx IN v_index ( itab[ idx ] ) ).

    DATA(test_tab) = itab.
    SORT test_tab STABLE BY col1 col2.
    ASSERT sorted_tab = test_tab.

    out->write( sorted_tab ).

    out->next_section( `Virtual Sort by col3, col4, Descending` ).

    v_index =
      cl_abap_itab_utilities=>virtual_sort(
        im_virtual_source = VALUE #(
         ( source     = REF #( itab )
           components = VALUE #(
                         ( name = 'col3'
                           astext = abap_true
                           descending = abap_true )
                         ( name = 'col4'
                           astext = abap_true
                           descending = abap_true ) ) ) ) ).

    out->write( v_index ).

    sorted_tab = VALUE #( FOR idx IN v_index ( itab[ idx ] ) ).

    test_tab = itab.
    SORT test_tab STABLE BY col3 AS TEXT DESCENDING
                            col4 AS TEXT DESCENDING.
    ASSERT sorted_tab = test_tab.

    out->write( sorted_tab ).

    out->display( ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
