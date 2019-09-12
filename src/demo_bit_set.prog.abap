REPORT demo_bit_set.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA(number) = 1.
    cl_demo_input=>request( CHANGING field = number ).
    IF abs( number ) <= 200.
      cl_demo_output=>display( CONV xstring( bit-set( number ) ) ).
    ELSE.
      cl_demo_output=>display(
       'Number in Example must not exceed 200' ).
    ENDIF.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
