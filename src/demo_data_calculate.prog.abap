REPORT demo_data_calculate.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA num1 TYPE decfloat34.
    cl_demo_input=>add_field( CHANGING field = num1 ).
    DATA num2 TYPE decfloat34.
    cl_demo_input=>request(   CHANGING field = num2 ).

    TRY.
        cl_demo_output=>new(
          )->write( |{ num1 } +   { num2 } = { num1 +   num2 }|
          )->write( |{ num1 } -   { num2 } = { num1 -   num2 }|
          )->write( |{ num1 } *   { num2 } = { num1 *   num2 }|
          )->write( |{ num1 } /   { num2 } = { num1 /   num2 }|
          )->write( |{ num1 } DIV { num2 } = { num1 DIV num2 }|
          )->write( |{ num1 } MOD { num2 } = { num1 MOD num2 }|
          )->write( |{ num1 } **  { num2 } = { num1 **  num2 }|
          )->display( ).
      CATCH cx_sy_arithmetic_error INTO DATA(exc).
        cl_demo_output=>display( exc->get_text( ) ).
    ENDTRY.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
