REPORT demo_mesh_insert_numbers.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS:
      main,
      class_constructor.
  PRIVATE SECTION.
    TYPES:
      BEGIN OF line1,
        col1 TYPE i,
      END OF line1,
      t_itab1 TYPE SORTED TABLE OF line1
                   WITH NON-UNIQUE KEY col1,
      BEGIN OF line2,
        col1 TYPE i,
        col2 TYPE i,
      END OF line2,
      t_itab2 TYPE SORTED TABLE OF line2
                   WITH NON-UNIQUE KEY col1 col2,
      BEGIN OF line3,
        col1 TYPE i,
        col2 TYPE i,
        col3 TYPE i,
      END OF line3,
      t_itab3 TYPE SORTED TABLE OF line3
                   WITH NON-UNIQUE KEY col1 col2 col3,
      BEGIN OF MESH t_mesh,
        node1 TYPE t_itab1
          ASSOCIATION _node2 TO node2 ON col1 = col1,
        node2 TYPE t_itab2
          ASSOCIATION _node3 TO node3 ON col1 = col1
                                     AND col2 = col2,
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

    out->next_section(
      'Inserting One Line Into node1\_node2' ).
    INSERT VALUE line2( col2 = 3333 ) INTO TABLE
      mesh-node1\_node2[ mesh-node1[ 1 ] ].
    out->write( mesh-node2 ).

    out->next_section(
      'Inserting Multiple Lines Into node1\_node2' ).
    INSERT LINES OF VALUE t_itab2( ( col2 = 1 )
                                   ( col2 = 2 )
                                   ( col2 = 3 ) ) INTO TABLE
      mesh-node1\_node2[ mesh-node1[ 2 ] ].
    out->write( mesh-node2 ).

    out->next_section(
      'Inserting Initial Lines Into node1\_node2\_node3' ).
    INSERT INITIAL LINE INTO TABLE
      mesh-node1\_node2[ mesh-node1[ 3 ] ]\_node3[ ].
    out->write( mesh-node3 ).

    out->next_section(
      'Inserting  Multiple Lines Into node1\_node2\_node3' ).
    INSERT LINES OF VALUE t_itab3( ( col3 = 10 )
                                   ( col3 = 20 )
                                   ( col3 = 30 ) ) INTO TABLE
      mesh-node1\_node2[ mesh-node1[ 3 ] ]\_node3[ ].
    out->write( mesh-node3 ).

    out->display( ).
  ENDMETHOD.
  METHOD class_constructor.
    mesh-node1 = VALUE #(
      ( col1 = 11  )
      ( col1 = 12  )
      ( col1 = 13  ) ).
    mesh-node2 = VALUE #(
      ( col1 = 11 col2 = 211 )
      ( col1 = 11 col2 = 212 )
      ( col1 = 12 col2 = 221 )
      ( col1 = 12 col2 = 222 )
      ( col1 = 13 col2 = 231 )
      ( col1 = 13 col2 = 232 ) ).
    mesh-node3 = VALUE #(
      ( col1 = 11 col2 = 211 col3 = 311 )
      ( col1 = 11 col2 = 212 col3 = 312 )
      ( col1 = 12 col2 = 221 col3 = 321 )
      ( col1 = 12 col2 = 222 col3 = 322 )
      ( col1 = 13 col2 = 231 col3 = 331 )
      ( col1 = 13 col2 = 232 col3 = 332 ) ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
