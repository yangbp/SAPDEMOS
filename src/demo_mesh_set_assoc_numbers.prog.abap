REPORT demo_mesh_set_assoc_numbers.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS:
      main,
      class_constructor.
  PRIVATE SECTION.
    TYPES:
      BEGIN OF line1,
        col1 TYPE i,
        col2 TYPE i,
      END OF line1,
      t_itab1 TYPE SORTED TABLE OF line1
                   WITH NON-UNIQUE KEY col1 col2,
      BEGIN OF line2,
        col1 TYPE i,
        col2 TYPE i,
        col3 TYPE i,
      END OF line2,
      t_itab2 TYPE SORTED TABLE OF line2
                   WITH NON-UNIQUE KEY col1 col2,
      BEGIN OF line3,
        col3 TYPE i,
        col4 TYPE i,
      END OF line3,
      t_itab3 TYPE SORTED TABLE OF line3
                   WITH NON-UNIQUE KEY col3,
      BEGIN OF MESH t_mesh,
        node1 TYPE t_itab1
          ASSOCIATION _node2 TO node2 ON col1 = col1
                                     AND col2 = col2,
        node2 TYPE t_itab2
          ASSOCIATION _node3 TO node3 ON col3 = col3,
        node3 TYPE t_itab3,
      END OF MESH t_mesh.
    CLASS-DATA
      mesh TYPE t_mesh.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA(out) = cl_demo_output=>new(
      )->begin_section( 'node1'
      )->write( mesh-node1
      )->next_section( 'node2'
      )->write( mesh-node2
      )->next_section( 'node3'
      )->write( mesh-node3 ).

    out->next_section( 'Initial Association' ).
    out->begin_section( 'Insert initial line into node1\_node2' ).
    INSERT INITIAL LINE INTO TABLE
      mesh-node1\_node2[ VALUE line1( col1 = 11 col2 = 12 ) ]
      ASSIGNING FIELD-SYMBOL(<line2>).
    out->write( mesh-node2 ).

    out->next_section( 'Set association node2\_node3' ).
    SET ASSOCIATION mesh-node2\_node3[ <line2> ] = mesh-node3[ 1 ].
    out->write( mesh-node2 ).

    out->next_section( 'Get association node2\_node3' ).
    DATA(line3) = mesh-node2\_node3[ <line2> ].
    out->write( line3 )->end_section( ).

    out->next_section( 'Chained Association' ).
    out->begin_section( 'Set association node1\_node2\_node3' ).
    DATA(root) = VALUE line1( col1 = 21 col2 = 22 ).
    SET ASSOCIATION
      mesh-node1\_node2[ root ]\_node3[ ] = mesh-node3[ 2 ].
    out->write( mesh-node2 ).

    out->next_section( 'Get association node1\node2\_node3' ).
    DATA(node3) = VALUE t_itab3( FOR wa IN
      mesh-node1\_node2[ root ]\_node3[ ] ( wa ) ).
    out->write( node3 ).

    out->display( ).
  ENDMETHOD.
  METHOD class_constructor.
    mesh-node1 = VALUE #(
      ( col1 = 11 col2 = 12 )
      ( col1 = 21 col2 = 22 ) ).
    mesh-node2 = VALUE #(
      ( col1 = 21 col2 = 22 )
      ( col1 = 21 col2 = 22 ) ).
    mesh-node3 = VALUE #(
      ( col3 = 13 col4 = 14 )
      ( col3 = 23 col4 = 24 ) ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
