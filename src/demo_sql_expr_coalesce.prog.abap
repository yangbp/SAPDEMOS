REPORT demo_sql_expr_coalesce NO STANDARD PAGE HEADING.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS: class_constructor,
      main.
  PRIVATE SECTION.
    CLASS-DATA: wa1 TYPE demo_join1,
                wa2 TYPE demo_join2,
                out TYPE REF TO if_demo_output.
    CLASS-DATA BEGIN OF wa.
    INCLUDE STRUCTURE wa1 AS wa1 RENAMING WITH SUFFIX 1.
    INCLUDE STRUCTURE wa2 AS wa2 RENAMING WITH SUFFIX 2.
    CLASS-DATA END OF wa.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA itab LIKE TABLE OF wa WITH EMPTY KEY.
    out = cl_demo_output=>new(
     )->begin_section( `OUTER JOIN with Coalesce` ).
    SELECT t1~a AS a1, t1~b AS b1, t1~c AS c1, t1~d AS d1,
           COALESCE( t2~d, '--' ) AS d2,
           COALESCE( t2~e, '--' ) AS e2,
           COALESCE( t2~f, '--' ) AS f2,
           COALESCE( t2~g, '--' ) AS g2,
           COALESCE( t2~h, '--' ) AS h2
       FROM demo_join1 AS t1
         LEFT OUTER JOIN demo_join2 AS t2 ON t2~d = t1~d
       ORDER BY t1~d
       INTO CORRESPONDING FIELDS OF TABLE @itab.
    out->display( itab ).
  ENDMETHOD.
  METHOD class_constructor.
    DELETE FROM demo_join1.
    INSERT demo_join1 FROM TABLE @( VALUE #(
      ( a = 'a1' b = 'b1' c = 'c1'  d = 'uu' )
      ( a = 'a2' b = 'b2' c = 'c2'  d = 'uu' )
      ( a = 'a3' b = 'b3' c = 'c3'  d = 'vv' )
      ( a = 'a4' b = 'b4' c = 'c4'  d = 'ww' ) ) ).
    DELETE FROM demo_join2.
    INSERT demo_join2 FROM TABLE @( VALUE #(
      ( d = 'uu' e = 'e1' f = 'f1'  g = 'g1'  h = 'h1' )
      ( d = 'ww' e = 'e2' f = 'f2'  g = 'g2'  h = 'h2' )
      ( d = 'xx' e = 'e3' f = 'f3'  g = 'g3'  h = 'h3' ) ) ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
