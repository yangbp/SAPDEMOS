REPORT demo_group_by_overlap.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS:
      main,
      class_constructor.
  PRIVATE SECTION.
    CLASS-DATA
      itab TYPE TABLE OF i WITH EMPTY KEY.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA(out) = cl_demo_output=>new( ).

    DATA members LIKE itab.

    out->begin_section( `LE 5, BT 2 AND 7, GT 5` ).
    LOOP AT itab INTO DATA(wa)
         GROUP BY COND string( WHEN wa <= 5 THEN `LE 5`
                               WHEN wa >  2 AND
                                    wa <= 7 THEN `BT 2 AND 7`
                               WHEN wa >  5 THEN `GT 5` )
                 ASSIGNING FIELD-SYMBOL(<group>).
      out->begin_section( <group> ).
      CLEAR members.
      LOOP AT GROUP <group> ASSIGNING FIELD-SYMBOL(<wa>).
        members = VALUE #( BASE members ( <wa> ) ).
      ENDLOOP.
      out->write( members )->end_section( ).
    ENDLOOP.

    out->next_section( `BT 2 AND 7, LE 5, GT 5` ).
    LOOP AT itab INTO wa
         GROUP BY COND string( WHEN wa >  2 AND
                                    wa <= 7 THEN `BT 2 AND 7`
                               WHEN wa <= 5 THEN `LE 5`
                               WHEN wa >  5 THEN `GT 5` )
                 ASSIGNING <group>.
      out->begin_section( <group> ).
      CLEAR members.
      LOOP AT GROUP <group> ASSIGNING <wa>.
        members = VALUE #( BASE members ( <wa> ) ).
      ENDLOOP.
      out->write( members )->end_section( ).
    ENDLOOP.

    out->display( ).
  ENDMETHOD.
  METHOD class_constructor.
    itab = VALUE #( FOR j = 1 UNTIL j > 10 ( j ) ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
