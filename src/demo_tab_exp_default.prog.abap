REPORT demo_tab_exp_default.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    TYPES:
      BEGIN OF line,
        id    TYPE i,
        value TYPE string,
      END OF line,
      itab TYPE SORTED TABLE OF line WITH UNIQUE KEY id.

    DATA(def) = VALUE line( id = 0 value = `not found` ).

    DATA(itab) = VALUE itab( ( id = 3 value = `CCC` )
                             ( id = 4 value = `DDD` )
                             ( id = 5 value = `EEE` ) ).

    DATA(result1) = VALUE #( itab[ id = 1 ] DEFAULT def ).
    cl_demo_output=>write( result1 ).


    DATA(result2) = VALUE #( itab[ id = 1 ]-value DEFAULT def-value ).
    cl_demo_output=>write_data( result2 ).

    DATA(result3) = VALUE #( itab[ id = 1 ] DEFAULT VALUE #(
                             itab[ id = 2 ] DEFAULT VALUE #(
                             itab[ id = 3 ] OPTIONAL ) ) ).
    cl_demo_output=>write_data( result3 ).

    cl_demo_output=>display( ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
