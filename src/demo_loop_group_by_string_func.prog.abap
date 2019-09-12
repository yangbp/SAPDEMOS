REPORT demo_loop_group_by_string_func.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS:
      main,
      class_constructor.
  PRIVATE SECTION.
    CLASS-DATA
      text TYPE TABLE OF string WITH EMPTY KEY.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA(out) = cl_demo_output=>new( ).

    out->begin_section( `Text` ).
    out->write( text ).
    out->next_section( `Grouping` ).
    DATA members LIKE text.
    LOOP AT text INTO DATA(line)
         GROUP BY replace( val = line regex = `\D` with = `` occ =  0 )
                  ASCENDING AS TEXT
                  ASSIGNING FIELD-SYMBOL(<group>).
      out->begin_section( |Group Key: { <group> }| ).
      CLEAR members.
      LOOP AT GROUP <group> ASSIGNING FIELD-SYMBOL(<member>).
        members = VALUE #( BASE members ( <member> ) ).
      ENDLOOP.
      out->write( members )->end_section( ).
    ENDLOOP.

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
