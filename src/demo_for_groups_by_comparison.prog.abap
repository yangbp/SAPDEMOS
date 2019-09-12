REPORT demo_for_groups_by_comparison.
CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS:
      main,
      class_constructor.
  PRIVATE SECTION.
    TYPES:
      number_tab TYPE STANDARD TABLE OF i WITH EMPTY KEY.
    CLASS-DATA:
      numbers TYPE number_tab.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA out TYPE REF TO if_demo_output.

    DATA(threshold) = 5.
    cl_demo_input=>request( CHANGING field = threshold ).

    out = REDUCE #(
      INIT o = cl_demo_output=>new(
                  )->begin_section( `Grouping` )
      FOR GROUPS <group> OF number IN numbers
            GROUP BY COND string(
              WHEN number <= threshold THEN |LE { threshold }|
                                       ELSE |GT { threshold }| )
      LET members = VALUE number_tab(
                      FOR <member> IN GROUP <group> ( <member> ) ) IN
      NEXT o = o->begin_section( <group>
               )->write( members )->end_section( ) ).

    out->display( ).
  ENDMETHOD.
  METHOD class_constructor.
    numbers = VALUE #( FOR j = 1 UNTIL j > 10 ( j ) ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
