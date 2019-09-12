REPORT demo_virtual_sort_filter.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    TYPES
      itab TYPE STANDARD TABLE OF i WITH EMPTY KEY.

    DATA(rnd) = cl_abap_random_int=>create( seed = + sy-uzeit
                                            min  = 1
                                            max  = 10 ).

    DATA(itab) = VALUE itab( FOR i = 1 UNTIL i > 10
                             ( rnd->get_next( ) ) ).

    DATA(out) = cl_demo_output=>new( ).

    out->write( itab ).

    out->next_section( `Virtual Sort by table_line with Filter` ).

    DATA(v_index) =
      cl_abap_itab_utilities=>virtual_sort(
        im_virtual_source = VALUE #(
         ( source     = REF #( itab )
           components = VALUE #( ( name = 'table_line' ) ) ) )
        im_filter_index =  VALUE #( ( 1 ) ( 3 ) ( 5 ) ( 7 ) ( 9 ) ) ).

    out->write( v_index ).

    DATA sorted_tab TYPE itab.
    sorted_tab = VALUE #( FOR idx IN v_index ( itab[ idx ] ) ).

    out->write( sorted_tab ).

    out->display( ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
