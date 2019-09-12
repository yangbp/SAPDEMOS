REPORT demo_predicative_method_call.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    IF cl_abap_demo_services=>is_production_system( ).
      cl_demo_output=>display(
         'This demo cannot be executed in a production system' ).
      LEAVE PROGRAM.
    ENDIF.

    DATA carrier TYPE spfli-carrid VALUE 'LH'.
    cl_demo_input=>request( CHANGING field = carrier ).

    DATA(out) = cl_demo_output=>new(
      )->next_section( 'IF' ).
    IF cl_demo_spfli=>get_spfli( to_upper( carrier ) ).
      out->write( 'Filled' ).
    ELSE.
      out->write( 'Not filled' ).
    ENDIF.

    out->next_section( 'COND'
      )->write( COND string(
                  WHEN cl_demo_spfli=>get_spfli( to_upper( carrier ) )
                    THEN `Filled`
                  ELSE `Not filled` )
      )->display( ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
