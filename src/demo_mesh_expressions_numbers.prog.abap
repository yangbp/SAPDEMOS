REPORT demo_mesh_expressions_numbers.

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
        out->begin_section( 'Forward Association' ).
        DATA(line2) = mesh-node1\to_node2[ mesh-node1[ idx ] ].
        out->write( line2 ).

        out->next_section( 'Inverse Association' ).
        DATA(line1) =
          mesh-node2\^to_node2~node1[ mesh-node2[ idx ] ].
        out->write( line1 ).

        out->next_section( 'Chained Associations' ).
        DATA(line3) =
          mesh-node1\to_node2[ mesh-node1[ idx ] ]\to_node3[  ].
        out->write( line3 ).

        out->next_section( 'Addressing Component' ).
        DATA(comp) =
          mesh-node1\to_node2[ mesh-node1[ idx ] ]\to_node3[ ]-col4.
        out->write( comp ).

        out->next_section( 'Assigning to Field Symbol' ).
        ASSIGN
          mesh-node1\to_node2[ mesh-node1[ idx ]
                             ]\to_node3[ col4 = comp ]
          TO FIELD-SYMBOL(<line3>).
        IF sy-subrc = 0.
          out->write( 'Field symbol OK' ).
        ENDIF.

        out->next_section( 'Write Access and Check Existence' ).
        mesh-node1\to_node2[ mesh-node1[ idx ]
                           ]\to_node3[ ]-col4 = comp + 100.
        IF line_exists(
             mesh-node1\to_node2[ mesh-node1[ idx ]
                                ]\to_node3[ col4 = comp + 100 ] ).
          out->write( 'Line found!' ).
        ENDIF.
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

    itab2 = VALUE #(
      ( col1 = 11 col2 = 12 col3 = 13 )
      ( col1 = 21 col2 = 22 col3 = 23 )
      ( col1 = 31 col2 = 32 col3 = 33 ) ).

    itab3 = VALUE #(
      ( col1 = 11 col2 = 12 col3 = 13 col4 = 14 )
      ( col1 = 21 col2 = 22 col3 = 23 col4 = 24 )
      ( col1 = 31 col2 = 32 col3 = 33 col4 = 34 ) ).

    mesh = VALUE #(
      node1 = itab1
      node2 = itab2
      node3 = itab3 ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
