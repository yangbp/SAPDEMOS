REPORT demo_select_union.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS:
      main,
      class_constructor.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA(out) = cl_demo_output=>new( ).

    SELECT a AS c1, b AS c2, c AS c3, d AS c4
           FROM demo_join1
    UNION DISTINCT
    SELECT d AS c1, e AS c2, f AS c3, g AS c4
          FROM demo_join2
    UNION DISTINCT
    SELECT i AS c1, j AS c2, k AS c3, l AS c4
           FROM demo_join3
           INTO TABLE @DATA(result_distinct).
    out->write( result_distinct ).

    SELECT a AS c1, b AS c2, c AS c3, d AS c4
           FROM demo_join1
    UNION ALL
    SELECT d AS c1, e AS c2, f AS c3, g AS c4
          FROM demo_join2
    UNION ALL
    SELECT i AS c1, j AS c2, k AS c3, l AS c4
           FROM demo_join3
           INTO TABLE @DATA(result_all).
    out->write( result_all ).

    SELECT a AS c1, b AS c2, c AS c3, d AS c4
           FROM demo_join1
    UNION ALL
    SELECT d AS c1, e AS c2, f AS c3, g AS c4
          FROM demo_join2
    UNION DISTINCT
    SELECT i AS c1, j AS c2, k AS c3, l AS c4
           FROM demo_join3
           INTO TABLE @DATA(result_all_distinct1).
    out->write( result_all_distinct1 ).

    SELECT a AS c1, b AS c2, c AS c3, d AS c4
           FROM demo_join1
    UNION ALL
    ( SELECT d AS c1, e AS c2, f AS c3, g AS c4
             FROM demo_join2
      UNION DISTINCT
      SELECT i AS c1, j AS c2, k AS c3, l AS c4
            FROM demo_join3 )
            INTO TABLE @DATA(result_all_distinct2).
    out->write( result_all_distinct2 ).

    SELECT a AS c1, b AS c2, c AS c3, d AS c4
           FROM demo_join1
    UNION DISTINCT
    SELECT d AS c1, e AS c2, f AS c3, g AS c4
          FROM demo_join2
    UNION ALL
    SELECT i AS c1, j AS c2, k AS c3, l AS c4
           FROM demo_join3
           INTO TABLE @DATA(result_distinct_all1).
    out->write( result_distinct_all1 ).

    SELECT a AS c1, b AS c2, c AS c3, d AS c4
           FROM demo_join1
    UNION DISTINCT
    ( SELECT d AS c1, e AS c2, f AS c3, g AS c4
            FROM demo_join2
    UNION ALL
    SELECT i AS c1, j AS c2, k AS c3, l AS c4
          FROM demo_join3 )
          INTO TABLE @DATA(result_distinct_all2).
    out->write( result_distinct_all2 ).

    out->display( ).
  ENDMETHOD.
  METHOD class_constructor.
    DELETE FROM demo_join1.
    DELETE FROM demo_join2.
    DELETE FROM demo_join3.
    INSERT demo_join1 FROM TABLE @( VALUE #(
      ( a = 'a1' b = 'b1' c = 'c1' d = 'd1' )
      ( a = 'a2' b = 'b2' c = 'c2' d = 'd2' )
      ( a = 'a3' b = 'b3' c = 'c3' d = 'd3' ) ) ).
    INSERT demo_join2 FROM TABLE @( VALUE #(
      ( d = 'a1' e = 'b1' f = 'c1' g = 'd1' )
      ( d = 'a2' e = 'b2' f = 'c2' g = 'd2' )
      ( d = 'a3' e = 'b3' f = 'c3' g = 'd3' ) ) ).
    INSERT demo_join3 FROM TABLE @( VALUE #(
      ( i = 'a1' j = 'b1' k = 'c1' l = 'd1' )
      ( i = 'i1' j = 'j1' k = 'k1' l = 'l1' )
      ( i = 'i2' j = 'j2' k = 'k2' l = 'l2' ) ) ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
