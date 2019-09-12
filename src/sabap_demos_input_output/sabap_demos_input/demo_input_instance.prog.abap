REPORT demo_input_instance.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.


CLASS demo IMPLEMENTATION.
  METHOD main.

    DATA: operand1       TYPE i,
          operand2       TYPE i,
          operator       TYPE c LENGTH 1 VALUE '+',
          display_result TYPE abap_bool VALUE abap_true.

    cl_demo_input=>new(
      )->add_field( CHANGING field = operand1
      )->add_field( CHANGING field = operator
      )->add_field( CHANGING field = operand2
      )->add_line(
      )->add_field( EXPORTING text = 'Display result'
                              as_checkbox = 'X'
                    CHANGING  field = display_result
      )->request(  ).

    DATA result TYPE decfloat34.
    CASE operator.
      WHEN '+'.
        result = operand1 + operand2.
      WHEN '-'.
        result = operand1 - operand2.
      WHEN '*'.
        result = operand1 * operand2.
      WHEN '/'.
        result = operand1 / operand2.
      WHEN OTHERS.
        RETURN.
    ENDCASE.

    IF display_result = abap_true.
      cl_demo_output=>new( )->display( result ).
    ENDIF.

  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
