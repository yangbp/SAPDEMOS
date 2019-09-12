REPORT demo_cte_client_handling.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA client TYPE scarr-mandt.
    cl_demo_input=>request( CHANGING field = client ).

    WITH
      +cte AS ( SELECT mandt, carrid, carrname
                       FROM scarr CLIENT SPECIFIED )
      SELECT *
             FROM +cte
             WHERE mandt = @client
             INTO TABLE @DATA(result).

    cl_demo_output=>display( result ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
