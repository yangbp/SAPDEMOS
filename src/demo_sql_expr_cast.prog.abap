REPORT demo_sql_expr_cast.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DELETE FROM demo_expressions.
    INSERT demo_expressions FROM @( VALUE #(
             id   = 'X'
             num1 = 111
             numlong1 = '123456789'
             dec3 = '123.456'
             dats2 = sy-datum ) ).

    SELECT SINGLE
           FROM demo_expressions
           FIELDS CAST( num1     AS CHAR( 20 ) ) AS col1,
                  CAST( numlong1 AS CHAR( 20 ) ) AS col2,
                  CAST( dec3     AS CHAR( 20 ) ) AS col3,
                  CAST( dats2    AS CHAR( 20 ) ) AS col4
           WHERE id = 'X'
           INTO @DATA(result).

    DATA(text)  = ``.
    DO.
      ASSIGN COMPONENT sy-index
             OF STRUCTURE result
             TO FIELD-SYMBOL(<col>).
      IF sy-subrc = 0.
        text = text && <col> && `, `.
      ELSE.
        EXIT.
      ENDIF.
    ENDDO.
    CONDENSE text.
    SHIFT text RIGHT DELETING TRAILING `,`.
    cl_demo_output=>display( text ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
