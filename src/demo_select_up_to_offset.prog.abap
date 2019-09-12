REPORT demo_select_up_to_offset.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS
      main.
  PRIVATE SECTION.
    CLASS-DATA:
      o TYPE int8,
      n TYPE int8.
    CLASS-METHODS
      setup.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    setup( ).

    SELECT FROM demo_expressions
           FIELDS id, num1 AS number, numlong1 AS result
           ORDER BY id, num1
           INTO TABLE @DATA(itab)
           OFFSET @o
           UP TO @n ROWS.

    cl_demo_output=>display( itab ).

    DELETE FROM demo_expressions.
  ENDMETHOD.
  METHOD setup.
    cl_demo_input=>new(
       )->add_field( CHANGING field = o
       )->request(   CHANGING field = n ).
    IF NOT ( ( o BETWEEN 0 AND 2147483646 ) AND
             ( n BETWEEN 0 AND 2147483646 ) ).
      cl_demo_output=>display(
        `Input not in allowed interval!` ).
      LEAVE PROGRAM.
    ENDIF.

    DELETE FROM demo_expressions.
    DO strlen( sy-abcde ) TIMES.
      INSERT demo_expressions FROM @(
        VALUE #( id       = substring( val = sy-abcde
                                       off = sy-index - 1
                                       len = 1 )
                 num1     = sy-index
                 numlong1 = ipow( base = 2 exp = sy-index ) ) ).
    ENDDO.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
