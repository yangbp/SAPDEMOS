REPORT demo_calculator_modern1.

CLASS memory DEFINITION FINAL.
  PUBLIC SECTION.
    METHODS:
      get RETURNING VALUE(value) TYPE decfloat34,
      set IMPORTING value TYPE decfloat34,
      add IMPORTING value TYPE decfloat34,
      sub IMPORTING value TYPE decfloat34.
  PRIVATE SECTION.
    DATA
      value TYPE decfloat34.
ENDCLASS.

CLASS calculator DEFINITION FINAL CREATE PRIVATE.
  PUBLIC SECTION.
    CLASS-DATA
      handle TYPE REF TO calculator READ-ONLY.
    CLASS-METHODS class_constructor.
    METHODS:
      constructor,
      main.
  PRIVATE SECTION.
    CONSTANTS
      display_width TYPE i VALUE 18.
    DATA:
      ui TYPE REF TO cl_demo_calculator_ui,
      BEGIN OF state,
        value1     TYPE decfloat34,
        value2     TYPE decfloat34,
        operation  TYPE string,
        lock_flag  TYPE abap_bool,
        clear_flag TYPE abap_bool,
      END OF state,
      mem TYPE REF TO memory.
    METHODS:
      number_input FOR EVENT number_input OF cl_demo_calculator_ui
        IMPORTING function display,
      change_value FOR EVENT change_value OF cl_demo_calculator_ui
        IMPORTING function display,
      calculate FOR EVENT calculate OF cl_demo_calculator_ui
        IMPORTING function display,
      handle_memory FOR EVENT handle_memory OF cl_demo_calculator_ui
        IMPORTING function display,
      clear FOR EVENT clear OF cl_demo_calculator_ui
        IMPORTING function,
      write_display
        IMPORTING value TYPE decfloat34
        RETURNING VALUE(display) TYPE cl_demo_calculator_ui=>t_display.
ENDCLASS.

CLASS calculator IMPLEMENTATION.
  METHOD class_constructor.
    handle = NEW #( ).
  ENDMETHOD.

  METHOD constructor.
    ui = cl_demo_calculator_ui=>get_instance( ).
    mem = NEW #( ).
  ENDMETHOD.

  METHOD main.
    SET HANDLER: number_input  FOR ui,
                 change_value  FOR ui,
                 calculate     FOR ui,
                 handle_memory FOR ui,
                 clear         FOR ui.
    ui->show( ).
  ENDMETHOD.

  METHOD number_input.
    CONSTANTS digits TYPE i VALUE 15.
    CHECK state-lock_flag = abap_false.
    IF state-clear_flag = abap_true.
      CLEAR display.
      CLEAR state-clear_flag.
    ENDIF.
    IF ( function = '.' AND display CS '.' ) OR
       count( val = display regex = '\d' ) > digits.
      RETURN.
    ENDIF.
    ui->set( |{ condense( display ) && function WIDTH = display_width ALIGN = RIGHT }| ).
  ENDMETHOD.

  METHOD change_value.
    DATA(result) = CONV decfloat34( display ).
    TRY.
        CASE function.
          WHEN '1/X'.
            result = 1 / result.
          WHEN '+-'.
            result =  -1 * result.
        ENDCASE.
        display = write_display( result ).
        state-lock_flag  = abap_true.
        IF state-operation = '='.
          CLEAR state-operation.
        ENDIF.
      CATCH cx_sy_arithmetic_error.
        display = 'Error' ##no_text.
    ENDTRY.
    ui->set( display ).
  ENDMETHOD.

  METHOD calculate.
    DATA result TYPE decfloat34.
    state-value2 = display.
    TRY.
        CASE state-operation.
          WHEN '+'.
            result = state-value1 + state-value2.
          WHEN '-'.
            result = state-value1 - state-value2.
          WHEN '*'.
            result = state-value1 * state-value2.
          WHEN '/'.
            result = state-value1 / state-value2.
          WHEN '='.
            result = state-value1.
          WHEN OTHERS.
            result = display.
        ENDCASE.
        state-value1 = result.
        CLEAR state-value2.
        display = write_display( result ).
        state-operation = function.
        state-clear_flag = abap_true.
        state-lock_flag = boolc( function = '=' ).
      CATCH cx_sy_arithmetic_error.
        display = 'Error' ##no_text.
    ENDTRY.
    ui->set( display ).
  ENDMETHOD.

  METHOD handle_memory.
    CASE function.
      WHEN 'MC'.
        mem = NEW #( ).
      WHEN 'MR'.
        IF state-lock_flag = abap_false.
          display = write_display( mem->get( ) ).
          state-lock_flag  = abap_true.
        ENDIF.
      WHEN 'MS'.
        mem->set( CONV decfloat34( display ) ).
      WHEN 'MP'.
        mem->add( CONV decfloat34( display ) ).
      WHEN 'MM'.
        mem->sub( CONV decfloat34( display ) ).
    ENDCASE.
    ui->set( display ).
  ENDMETHOD.

  METHOD clear.
    CASE function.
      WHEN 'C'.
        CHECK state-lock_flag = abap_false.
      WHEN 'CA'.
        CLEAR state.
    ENDCASE.
    ui->set( `` ).
  ENDMETHOD.

  METHOD write_display.
    TYPES mask TYPE c LENGTH display_width.
    display = |{ CONV mask( value ) WIDTH = display_width ALIGN = RIGHT }|.
  ENDMETHOD.
ENDCLASS.

CLASS memory IMPLEMENTATION.
  METHOD get.
    value = me->value.
  ENDMETHOD.
  METHOD set.
    me->value = value.
  ENDMETHOD.
  METHOD add.
    me->value = me->value + value.
  ENDMETHOD.
  METHOD sub.
    me->value = me->value - value.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  calculator=>handle->main( ).
