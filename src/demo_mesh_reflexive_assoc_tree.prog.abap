REPORT demo_mesh_reflexive_assoc_tree.

* Compare with DEMO_MESH_REFLEXIVE_ASSOC_SNGL,
* where no nested FOR is needed, productive usage
* in CL_ABAP_DOCU_TREE=>GET_SUBTREE_OBJECTS

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS:
      main,
      class_constructor.
  PRIVATE SECTION.
    TYPES:
      BEGIN OF line,
        idx       TYPE abapdocu_tree-tab_index,
        id        TYPE abapdocu_tree-node_key,
        parent_id TYPE abapdocu_tree-relatkey,
      END OF line,
      t_itab TYPE STANDARD TABLE OF line WITH NON-UNIQUE KEY id
             WITH NON-UNIQUE SORTED KEY by_parent COMPONENTS parent_id,
      BEGIN OF MESH t_mesh,
        node TYPE t_itab
         ASSOCIATION to_node TO node ON parent_id = id
                     USING KEY by_parent,
      END OF MESH t_mesh.
    CLASS-DATA
      mesh TYPE t_mesh.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA(parent) = `ABENABAP_SYNTAX`.
    cl_demo_input=>request( CHANGING field = parent ).

    DATA(out) = cl_demo_output=>new(
      )->begin_section( 'IN node' ).
    DATA(result0) = VALUE t_itab(
      FOR <root> IN mesh-node USING KEY by_parent
                              WHERE ( parent_id = parent )
      FOR <node> IN mesh-node WHERE ( parent_id = <root>-id )
            ( <node> ) )  ##PRIMKEY[BY_PARENT].
    out->write( result0 ).

    out->next_section( 'IN \to_node' ).
    DATA(result1) = VALUE t_itab(
      FOR <root> IN mesh-node USING KEY by_parent
                              WHERE ( parent_id = parent )
      FOR <node> IN mesh-node\to_node[ <root> ]
            ( <node> ) ).
    out->write( result1 ).

    out->next_section( 'IN \to_node+' ).
    DATA(result2) = VALUE t_itab(
      FOR <root> IN mesh-node USING KEY by_parent
                              WHERE ( parent_id = parent )
      FOR <node> IN mesh-node\to_node+[ <root> ]
            ( <node> ) ).
    out->write( result2 ).

    out->next_section( 'IN \to_node*' ).
    DATA(result3) = VALUE t_itab(
      FOR <root> IN mesh-node USING KEY by_parent
                              WHERE ( parent_id = parent )
      FOR <node> IN mesh-node\to_node*[ <root> ]
            ( <node> ) ) ##PRIMKEY[BY_PARENT].
    out->write( result3 ).

    out->display( ).
  ENDMETHOD.
  METHOD class_constructor.
    SELECT tab_index AS idx, node_key AS id, relatkey AS parent_id
           FROM abapdocu_tree
           WHERE tab_index > 0
           ORDER BY tab_index
           INTO TABLE @mesh-node.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
