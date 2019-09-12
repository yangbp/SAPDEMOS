REPORT demo_joins NO STANDARD PAGE HEADING.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS: class_constructor,
      main.
  PRIVATE SECTION.
    TYPES: wa1 TYPE demo_join1,
           wa2 TYPE demo_join2.
    TYPES BEGIN OF wa.
    INCLUDE TYPE wa1 AS wa1 RENAMING WITH SUFFIX 1.
    INCLUDE TYPE wa2 AS wa2 RENAMING WITH SUFFIX 2.
    TYPES END OF wa.
    CLASS-DATA out TYPE REF TO if_demo_output.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA: itab  TYPE TABLE OF wa,
          itabi LIKE itab,
          itab1 LIKE itab,
          itab2 LIKE itab,
          itab3 LIKE itab.
    out->begin_section( `Inner Joins`
      )->begin_section( `demo1 INNER JOIN demo2` ).
    SELECT FROM demo_join1 AS t1
             INNER JOIN demo_join2 AS t2 ON t2~d = t1~d
           FIELDS t1~a AS a1,
                  t1~b AS b1,
                  t1~c AS c1,
                  t1~d AS d1,
                  t2~d AS d2,
                  t2~e AS e2,
                  t2~f AS f2,
                  t2~g AS g2,
                  t2~h AS h2
           ORDER BY t1~d
           INTO CORRESPONDING FIELDS OF TABLE @itab.
    itabi = itab.
    out->write( itab
      )->next_section( `demo2 INNER JOIN demo1` ).
    SELECT FROM demo_join2 AS t2
             INNER JOIN demo_join1 AS t1 ON t1~d = t2~d
           FIELDS t1~a AS a1,
                  t1~b AS b1,
                  t1~c AS c1,
                  t1~d AS d1,
                  t2~d AS d2,
                  t2~e AS e2,
                  t2~f AS f2,
                  t2~g AS g2,
                  t2~h AS h2
           ORDER BY t1~d
           INTO CORRESPONDING FIELDS OF TABLE @itab.
    out->write( itab
      )->end_section(
      )->next_section( `Outer Joins`
      )->begin_section( `demo1 LEFT OUTER JOIN demo2` ).
    SELECT FROM demo_join1 AS t1
             LEFT OUTER JOIN demo_join2 AS t2 ON t2~d = t1~d
           FIELDS t1~a AS a1,
                  t1~b AS b1,
                  t1~c AS c1,
                  t1~d AS d1,
                  t2~d AS d2,
                  t2~e AS e2,
                  t2~f AS f2,
                  t2~g AS g2,
                  t2~h AS h2
           ORDER BY t1~d
           INTO CORRESPONDING FIELDS OF TABLE @itab.
    out->write( itab
      )->next_section( `demo2 LEFT OUTER JOIN demo1` ).
    SELECT FROM demo_join2 AS t2
             LEFT OUTER JOIN demo_join1 AS t1 ON t1~d = t2~d
           FIELDS t1~a AS a1,
                  t1~b AS b1,
                  t1~c AS c1,
                  t1~d AS d1,
                  t2~d AS d2,
                  t2~e AS e2,
                  t2~f AS f2,
                  t2~g AS g2,
                  t2~h AS h2
           ORDER BY t1~d
           INTO CORRESPONDING FIELDS OF TABLE @itab.
    out->write( itab
      )->end_section(
      )->begin_section( `demo1 RIGHT OUTER JOIN demo2` ).
    SELECT FROM demo_join1 AS t1
             RIGHT OUTER JOIN demo_join2 AS t2 ON t2~d = t1~d
           FIELDS t1~a AS a1,
                  t1~b AS b1,
                  t1~c AS c1,
                  t1~d AS d1,
                  t2~d AS d2,
                  t2~e AS e2,
                  t2~f AS f2,
                  t2~g AS g2,
                  t2~h AS h2
          ORDER BY t1~d
           INTO CORRESPONDING FIELDS OF TABLE @itab.
    out->write( itab
      )->next_section( `demo2 RIGHT OUTER JOIN demo1` ).
    SELECT FROM demo_join2 AS t2
             RIGHT OUTER JOIN demo_join1 AS t1 ON t1~d = t2~d
           FIELDS t1~a AS a1,
                  t1~b AS b1,
                  t1~c AS c1,
                  t1~d AS d1,
                  t2~d AS d2,
                  t2~e AS e2,
                  t2~f AS f2,
                  t2~g AS g2,
                  t2~h AS h2
           ORDER BY t1~d
           INTO CORRESPONDING FIELDS OF TABLE @itab.
    out->write( itab
      )->end_section(
      )->next_section( `Cross Joins`
      )->begin_section( `demo2 CROSS JOIN demo1` ).
    SELECT FROM demo_join2 AS t2
             INNER JOIN demo_join1 AS t1 ON 1 = 1
           FIELDS t1~a AS a1,
                  t1~b AS b1,
                  t1~c AS c1,
                  t1~d AS d1,
                  t2~d AS d2,
                  t2~e AS e2,
                  t2~f AS f2,
                  t2~g AS g2,
                  t2~h AS h2
           ORDER BY t1~a,
                    t1~b,
                    t1~c,
                    t1~d,
                    t2~d,
                    t2~e,
                    t2~f,
                    t2~g,
                    t2~h
           INTO CORRESPONDING FIELDS OF TABLE @itab1.
    SELECT FROM demo_join2 AS t2
             LEFT OUTER JOIN demo_join1 AS t1 ON 1 = 1
           FIELDS t1~a AS a1,
                  t1~b AS b1,
                  t1~c AS c1,
                  t1~d AS d1,
                  t2~d AS d2,
                  t2~e AS e2,
                  t2~f AS f2,
                  t2~g AS g2,
                  t2~h AS h2
           ORDER BY t1~a,
                    t1~b,
                    t1~c,
                    t1~d,
                    t2~d,
                    t2~e,
                    t2~f,
                    t2~g,
                    t2~h
           INTO CORRESPONDING FIELDS OF TABLE @itab2.
    SELECT FROM demo_join2 AS t2
             RIGHT OUTER JOIN demo_join1 AS t1 ON 1 = 1
           FIELDS t1~a AS a1,
                  t1~b AS b1,
                  t1~c AS c1,
                  t1~d AS d1,
                  t2~d AS d2,
                  t2~e AS e2,
                  t2~f AS f2,
                  t2~g AS g2,
                  t2~h AS h2
           ORDER BY t1~a,
                    t1~b,
                    t1~c,
                    t1~d,
                    t2~d,
                    t2~e,
                    t2~f,
                    t2~g,
                    t2~h
           INTO CORRESPONDING FIELDS OF TABLE @itab3.
    SELECT FROM demo_join2 AS t2
             CROSS JOIN demo_join1 AS t1
           FIELDS t1~a AS a1,
                  t1~b AS b1,
                  t1~c AS c1,
                  t1~d AS d1,
                  t2~d AS d2,
                  t2~e AS e2,
                  t2~f AS f2,
                  t2~g AS g2,
                  t2~h AS h2
           ORDER BY t1~a,
                    t1~b,
                    t1~c,
                    t1~d,
                    t2~d,
                    t2~e,
                    t2~f,
                    t2~g,
                    t2~h
           INTO CORRESPONDING FIELDS OF TABLE @itab.
    ASSERT itab = itab1.
    ASSERT itab = itab2.
    ASSERT itab = itab3.
    out->write( itab
      )->next_section( `demo1 CROSS JOIN demo2` ).
    SELECT FROM demo_join1 AS t1
             CROSS JOIN demo_join2 AS t2
           FIELDS t1~a AS a1,
                  t1~b AS b1,
                  t1~c AS c1,
                  t1~d AS d1,
                  t2~d AS d2,
                  t2~e AS e2,
                  t2~f AS f2,
                  t2~g AS g2,
                  t2~h AS h2
           ORDER BY t1~a,
                    t1~b,
                    t1~c,
                    t1~d,
                    t2~d,
                    t2~e,
                    t2~f,
                    t2~g,
                    t2~h
           INTO CORRESPONDING FIELDS OF TABLE @itab.
    ASSERT itab = itab1.
    ASSERT itab = itab2.
    ASSERT itab = itab3.
    out->write( itab
      )->next_section( `demo1 CROSS JOIN demo2 WHERE ...` ).
    SELECT FROM demo_join1 AS t1
             CROSS JOIN demo_join2 AS t2
           FIELDS t1~a AS a1,
                  t1~b AS b1,
                  t1~c AS c1,
                  t1~d AS d1,
                  t2~d AS d2,
                  t2~e AS e2,
                  t2~f AS f2,
                  t2~g AS g2,
                  t2~h AS h2
           WHERE t2~d = t1~d
           ORDER BY t1~d
           INTO CORRESPONDING FIELDS OF TABLE @itab.
    ASSERT itab = itabi.
    out->display( itab ).
  ENDMETHOD.
  METHOD class_constructor.
    out = cl_demo_output=>new( )->begin_section( `Database Tables` ).
    DELETE FROM demo_join1.
    INSERT demo_join1 FROM TABLE @( VALUE #(
      ( a = 'a1' b = 'b1' c = 'c1'  d = 'uu' )
      ( a = 'a2' b = 'b2' c = 'c2'  d = 'uu' )
      ( a = 'a3' b = 'b3' c = 'c3'  d = 'vv' )
      ( a = 'a4' b = 'b4' c = 'c4'  d = 'ww' ) ) ).
    SELECT * FROM demo_join1 INTO TABLE @DATA(itab1).
    DELETE FROM demo_join2.
    INSERT demo_join2 FROM TABLE @( VALUE #(
      ( d = 'uu' e = 'e1' f = 'f1'  g = 'g1'  h = 'h1' )
      ( d = 'ww' e = 'e2' f = 'f2'  g = 'g2'  h = 'h2' )
      ( d = 'xx' e = 'e3' f = 'f3'  g = 'g3'  h = 'h3' ) ) ).
    SELECT * FROM demo_join2 INTO TABLE @DATA(itab2).
    out->begin_section( `demo1`
      )->write( itab1
      )->next_section( `demo2`
      )->write( itab2
      )->end_section(
      )->end_section( ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
