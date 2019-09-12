REPORT demo_mesh_inverse_assoc.

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
                   WITH UNIQUE KEY col1,
      BEGIN OF line2,
        col1 TYPE i,
        col2 TYPE i,
      END OF line2,
      t_itab2 TYPE SORTED TABLE OF line2
                   WITH UNIQUE KEY col1 col2,
      BEGIN OF line3,
        col1 TYPE i,
        col2 TYPE i,
        col3 TYPE i,
      END OF line3,
      t_itab3 TYPE SORTED TABLE OF line3
                   WITH UNIQUE KEY col1 col2 col3,
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
    DATA(idx) = 1.
    cl_demo_input=>request( CHANGING field = idx ).

    DATA(out) = cl_demo_output=>new(
      )->begin_section( 'node1'
      )->write( mesh-node1
      )->next_section( 'node2'
      )->write( mesh-node2
      )->next_section( 'node3'
      )->write( mesh-node3 ).

    IF line_exists( mesh-node3[ idx ] ).

      out->next_section( 'node3\^_node3~node2'
        )->write( VALUE t_itab2(
           FOR <node2> IN
             mesh-node3\^_node3~node2[ mesh-node3[ idx ] ]
             ( <node2> ) ) ).

      out->next_section( 'node3\^_node3~node2\^_node2~node1'
        )->write( VALUE t_itab1(
           FOR <node1> IN
             mesh-node3\^_node3~node2[ mesh-node3[ idx ]
                                       ]\^_node2~node1[ ]
             ( <node1> ) ) ).
    ELSE.
      out->write( `Enter a valid index for node3 ...` ).
    ENDIF.

    out->display( ).
  ENDMETHOD.
  METHOD class_constructor.
    mesh-node1 = VALUE t_itab1(
      ( col1 = 1 )
      ( col1 = 2 )
      ( col1 = 3 ) ).
    mesh-node2 = VALUE t_itab2(
      ( col1 = 1  col2 = 11 )
      ( col1 = 1  col2 = 12 )
      ( col1 = 2  col2 = 21 )
      ( col1 = 2  col2 = 22 )
      ( col1 = 3  col2 = 31 )
      ( col1 = 3  col2 = 32 ) ).
    mesh-node3 = VALUE t_itab3(
      ( col1 = 1  col2 = 11 col3 = 111 )
      ( col1 = 1  col2 = 11 col3 = 112 )
      ( col1 = 1  col2 = 12 col3 = 121 )
      ( col1 = 1  col2 = 12 col3 = 122 )
      ( col1 = 2  col2 = 21 col3 = 211 )
      ( col1 = 2  col2 = 21 col3 = 212 )
      ( col1 = 2  col2 = 22 col3 = 221 )
      ( col1 = 2  col2 = 22 col3 = 222 )
      ( col1 = 3  col2 = 31 col3 = 311 )
      ( col1 = 3  col2 = 31 col3 = 312 )
      ( col1 = 3  col2 = 32 col3 = 321 )
      ( col1 = 3  col2 = 32 col3 = 322 ) ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
