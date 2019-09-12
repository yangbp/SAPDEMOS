REPORT demo_corresponding_using_self.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS:
      main,
      class_constructor.
  PRIVATE SECTION.
    TYPES:
      BEGIN OF struct,
        node   TYPE string,
        parent TYPE string,
        text   TYPE string,
      END OF struct.
    CLASS-DATA
      itab TYPE HASHED TABLE OF struct
           WITH UNIQUE KEY node.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA(out) = cl_demo_output=>new( ).

    out->begin_section( `itab`
      )->write( itab ).


    itab = CORRESPONDING #(
              itab FROM itab
                   USING node = parent ) ##operator.
    out->next_section(
      `itab = CORRESPONDING #( itab FROM itab USING node = parent )`
      )->write( itab ).

    out->display( ).
  ENDMETHOD.
  METHOD class_constructor.
    itab = VALUE #(
      ( node = `0` parent = `-`  text = `node0`  )
      ( node = `1` parent = `0`  text = `node1` )
      ( node = `2` parent = `1`  text = `node2` )
      ( node = `3` parent = `1`  text = `node3` )
      ( node = `4` parent = `3`  text = `node4` )
      ( node = `5` parent = `3`  text = `node5` )
      ( node = `6` parent = `1`  text = `node6` ) ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
