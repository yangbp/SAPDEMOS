REPORT demo_loop_at_group_syntax.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
  PRIVATE SECTION.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA(out) = cl_demo_output=>new( ).

    TYPES:
      BEGIN OF struct,
        key1 TYPE string,
        key2 TYPE string,
        col  TYPE i,
      END OF struct,
      itab TYPE STANDARD TABLE OF struct WITH EMPTY KEY.

    DATA(itab) = VALUE itab(
      ( key1 = `a` key2 = `a` col = 1 )
      ( key1 = `a` key2 = `b` col = 2 )
      ( key1 = `a` key2 = `a` col = 3 )
      ( key1 = `a` key2 = `a` col = 4 )
      ( key1 = `a` key2 = `b` col = 5 )
      ( key1 = `b` key2 = `a` col = 6 )
      ( key1 = `b` key2 = `a` col = 7 )  ).

    DATA members TYPE itab.

    out->begin_section( `Representative Binding`
      )->begin_section( `INTO wa` ).
    LOOP AT itab INTO DATA(wa)
                 GROUP BY ( key1 = wa-key1 key2 = wa-key2 ).
      DATA(idx) = sy-tabix.
      CLEAR members.
      out->begin_section( |Group { idx }| ).
      LOOP AT GROUP wa INTO DATA(member).
        members = VALUE #( BASE members ( member ) ).
      ENDLOOP.
      out->write( members )->end_section( ).
    ENDLOOP.
    out->next_section( `ASSIGNING <fs>` ).
    LOOP AT itab ASSIGNING FIELD-SYMBOL(<fs>)
                 GROUP BY ( key1 = <fs>-key1 key2 = <fs>-key2 ).
      idx = sy-tabix.
      CLEAR members.
      out->begin_section( |Group { idx }| ).
      LOOP AT GROUP <fs> INTO member.
        members = VALUE #( BASE members ( member ) ).
      ENDLOOP.
      out->write( members )->end_section( ).
    ENDLOOP.
    out->next_section( `REFERENCE INTO dref` ).
    LOOP AT itab REFERENCE INTO DATA(dref)
                 GROUP BY ( key1 = dref->key1 key2 = dref->key2 ).
      idx = sy-tabix.
      CLEAR members.
      out->begin_section( |Group { idx }| ).
      LOOP AT GROUP dref INTO member.
        members = VALUE #( BASE members ( member ) ).
      ENDLOOP.
      out->write( members )->end_section( ).
    ENDLOOP.
    out->end_section( )->end_section( ).

    out->begin_section( `Group Key Binding`
      )->begin_section( `INTO group` ).
    LOOP AT itab ASSIGNING <fs>
                 GROUP BY ( key1 = <fs>-key1 key2 = <fs>-key2 )
                 INTO DATA(group).
      idx = sy-tabix.
      CLEAR members.
      out->begin_section(
        |Group { idx }, Key { group-key1 } { group-key2 }| ).
      LOOP AT GROUP group INTO member.
        members = VALUE #( BASE members ( member ) ).
      ENDLOOP.
      out->write( members )->end_section( ).
    ENDLOOP.
    out->next_section( `ASSIGNING <group>` ).
    LOOP AT itab ASSIGNING <fs>
                 GROUP BY ( key1 = <fs>-key1 key2 = <fs>-key2 )
                 ASSIGNING FIELD-SYMBOL(<group>).
      idx = sy-tabix.
      CLEAR members.
      out->begin_section(
        |Group { idx }, Key { <group>-key1 } { <group>-key2 }| ).
      LOOP AT GROUP <group> INTO member.
        members = VALUE #( BASE members ( member ) ).
      ENDLOOP.
      out->write( members )->end_section( ).
    ENDLOOP.
    out->next_section( `REFERENCE INTO group_ref` ).
    LOOP AT itab ASSIGNING <fs>
                 GROUP BY ( key1 = <fs>-key1 key2 = <fs>-key2 )
                 REFERENCE INTO DATA(group_ref).
      idx = sy-tabix.
      CLEAR members.
      out->begin_section(
        |Group { idx }, Key { group_ref->key1 } { group_ref->key2 }| ).
      LOOP AT GROUP group_ref INTO member.
        members = VALUE #( BASE members ( member ) ).
      ENDLOOP.
      out->write( members )->end_section( ).
    ENDLOOP.

    out->display( ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
