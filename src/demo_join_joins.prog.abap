REPORT demo_join_joins.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS: class_constructor,
      main.
  PRIVATE SECTION.
    TYPES: wa1 TYPE demo_join1,
           wa2 TYPE demo_join2,
           wa3 TYPE demo_join3,
           wa4 TYPE demo_join4.
    TYPES BEGIN OF wa.
    INCLUDE TYPE wa1 AS wa1 RENAMING WITH SUFFIX 1.
    INCLUDE TYPE wa2 AS wa2 RENAMING WITH SUFFIX 2.
    INCLUDE TYPE wa3 AS wa3 RENAMING WITH SUFFIX 3.
    INCLUDE TYPE wa4 AS wa4 RENAMING WITH SUFFIX 4.
    TYPES END OF wa.
    CLASS-DATA out TYPE REF TO if_demo_output.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA itab TYPE TABLE OF wa WITH DEFAULT KEY.
    DATA jtab LIKE itab.
    out->begin_section( `Joins` ).
    out->begin_section( `1. demo1 INNER JOIN demo2` ).
    SELECT FROM
             demo_join1 AS t1
               INNER JOIN
                 demo_join2 AS t2 ON t2~d = t1~d
           FIELDS t1~a AS a1,
                  t1~b AS b1,
                  t1~c AS c1,
                  t1~d AS d1,
                  t2~d AS d2,
                  t2~e AS e2,
                  t2~f AS f2,
                  t2~g AS g2,
                  t2~h AS h2
           INTO CORRESPONDING FIELDS OF TABLE @itab.
    SORT itab.
    out->write( itab
      )->next_section( `2. demo3 INNER JOIN demo4 ` ).
    SELECT FROM
             demo_join3 AS t3
               INNER JOIN
                 demo_join4 AS t4 ON t4~l = t3~l
           FIELDS t3~i AS i3,
                  t3~j AS j3,
                  t3~k AS k3,
                  t3~l AS l3,
                  t4~l AS l4,
                  t4~m AS m4,
                  t4~n AS n4
           INTO CORRESPONDING FIELDS OF TABLE @itab.
    SORT itab.
    out->write( itab
      )->next_section( `3a. demo1 INNER JOIN demo2 ` &&
                       `LEFT OUTER JOIN demo3` ).
    SELECT FROM
             demo_join1 AS t1
               INNER JOIN
                 demo_join2 AS t2 ON t2~d = t1~d
                     LEFT OUTER JOIN
                       demo_join3 AS t3 ON t3~l = t2~d
           FIELDS t1~a AS a1,
                  t1~b AS b1,
                  t1~c AS c1,
                  t1~d AS d1,
                  t2~d AS d2,
                  t2~e AS e2,
                  t2~f AS f2,
                  t2~g AS g2,
                  t2~h AS h2,
                  t3~i AS i3,
                  t3~j AS j3,
                  t3~k AS k3,
                  t3~l AS l3
           INTO CORRESPONDING FIELDS OF TABLE @itab.
    SORT itab.
    out->write( itab
      )->next_section( `3b. (demo1 INNER JOIN demo2) ` &&
                       `LEFT OUTER JOIN demo3` ).
    SELECT FROM
             ( demo_join1 AS t1
                 INNER JOIN
                   demo_join2 AS t2 ON t2~d = t1~d )
                     LEFT OUTER JOIN
                       demo_join3 AS t3 ON t3~l = t2~d
           FIELDS t1~a AS a1,
                  t1~b AS b1,
                  t1~c AS c1,
                  t1~d AS d1,
                  t2~d AS d2,
                  t2~e AS e2,
                  t2~f AS f2,
                  t2~g AS g2,
                  t2~h AS h2,
                  t3~i AS i3,
                  t3~j AS j3,
                  t3~k AS k3,
                  t3~l AS l3
           INTO CORRESPONDING FIELDS OF TABLE @itab.
    SORT itab.
    out->write( itab
      )->next_section( `4a. demo1 INNER JOIN demo2 ` &&
                       `LEFT OUTER JOIN demo3 INNER JOIN demo4` ).
    SELECT FROM
             demo_join1 AS t1
               INNER JOIN
                 demo_join2 AS t2 ON t2~d = t1~d
                   LEFT OUTER JOIN
                     demo_join3 AS t3 ON t3~l = t2~d
                       INNER JOIN
                         demo_join4 AS t4 ON t4~l = t3~l
           FIELDS t1~a AS a1,
                  t1~b AS b1,
                  t1~c AS c1,
                  t1~d AS d1,
                  t2~d AS d2,
                  t2~e AS e2,
                  t2~f AS f2,
                  t2~g AS g2,
                  t2~h AS h2,
                  t3~i AS i3,
                  t3~j AS j3,
                  t3~k AS k3,
                  t3~l AS l3,
                  t4~l AS l4,
                  t4~m AS m4,
                  t4~n AS n4
           INTO CORRESPONDING FIELDS OF TABLE @itab.
    SORT itab.
    out->write( itab
      )->next_section( `4b. ((demo1 INNER JOIN demo2) ` &&
                       `LEFT OUTER JOIN demo3) INNER JOIN demo4` ).
    SELECT FROM
             ( ( demo_join1 AS t1
                   INNER JOIN
                     demo_join2 AS t2 ON t2~d = t1~d )
                       LEFT OUTER JOIN
                         demo_join3 AS t3 ON t3~l = t2~d )
                           INNER JOIN
                             demo_join4 AS t4 ON t4~l = t3~l
           FIELDS t1~a AS a1,
                  t1~b AS b1,
                  t1~c AS c1,
                  t1~d AS d1,
                  t2~d AS d2,
                  t2~e AS e2,
                  t2~f AS f2,
                  t2~g AS g2,
                  t2~h AS h2,
                  t3~i AS i3,
                  t3~j AS j3,
                  t3~k AS k3,
                  t3~l AS l3,
                  t4~l AS l4,
                  t4~m AS m4,
                  t4~n AS n4
           INTO CORRESPONDING FIELDS OF TABLE @itab.
    SORT itab.
    out->write( itab
      )->next_section( `5a. demo1 INNER JOIN demo2 ` &&
                       `LEFT OUTER JOIN demo3 INNER JOIN demo4` ).
    SELECT FROM
             demo_join1 AS t1
               INNER JOIN
                 demo_join2 AS t2 ON t2~d = t1~d
               LEFT OUTER JOIN
                 demo_join3 AS t3
                   INNER JOIN
                     demo_join4 AS t4 ON t4~l = t3~l ON t3~l = t2~d
           FIELDS t1~a AS a1,
                  t1~b AS b1,
                  t1~c AS c1,
                  t1~d AS d1,
                  t2~d AS d2,
                  t2~e AS e2,
                  t2~f AS f2,
                  t2~g AS g2,
                  t2~h AS h2,
                  t3~i AS i3,
                  t3~j AS j3,
                  t3~k AS k3,
                  t3~l AS l3,
                  t4~l AS l4,
                  t4~m AS m4,
                  t4~n AS n4
           INTO CORRESPONDING FIELDS OF TABLE @itab.
    SORT itab.
    out->write( itab
      )->next_section( `5b. (demo1 INNER JOIN demo2) ` &&
                       `LEFT OUTER JOIN (demo3 INNER JOIN demo4)` ).
    SELECT FROM
             ( demo_join1 AS t1
                 INNER JOIN
                   demo_join2 AS t2 ON t2~d = t1~d )
               LEFT OUTER JOIN
                 ( demo_join3 AS t3
                     INNER JOIN
                       demo_join4 AS t4 ON t4~l = t3~l ) ON t3~l = t2~d
           FIELDS t1~a AS a1,
                  t1~b AS b1,
                  t1~c AS c1,
                  t1~d AS d1,
                  t2~d AS d2,
                  t2~e AS e2,
                  t2~f AS f2,
                  t2~g AS g2,
                  t2~h AS h2,
                  t3~i AS i3,
                  t3~j AS j3,
                  t3~k AS k3,
                  t3~l AS l3,
                  t4~l AS l4,
                  t4~m AS m4,
                  t4~n AS n4
           INTO CORRESPONDING FIELDS OF TABLE @itab.
    SORT itab.
    out->write( itab
      )->next_section( `6a. demo1 CROSS JOIN demo2 ` &&
                       `CROSS JOIN demo3` ).
    SELECT FROM
             demo_join1 AS t1
               CROSS JOIN
                 demo_join2 AS t2
                     CROSS JOIN
                       demo_join3 AS t3
           FIELDS t1~a AS a1,
                  t1~b AS b1,
                  t1~c AS c1,
                  t1~d AS d1,
                  t2~d AS d2,
                  t2~e AS e2,
                  t2~f AS f2,
                  t2~g AS g2,
                  t2~h AS h2,
                  t3~i AS i3,
                  t3~j AS j3,
                  t3~k AS k3,
                  t3~l AS l3
           INTO CORRESPONDING FIELDS OF TABLE @itab.
    SORT itab.
    jtab = itab.
    out->write( itab
      )->next_section( `6b. ( demo1 CROSS JOIN demo2 ) ` &&
                       `CROSS JOIN demo3` ).
    SELECT FROM
            ( demo_join1 AS t1
               CROSS JOIN
                  demo_join2 AS t2 )
                      CROSS JOIN
                        demo_join3 AS t3
           FIELDS t1~a AS a1,
                  t1~b AS b1,
                  t1~c AS c1,
                  t1~d AS d1,
                  t2~d AS d2,
                  t2~e AS e2,
                  t2~f AS f2,
                  t2~g AS g2,
                  t2~h AS h2,
                  t3~i AS i3,
                  t3~j AS j3,
                  t3~k AS k3,
                  t3~l AS l3
           INTO CORRESPONDING FIELDS OF TABLE @itab.
    SORT itab.
    ASSERT itab = jtab.
    out->write( itab
      )->next_section( `6c. demo1 CROSS JOIN ( demo2 ` &&
                       `CROSS JOIN demo3 )` ).
    SELECT FROM
             demo_join1 AS t1
               CROSS JOIN
                 ( demo_join2 AS t2
                       CROSS JOIN
                         demo_join3 AS t3 )
           FIELDS t1~a AS a1,
                  t1~b AS b1,
                  t1~c AS c1,
                  t1~d AS d1,
                  t2~d AS d2,
                  t2~e AS e2,
                  t2~f AS f2,
                  t2~g AS g2,
                  t2~h AS h2,
                  t3~i AS i3,
                  t3~j AS j3,
                  t3~k AS k3,
                  t3~l AS l3
           INTO CORRESPONDING FIELDS OF TABLE @itab.
    SORT itab.
    ASSERT jtab = itab.
    out->write( itab
      )->next_section( `7a. demo1 CROSS JOIN demo2 ` &&
                       `RIGHT OUTER demo3` ).
    SELECT FROM
             demo_join1 AS t1
               CROSS JOIN
                 demo_join2 AS t2
                     RIGHT OUTER JOIN
                       demo_join3 AS t3 ON t3~l = t2~d
           FIELDS t1~a AS a1,
                  t1~b AS b1,
                  t1~c AS c1,
                  t1~d AS d1,
                  t2~d AS d2,
                  t2~e AS e2,
                  t2~f AS f2,
                  t2~g AS g2,
                  t2~h AS h2,
                  t3~i AS i3,
                  t3~j AS j3,
                  t3~k AS k3,
                  t3~l AS l3
           INTO CORRESPONDING FIELDS OF TABLE @itab.
    SORT itab.
    out->write( itab
      )->next_section( `7b. ( demo1 CROSS JOIN demo2 ) ` &&
                       `RIGHT OUTER demo3` ).
    SELECT FROM
             ( demo_join1 AS t1
                 CROSS JOIN
                   demo_join2 AS t2 )
                       RIGHT OUTER JOIN
                         demo_join3 AS t3 ON t3~l = t2~d
           FIELDS t1~a AS a1,
                  t1~b AS b1,
                  t1~c AS c1,
                  t1~d AS d1,
                  t2~d AS d2,
                  t2~e AS e2,
                  t2~f AS f2,
                  t2~g AS g2,
                  t2~h AS h2,
                  t3~i AS i3,
                  t3~j AS j3,
                  t3~k AS k3,
                  t3~l AS l3
           INTO CORRESPONDING FIELDS OF TABLE @itab.
    SORT itab.
    out->write( itab
      )->next_section( `7c. demo1 CROSS JOIN ( demo2  ` &&
                       `RIGHT OUTER demo3 )` ).
    SELECT FROM
             demo_join1 AS t1
               CROSS JOIN
                 ( demo_join2 AS t2
                       RIGHT OUTER JOIN
                         demo_join3 AS t3 ON t3~l = t2~d )
           FIELDS t1~a AS a1,
                  t1~b AS b1,
                  t1~c AS c1,
                  t1~d AS d1,
                  t2~d AS d2,
                  t2~e AS e2,
                  t2~f AS f2,
                  t2~g AS g2,
                  t2~h AS h2,
                  t3~i AS i3,
                  t3~j AS j3,
                  t3~k AS k3,
                  t3~l AS l3
           INTO CORRESPONDING FIELDS OF TABLE @itab.
    SELECT COUNT( * ) FROM demo_join1
                      INTO @DATA(left).
    SELECT COUNT( * ) FROM demo_join2 AS t2 RIGHT OUTER JOIN
                           demo_join3 AS t3 ON t3~l = t2~d
                      INTO @DATA(right).
    ASSERT lines( itab ) = left * right.
    SORT itab.
    out->display( itab ).
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
    DELETE FROM demo_join4.
    INSERT demo_join4 FROM TABLE @( VALUE #(
      ( l = 'uu' m = 'm1' n = 'n1' )
      ( l = 'vv' m = 'm2' n = 'n2' )
      ( l = 'ww' m = 'm3' n = 'n3' ) ) ).
    SELECT * FROM demo_join4 INTO TABLE @DATA(itab4).
    out->begin_section( `demo1`
      )->write( itab1
      )->next_section( `demo2`
      )->write( itab2
      )->next_section( `demo3`
      )->write( itab3
      )->next_section( `demo4`
      )->write( itab4
      )->end_section(
      )->end_section( ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
