REPORT demo_cds_avg.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DELETE FROM demo_expressions.
    INSERT demo_expressions
           FROM TABLE @(
                VALUE #( LET r = cl_abap_random_int=>create(
                                 seed = CONV i( sy-uzeit )
                                 min = 1 max = 10 ) IN
                         FOR i = 1 UNTIL i > 10
                           ( id   = CONV #( i )
                             num1 = r->get_next( ) ) ) ).

    SELECT SINGLE *
           FROM demo_cds_avg
           INTO @DATA(result).

    cl_demo_output=>display( result ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
