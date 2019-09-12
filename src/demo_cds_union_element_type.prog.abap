REPORT demo_cds_union_element_type.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DELETE FROM demo_expressions.
    INSERT demo_expressions
      FROM @( VALUE #( id = 'X' num1 = 111 numlong1 = 222 ) ).

    SELECT col1, col2
           FROM demo_cds_union_element_type
           WHERE id = 'X'
           INTO TABLE @DATA(result1).
    cl_demo_output=>write( result1 ).

    DELETE FROM demo_expressions.
    INSERT demo_expressions
      FROM @( VALUE #( id = 'X' num1 = 111 numlong1 = 333333333333 ) ).

    TRY.
        SELECT col1, col2
               FROM demo_cds_union_element_type
               WHERE id = 'X'
               INTO TABLE @DATA(result2).
        cl_demo_output=>write( result2 ).
      CATCH cx_sy_open_sql_db INTO DATA(exc).
        cl_demo_output=>write( exc->get_text( ) ).
    ENDTRY.

    SELECT CAST( col1 AS INT8 ) AS col1, col2
           FROM demo_cds_union_element_type
           WHERE id = 'X'
           INTO TABLE @DATA(result3).
    cl_demo_output=>write( result3 ).

    TYPES:
      BEGIN OF wa,
        col1 type int8,
        col2 type int8,
      END OF wa.
    DATA result4 TYPE TABLE OF wa WITH EMPTY KEY.
    SELECT CAST( col1 AS INT8 ) AS col1, col2
           FROM demo_cds_union_element_type
           WHERE id = 'X'
           INTO TABLE @result4.
    cl_demo_output=>write( result4 ).

    cl_demo_output=>display( ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
