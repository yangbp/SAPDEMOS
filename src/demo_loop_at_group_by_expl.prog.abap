REPORT demo_loop_at_group_by_expl.

CLASS demo_group_by DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS:
      class_constructor,
      main.
  PRIVATE SECTION.
    CLASS-DATA:
      numbers TYPE TABLE OF i WITH EMPTY KEY,
      out     TYPE REF TO if_demo_output,
      limit1  TYPE i VALUE 3,
      limit2  TYPE i VALUE 6.
    CLASS-METHODS:
      group_explicit,
      group_by.
ENDCLASS.

CLASS demo_group_by IMPLEMENTATION.
  METHOD class_constructor.
    numbers = VALUE #( FOR j = 1 UNTIL j > 10 ( j ) ).
  ENDMETHOD.
  METHOD main.
    out = cl_demo_output=>new( ).

    group_explicit( ).
    group_by( ).

    out->display( ).
  ENDMETHOD.
  METHOD group_explicit.
    TYPES:
      BEGIN OF helper_struc,
        key  TYPE string,
        refs TYPE STANDARD TABLE OF REF TO i WITH EMPTY KEY,
      END OF helper_struc,
      helper_tab TYPE STANDARD TABLE OF helper_struc WITH EMPTY KEY.

    DATA(helper_tab) = VALUE helper_tab(
     ( key = |below|   )
     ( key = |between| )
     ( key = |above|   ) ).

    out->next_section( 'Group Explicit' ).

    "Grouping
    LOOP AT numbers REFERENCE INTO DATA(dref).
      IF dref->* < limit1.
        ASSIGN helper_tab[ key = |below| ]-refs to FIELD-SYMBOL(<fs>).
        INSERT dref INTO TABLE <fs>.
      ELSEIF dref->* <= limit2.
        ASSIGN helper_tab[ key = |between| ]-refs to <fs>.
        INSERT dref INTO TABLE <fs>.
      ELSE.
        ASSIGN helper_tab[ key = |above| ]-refs to <fs>.
        INSERT dref INTO TABLE <fs>.
      ENDIF.
    ENDLOOP.

    "Group loop
    DATA members LIKE numbers.
    LOOP AT helper_tab INTO DATA(helper_struc).
      out->begin_section( helper_struc-key ).
      members = VALUE #( FOR m IN helper_struc-refs ( m->* ) ).
      out->write( members )->end_section( ).
    ENDLOOP.

  ENDMETHOD.
  METHOD group_by.
    out->next_section( 'Group By' ).

    DATA members LIKE numbers.
    LOOP AT numbers INTO DATA(number)
         GROUP BY COND string(
           WHEN number <  limit1 THEN |below|
           WHEN number <= limit2 THEN |between|
           ELSE |above| )
         INTO DATA(group).
      out->begin_section( group ).
      members = VALUE #( FOR m IN GROUP group ( m ) ).
      out->write( members )->end_section( ).
    ENDLOOP.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo_group_by=>main( ).
