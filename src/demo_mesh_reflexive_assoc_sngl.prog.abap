REPORT demo_mesh_reflexive_assoc_sngl.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS:
      main,
      class_constructor.
  PRIVATE SECTION.
    TYPES:
      BEGIN OF line,
        id        TYPE i,
        parent_id TYPE i,
        name      TYPE string,
      END OF line,
      t_itab TYPE SORTED TABLE OF line WITH UNIQUE KEY id
             WITH NON-UNIQUE SORTED KEY by_parent COMPONENTS parent_id,
      BEGIN OF MESH t_mesh,
        node TYPE t_itab
             ASSOCIATION _node TO node ON parent_id = id
                         USING KEY by_parent,
      END OF MESH t_mesh.
    CLASS-DATA
      mesh TYPE t_mesh.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA(id) = 1.
    cl_demo_input=>request( CHANGING field = id ).

    DATA(out) = cl_demo_output=>new(
      )->begin_section( 'node'
      )->write( mesh-node ).

    IF line_exists( mesh-node[ id = id ] ).
      out->next_section( '\_node'
        )->write( VALUE t_itab(
           FOR <node> IN mesh-node\_node[ mesh-node[ id = id ] ]
              ( <node> ) ) ).

      out->next_section( '\_node+'
        )->write( VALUE t_itab(
           FOR <node> IN mesh-node\_node+[ mesh-node[ id = id ] ]
              ( <node> ) ) ).

      out->next_section( '\_node*'
        )->write( VALUE t_itab(
           FOR <node> IN mesh-node\_node*[ mesh-node[ id = id ] ]
              ( <node> ) ) ) ##PRIMKEY[BY_PARENT].
    ELSE.
      out->write( `Enter a valid ID ...` ).
    ENDIF.

    out->display( ).
  ENDMETHOD.
  METHOD class_constructor.
    mesh-node = VALUE t_itab(
        ( id = 1  parent_id = 0 name = 'AA'          )
        ( id = 2  parent_id = 1 name = 'AA-AA'       )
        ( id = 3  parent_id = 2 name = 'AA-AA-AA'    )
        ( id = 4  parent_id = 2 name = 'AA-AA-BB'    )
        ( id = 5  parent_id = 1 name = 'AA-BB'       )
        ( id = 6  parent_id = 5 name = 'AA-BB-AA'    )
        ( id = 7  parent_id = 6 name = 'AA-BB-AA-AA' )
        ( id = 8  parent_id = 6 name = 'AA-BB-AA-BB' )
        ( id = 9  parent_id = 5 name = 'AA-BB-BB'    )
        ( id = 10 parent_id = 9 name = 'AA-BB-BB-AA' )
        ( id = 11 parent_id = 1 name = 'AA-CC'       )
        ( id = 12 parent_id = 0 name = 'BB'          )
        ( id = 13 parent_id = 0 name = 'CC'          ) ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
