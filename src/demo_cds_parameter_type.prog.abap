REPORT demo_cds_parameter_type.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DELETE FROM demo_expressions.
    INSERT demo_expressions FROM TABLE @( VALUE #(
             ( id = 'X' dec3 = '10.000' )
             ( id = 'Y' dec3 = '20.000' )
             ( id = 'Z' dec3 = '30.000' ) ) ).

    SELECT id, col_date, col_num
           FROM demo_cds_parameter_type( p_date = @sy-datlo,
                                         p_num  = '1.234' )
           INTO TABLE @DATA(result).

    cl_demo_output=>display( result ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
