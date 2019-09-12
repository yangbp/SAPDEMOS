REPORT demo_mesh_loop_at_numbers.

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
      t_itab1 TYPE STANDARD TABLE OF line1 WITH EMPTY KEY,
      BEGIN OF line2,
        col1 TYPE i,
        col2 TYPE i,
        col3 TYPE i,
      END OF line2,
      t_itab2 TYPE STANDARD TABLE OF line2 WITH EMPTY KEY,
      BEGIN OF line3,
        col1 TYPE i,
        col2 TYPE i,
        col3 TYPE i,
        col4 TYPE i,
      END OF line3,
      t_itab3 TYPE STANDARD TABLE OF line3 WITH EMPTY KEY,
      BEGIN OF MESH t_mesh,
        node1 TYPE t_itab1
          ASSOCIATION to_node2 TO node2 ON col1 = col1
                                       AND col2 = col2,
        node2 TYPE t_itab2
          ASSOCIATION to_node3 TO node3 ON col1 = col1
                                       AND col2 = col2
                                       AND col3 = col3,
        node3 TYPE t_itab3,
      END OF MESH t_mesh.
    CLASS-DATA:
      itab1 TYPE t_itab1,
      itab2 TYPE t_itab2,
      itab3 TYPE t_itab3,
      mesh  TYPE t_mesh.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA(out) = cl_demo_output=>new( ).
    DATA(idx) = 1.
    cl_demo_input=>request( CHANGING field = idx ).

    TRY.
        out->begin_section(
          'Initial Association' ).
        LOOP AT mesh-node1\to_node2[ mesh-node1[ idx ] ]
                INTO DATA(line2).
          out->write( line2 ).
        ENDLOOP.

        out->next_section(
          'Initial Association with WHERE-Condition' ).
        LOOP AT mesh-node1\to_node2[ mesh-node1[ idx ]
                                     WHERE col3 < idx * 100 + 33 ]
             INTO DATA(line1).
          out->write( line1 ).
        ENDLOOP.

        out->next_section(
          'Chained Associations' ).
        out->begin_section(
          'WHERE-Condition in Initial Association' ).
        DATA line3 TYPE LINE OF t_itab3.
        LOOP AT mesh-node1\to_node2[ mesh-node1[ idx ]
                                     WHERE col3 < idx * 100 + 33
                                   ]\to_node3[  ]
             INTO line3.
          out->write( line3 ).
        ENDLOOP.
        out->next_section(
          'WHERE-Condition in Path Prolongation' ).
        LOOP AT mesh-node1\to_node2[ mesh-node1[ idx ]
                                   ]\to_node3[
                                     WHERE col4 > idx * 1000 + 420 ]
            INTO line3.
          out->write( line3 ).
        ENDLOOP.
        out->next_section(
          'WHERE-Condition in both Associations' ).
        LOOP AT mesh-node1\to_node2[ mesh-node1[ idx ]
                                     WHERE col3 < idx * 100 + 33
                                   ]\to_node3[
                                    WHERE col4 > idx * 1000 + 420 ]
             INTO line3.
          out->write( line3 ).
        ENDLOOP.
      CATCH cx_sy_itab_line_not_found.
        out->write( 'Exception!' ).
    ENDTRY.
    out->display( ).
  ENDMETHOD.
  METHOD class_constructor.
    itab1 = VALUE #(
      ( col1 = 11 col2 = 12 )
      ( col1 = 21 col2 = 22 )
      ( col1 = 31 col2 = 32 ) ).

    itab2 = VALUE #( FOR wa1 IN itab1 INDEX INTO idx1
                     LET x = idx1 * 100 + 30 IN
      ( col1 = wa1-col1 col2 = wa1-col2 col3 = x + 1 )
      ( col1 = wa1-col1 col2 = wa1-col2 col3 = x + 2 )
      ( col1 = wa1-col1 col2 = wa1-col2 col3 = x + 3 ) ).

    itab3 = VALUE #(
      FOR wa1 IN itab1 INDEX INTO idx1
      FOR wa2 IN itab2 INDEX INTO idx2
        WHERE ( col1 = wa1-col1 AND col2 = wa1-col2 )
        LET x = idx1 * 1000 + 400 + 10 * ( idx2 - 3 * ( idx1 - 1 ) ) IN
      ( col1 = wa1-col1 col2 = wa1-col2 col3 = wa2-col3 col4 = x + 1 )
      ( col1 = wa1-col1 col2 = wa1-col2 col3 = wa2-col3 col4 = x + 2 )
      ( col1 = wa1-col1 col2 = wa1-col2 col3 = wa2-col3 col4 = x + 3 )
      ).

    mesh = VALUE #(
      node1 = itab1
      node2 = itab2
      node3 = itab3 ).

  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
