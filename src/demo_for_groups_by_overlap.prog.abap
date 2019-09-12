REPORT demo_for_groups_by_overlap.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS:
      main,
      class_constructor.
  PRIVATE SECTION.
    TYPES
      i_tab TYPE STANDARD TABLE OF i WITH EMPTY KEY.
    CLASS-DATA
      itab TYPE i_tab.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA out TYPE REF TO if_demo_output.

    out = REDUCE #(
      INIT o = cl_demo_output=>new(
                  )->begin_section( `LE 5, BT 3 AND 7, GT 5` )
      FOR GROUPS <group> OF wa IN itab
            GROUP BY COND string( WHEN wa <= 5 THEN `LE 5`
                                  WHEN wa BETWEEN 3 AND 7
                                               THEN `BT 3 AND 7`
                                  WHEN wa >  5 THEN `GT 5` )
      LET members = VALUE i_tab(
                      FOR <member> IN GROUP <group> ( <member> ) ) IN
      NEXT o = o->begin_section( <group>
               )->write( members )->end_section( ) ).


    out = REDUCE #(
      INIT o = out->next_section( `BT 3 AND 7, LE 5, GT 5` )
      FOR GROUPS <group> OF wa IN itab
            GROUP BY COND string( WHEN wa BETWEEN 3 AND 7
                                               THEN `BT 3 AND 7`
                                  WHEN wa <= 5 THEN `LE 5`
                                               ELSE `GT 5` )
      LET members = VALUE i_tab(
                       FOR <member> IN GROUP <group> ( <member> ) )
      IN NEXT o = o->begin_section( <group>
                  )->write( members )->end_section( ) ).

    out->display( ).
  ENDMETHOD.
  METHOD class_constructor.
    itab = VALUE #( FOR j = 1 UNTIL j > 10 ( j ) ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
