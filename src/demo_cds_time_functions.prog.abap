REPORT demo_cds_time_functions.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA(time1) = sy-timlo.
    cl_demo_input=>request( CHANGING field = time1 ).

    DELETE FROM demo_expressions.
    INSERT demo_expressions FROM @( VALUE #(
      id      = 'X'
     	tims1 = time1 ) ).

    SELECT SINGLE *
           FROM demo_cds_time_functions
           INTO @DATA(result).

    cl_demo_output=>display( result ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
