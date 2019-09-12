REPORT demo_loop_group_by_random.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS:
      main,
      class_constructor.
  PRIVATE SECTION.
    CLASS-DATA
      numbers TYPE STANDARD TABLE OF i WITH EMPTY KEY.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA(out) = cl_demo_output=>new( ).

    DATA(rnd) = cl_abap_random_int=>create(
      seed = CONV i( sy-uzeit ) min = 1 max = 10 ).

    DATA members LIKE numbers.
    LOOP AT numbers INTO DATA(line)
         GROUP BY rnd->get_next( )
                  ASCENDING
                  ASSIGNING FIELD-SYMBOL(<group>).
      out->begin_section( |Group Key: { <group> }| ).
      members = VALUE #( FOR <wa> IN GROUP <group> ( <wa> ) ).
      out->write( members
        )->write( |Lines: { lines( members ) }|
        )->end_section( ).
    ENDLOOP.

    out->display( ).
  ENDMETHOD.
  METHOD class_constructor.
    numbers = VALUE #( FOR j = 1 UNTIL j > 100 ( j ) ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
