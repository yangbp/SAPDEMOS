REPORT demo_corresponding_class_lkup.

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
      END OF struct2.
    CLASS-DATA:
      itab       TYPE STANDARD TABLE OF struct1,
      lookup_tab TYPE SORTED TABLE OF struct2
                 WITH NON-UNIQUE KEY  b1 b2.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA(out) = cl_demo_output=>new( ).

    out->begin_section( `itab`
      )->write( itab ).

    out->next_section(
      `lookup_tab`
      )->write( lookup_tab ).

    DATA(mapping_tab) = VALUE cl_abap_corresponding=>mapping_table(
      ( level = 0 kind = 4 srcname = 'PRIMARY_KEY' )
      ( level = 0 kind = 5 srcname = 'B1' dstname = 'A1' )
      ( level = 0 kind = 5 srcname = 'B2' dstname = 'A2' ) ).
    cl_abap_corresponding=>create_using(
      destination       = itab
      using             = lookup_tab
      mapping           = mapping_tab
      )->execute_using( EXPORTING using       = lookup_tab
                        CHANGING  destination = itab ).
    out->next_section(
      `CL_ABAP_CORRESPONDING=>EXECUTE_USING without mapping`
      )->write( itab ).

    mapping_tab = VALUE cl_abap_corresponding=>mapping_table(
       ( level = 0 kind = 4 srcname = 'PRIMARY_KEY' )
       ( level = 0 kind = 5 srcname = 'B1' dstname = 'A1' )
       ( level = 0 kind = 5 srcname = 'B2' dstname = 'A2' )
       ( level = 0 kind = 1 srcname = 'A1' dstname = 'A1' )
       ( level = 0 kind = 1 srcname = 'A2' dstname = 'A2' )
       ( level = 0 kind = 1 srcname = 'B1' dstname = 'B1' )
       ( level = 0 kind = 1 srcname = 'B2' dstname = 'B2' )
       ( level = 0 kind = 1 srcname = 'D2' dstname = 'C2' )  ).
    cl_abap_corresponding=>create_using(
      destination       = itab
      using             = lookup_tab
      mapping           = mapping_tab
      )->execute_using( EXPORTING using       = lookup_tab
                        CHANGING  destination = itab ).
    out->next_section(
    `CL_ABAP_CORRESPONDING=>EXECUTE_USING with mapping`
      )->write( itab ).

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
