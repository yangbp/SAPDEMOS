class CL_DEMO_CALCULATOR_UI definition
  public
  final
  create public .

public section.

  types:
    t_display TYPE c LENGTH 18 .

  events CHANGE_VALUE
    exporting
      value(DISPLAY) type T_DISPLAY
      value(FUNCTION) type STRING .
  events NUMBER_INPUT
    exporting
      value(DISPLAY) type T_DISPLAY
      value(FUNCTION) type STRING .
  events CALCULATE
    exporting
      value(DISPLAY) type T_DISPLAY
      value(FUNCTION) type STRING .
  events HANDLE_MEMORY
    exporting
      value(DISPLAY) type T_DISPLAY
      value(FUNCTION) type STRING .
  events CLEAR
    exporting
      value(FUNCTION) type STRING .

  class-methods GET_INSTANCE
    returning
      value(UI) type ref to CL_DEMO_CALCULATOR_UI .
  methods SET
    importing
      !VALUE type T_DISPLAY .
  methods SHOW .
private section.

  class-data HANDLE type ref to cl_demo_calculator_UI .
  data DISPLAY type T_DISPLAY .
ENDCLASS.



CLASS CL_DEMO_CALCULATOR_UI IMPLEMENTATION.


  METHOD GET_INSTANCE.
    IF handle IS INITIAL.
      CREATE OBJECT handle.
    ENDIF.
    ui = handle.
  ENDMETHOD.


  METHOD SET.
    display = value.
  ENDMETHOD.


  METHOD SHOW.
    DATA function TYPE string.

    DO.

      CALL FUNCTION 'DEMO_CALCULATOR_UI'
        EXPORTING
          display  = display
        IMPORTING
          function = function.

      REPLACE 'F_'  WITH `` INTO function.

      IF display = 'Error' AND NOT matches( val = function regex = '(CA)|(CANCEL)' ).
        CONTINUE.
      ENDIF.

      CASE function.
        WHEN 'CANCEL'.
          RETURN.
        WHEN '0' OR '1' OR '2' OR '3' OR '4' OR '5' OR '6' OR '7' OR '8' OR '9' OR '.'.
          RAISE EVENT number_input
            EXPORTING
              function = function
              display  = display.
        WHEN '1/X' OR '+-'.
          RAISE EVENT change_value
            EXPORTING
              function = function
              display  = display.
        WHEN '+' OR '-' OR '*' OR '/' OR '='.
          RAISE EVENT calculate
            EXPORTING
              function = function
              display  = display.
        WHEN 'MC' OR 'MR' OR 'MS' OR 'MP' OR 'MM'.
          RAISE EVENT handle_memory
            EXPORTING
              function = function
              display  = display.
        WHEN 'C' OR 'CA'.
          RAISE EVENT clear
            EXPORTING
              function = function.
      ENDCASE.

    ENDDO.

  ENDMETHOD.
ENDCLASS.
