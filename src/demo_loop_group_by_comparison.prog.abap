REPORT demo_loop_group_by_comparison.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS:
      main,
      class_constructor.
  PRIVATE SECTION.
    CLASS-DATA:
      numbers TYPE TABLE OF i WITH EMPTY KEY.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA(out) = cl_demo_output=>new( ).

    DATA(threshold) = 5.
    cl_demo_input=>request( CHANGING field = threshold ).

    out->begin_section( `Grouping` ).
    DATA members LIKE numbers.
    LOOP AT numbers INTO DATA(number)
         GROUP BY COND string(
           WHEN number <= threshold THEN |LE { threshold }|
                                    ELSE |GT { threshold }| )
         ASSIGNING FIELD-SYMBOL(<group>).
      out->begin_section( <group> ).
      CLEAR members.
      LOOP AT GROUP <group> REFERENCE INTO DATA(member_ref).
        members = VALUE #( BASE members ( member_ref->* ) ).
      ENDLOOP.
      out->write( members )->end_section( ).
    ENDLOOP.
    out->display( ).
  ENDMETHOD.
  METHOD class_constructor.
    numbers = VALUE #( FOR j = 1 UNTIL j > 10 ( j ) ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
