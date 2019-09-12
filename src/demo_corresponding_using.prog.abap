REPORT demo_corresponding_using.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS:
      main,
      class_constructor.
  PRIVATE SECTION.
    TYPES:
      BEGIN OF struct1,
        a1 TYPE string,
        a2 TYPE string,
        b1 TYPE string,
        b2 TYPE string,
        c1 TYPE string,
        c2 TYPE string,
      END OF struct1,
      BEGIN OF struct2,
        a1 TYPE string,
        a2 TYPE string,
        b1 TYPE string,
        b2 TYPE string,
        c1 TYPE string,
        d2 TYPE string,
      END OF struct2,
      BEGIN OF struct3,
        u1 TYPE string,
        u2 TYPE string,
        v1 TYPE string,
        v2 TYPE string,
        w1 TYPE string,
        w2 TYPE string,
      END OF struct3.
    CLASS-DATA:
      itab TYPE STANDARD TABLE OF struct1,
      lookup_tab TYPE STANDARD TABLE OF struct2
                 WITH NON-UNIQUE SORTED KEY mkey COMPONENTS b1 b2,
      jtab TYPE STANDARD TABLE OF struct3.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA(out) = cl_demo_output=>new( ).

    out->begin_section( `itab`
      )->write( itab ).

    out->next_section(
      `lookup_tab`
      )->write( lookup_tab ).

    itab = CORRESPONDING #(
              itab FROM lookup_tab
                   USING KEY mkey b1 = a1 b2 = a2 ).
    out->next_section(
      `itab = CORRESPONDING #( itab FROM lookup_tab USING ... )`
      )->write( itab ).

    itab = CORRESPONDING #(
              itab FROM lookup_tab
                   USING KEY mkey b1 = a1 b2 = a2
                   MAPPING a1 = a1 a2 = a2 b1 = b1 b2 = b2 c2 = d2 ).
    out->next_section(
    `itab = CORRESPONDING #( itab FROM lookup_tab ` &&
                                 `USING ... MAPPING ... )`
      )->write( itab ).

    jtab = CORRESPONDING #(
             itab FROM lookup_tab
                  USING KEY mkey b1 = a1 b2 = a2 ) ##operator.
    out->next_section(
      `jtab = CORRESPONDING #( itab FROM lookup_tab USING ... )`
      )->write( jtab ).

    out->display( ).
  ENDMETHOD.
  METHOD class_constructor.
    itab = VALUE #(
      ( a1 = `id1_1` a2 = `id2_1`
        b1 = `000`   b2 = `000`
        c1 = `000`   c2 = `000` )
      ( a1 = `id1_2` a2 = `id2_2`
        b1 = `000`   b2 = `000`
        c1 = `000`   c2 = `000` )
      ( a1 = `id1_3` a2 = `id2_3`
        b1 = `000`   b2 = `000`
        c1 = `000`   c2 = `000` ) ).
    lookup_tab = VALUE #(
      ( a1 = `a_11`  a2 = `a_12`
        b1 = `id1_1` b2 = `id2_1`
        c1 = `c_11`  d2 = `d_12` )
      ( a1 = `a_21`  a2 = `a_22`
        b1 = `id1_3` b2 = `id2_3`
        c1 = `c_21`  d2 = `d_22` ) ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
