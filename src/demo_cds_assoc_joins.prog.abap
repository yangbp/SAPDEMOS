REPORT demo_cds_assoc_joins.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS:
      class_constructor,
      main.
  PRIVATE SECTION.
    TYPES: wa1 TYPE demo_join1,
           wa2 TYPE demo_join2,
           wa3 TYPE demo_join3.
    TYPES BEGIN OF wa.
    INCLUDE TYPE wa1 AS wa1 RENAMING WITH SUFFIX _1.
    INCLUDE TYPE wa2 AS wa2 RENAMING WITH SUFFIX _2.
    INCLUDE TYPE wa3 AS wa3 RENAMING WITH SUFFIX _3.
    TYPES END OF wa.
    CLASS-DATA out TYPE REF TO if_demo_output.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA:
      path_outer TYPE TABLE OF demo_cds_assoc_join1_o WITH DEFAULT KEY,
      path_inner TYPE TABLE OF demo_cds_assoc_join1_i WITH DEFAULT KEY,
      join_outer TYPE TABLE OF wa WITH DEFAULT KEY,
      join_inner TYPE TABLE OF wa WITH DEFAULT KEY.
    out->begin_section( 'CDS Views'
      )->begin_section( 'Path with [left outer]' ).
    SELECT *
           FROM demo_cds_assoc_join1_o
           INTO TABLE @path_outer.
    SORT path_outer.
    out->write( path_outer
      )->next_section( 'Path with [inner]' ).
    SELECT *
           FROM demo_cds_assoc_join1_i
           INTO TABLE @path_inner.
    SORT path_inner.
    out->write( path_inner
      )->end_section( )->end_section(
      )->begin_section( `Open SQL Joins`
      )->begin_section(
        `demo1 LEFT OUTER JOIN demo2 LEFT OUTER JOIN demo3` ).
    SELECT FROM
             demo_join1 AS t1
               LEFT OUTER JOIN
                 demo_join2 AS t2 ON t2~d = t1~d
                     LEFT OUTER JOIN
                       demo_join3 AS t3 ON t3~l = t2~d
           FIELDS t1~a AS a_1,
                  t1~b AS b_1,
                  t1~c AS c_1,
                  t1~d AS d_1,
                  t2~d AS d_2,
                  t2~e AS e_2,
                  t2~f AS f_2,
                  t2~g AS g_2,
                  t2~h AS h_2,
                  t3~i AS i_3,
                  t3~j AS j_3,
                  t3~k AS k_3,
                  t3~l AS l_3
           INTO CORRESPONDING FIELDS OF TABLE @join_outer.
    SORT join_outer.
    out->write( join_outer
      )->next_section( `demo1 INNER JOIN demo2 INNER JOIN demo3` ).
    SELECT FROM
             demo_join1 AS t1
               INNER JOIN
                 demo_join2 AS t2 ON t2~d = t1~d
                     INNER JOIN
                       demo_join3 AS t3 ON t3~l = t2~d
           FIELDS t1~a AS a_1,
                  t1~b AS b_1,
                  t1~c AS c_1,
                  t1~d AS d_1,
                  t2~d AS d_2,
                  t2~e AS e_2,
                  t2~f AS f_2,
                  t2~g AS g_2,
                  t2~h AS h_2,
                  t3~i AS i_3,
                  t3~j AS j_3,
                  t3~k AS k_3,
                  t3~l AS l_3
           INTO CORRESPONDING FIELDS OF TABLE @join_inner.
    SORT join_inner.
    out->write( join_inner )->display( ).
    ASSERT path_inner = join_inner.
    ASSERT path_outer = join_outer.
  ENDMETHOD.
  METHOD class_constructor.
    out = cl_demo_output=>new( )->begin_section( `Database Tables` ).
    DELETE FROM demo_join1.
    INSERT demo_join1 FROM TABLE @( VALUE #(
      ( a = 'a1' b = 'b1' c = 'c1' d = 'uu' )
      ( a = 'a2' b = 'b2' c = 'c2' d = 'uu' )
      ( a = 'a3' b = 'b3' c = 'c3' d = 'vv' )
      ( a = 'a4' b = 'b4' c = 'c4' d = 'ww' ) ) ).
    SELECT * FROM demo_join1 INTO TABLE @DATA(itab1).
    DELETE FROM demo_join2.
    INSERT demo_join2 FROM TABLE @( VALUE #(
      ( d = 'uu' e = 'e1' f = 'f1' g = 'g1'  h = 'h1' )
      ( d = 'ww' e = 'e2' f = 'f2' g = 'g2'  h = 'h2' )
      ( d = 'xx' e = 'e3' f = 'f3' g = 'g3'  h = 'h3' ) ) ).
    SELECT * FROM demo_join2 INTO TABLE @DATA(itab2).
    DELETE FROM demo_join3.
    INSERT demo_join3 FROM TABLE @( VALUE #(
      ( i = 'i1' j = 'j1' k = 'k1' l = 'vv' )
      ( i = 'i2' j = 'j2' k = 'k2' l = 'vv' )
      ( i = 'i3' j = 'j3' k = 'k3' l = 'ww' ) ) ).
    SELECT * FROM demo_join3 INTO TABLE @DATA(itab3).
    out->begin_section( `demo1`
      )->write( itab1
      )->next_section( `demo2`
      )->write( itab2
      )->next_section( `demo3`
      )->write( itab3
      )->end_section(
      )->end_section( ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
