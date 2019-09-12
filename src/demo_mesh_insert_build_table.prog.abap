REPORT demo_mesh_insert_build_table.

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
      BEGIN OF MESH t_mesh,
        node1 TYPE t_itab1
          ASSOCIATION _node2 TO node2 ON col1 = col1,
        node2 TYPE t_itab2,
      END OF MESH t_mesh.
    CLASS-DATA
      mesh TYPE t_mesh.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA(out) = cl_demo_output=>new(
      )->begin_section( 'node1'
      )->write( mesh-node1 ).

    out->next_section(
      'Building node2 from node1\_node2' ).
    DO lines( mesh-node1 ) TIMES.
      INSERT VALUE line2( col2 = 20 + sy-index ) INTO TABLE
        mesh-node1\_node2[ mesh-node1[ sy-index ] ].
    ENDDO.
    out->write( mesh-node2 ).

    out->display( ).
  ENDMETHOD.
  METHOD class_constructor.
    mesh-node1 = VALUE #(
      ( col1 = 11  )
      ( col1 = 12  )
      ( col1 = 13  ) ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
