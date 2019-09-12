REPORT demo_for_groups_by_string_func.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS:
      main,
      class_constructor.
  PRIVATE SECTION.
    TYPES
      text_tab TYPE STANDARD TABLE OF string WITH EMPTY KEY.
    CLASS-DATA
      text TYPE text_tab.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA out TYPE REF TO if_demo_output.

    out = REDUCE #(
      INIT o = cl_demo_output=>new(
                 )->begin_section( `Text`
                 )->write( text
                 )->next_section( `Grouping` )
      FOR GROUPS <GROUP> OF LINE IN TEXT
            GROUP BY REPLACE(
                       val = LINE REGEX = `\D` WITH = `` occ =  0 )
            ASCENDING AS TEXT
      LET members = VALUE text_tab(
                      FOR <member> IN GROUP <group> ( <member> ) ) IN
      NEXT o = o->begin_section( |Group Key: { <group> }|
               )->write( members )->end_section( ) ).

    out->display( ).
  ENDMETHOD.
  METHOD class_constructor.
    text = VALUE #( ( `aaa1aaaaa2aaaaa` )
                    ( `bbbbb3bbbbbbbbb` )
                    ( `cccccccccc3cccc` )
                    ( `ddddddddddddddd` )
                    ( `eeeee1eeeeee2ee` )
                    ( `ffff1fff2ff3fff` )
                    ( `ggggggggggggggg` ) ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
