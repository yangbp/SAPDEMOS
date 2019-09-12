REPORT demo_calculator_quaint.

CLASS calculator DEFINITION FINAL CREATE PRIVATE.
  PUBLIC SECTION.
    CLASS-DATA:
      ui TYPE REF TO cl_demo_calculator_ui,
      value1   TYPE f,
      value2   TYPE f,
      memory   TYPE f,
      operation(10),
      lock_flag,
      clear_flag.
    CLASS-METHODS:
      class_constructor,
      main,
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
        IMPORTING value TYPE f
        RETURNING value(display) TYPE cl_demo_calculator_ui=>t_display.
ENDCLASS.

CLASS calculator IMPLEMENTATION.
  METHOD class_constructor.
    CALL METHOD cl_demo_calculator_ui=>get_instance
      RECEIVING
        ui = ui.
  ENDMETHOD.

  METHOD main.
    SET HANDLER: number_input  FOR ui,
                 change_value  FOR ui,
                 calculate     FOR ui,
                 handle_memory FOR ui,
                 clear         FOR ui.
    CALL METHOD ui->show.
  ENDMETHOD.

  METHOD number_input.
    DATA digits LIKE display.
    CHECK lock_flag = ' '.
    IF clear_flag = 'X'.
      CLEAR display.
      CLEAR clear_flag.
    ENDIF.
    IF function = '.' AND display CS '.'.
      EXIT.
    ELSE.
      MOVE display TO digits.
      CONDENSE digits.
      REPLACE: '.' WITH `` INTO digits,
               '-' WITH `` INTO digits.
      IF strlen( digits ) > 15.
        EXIT.
      ENDIF.
    ENDIF.
    CONDENSE display.
    CONCATENATE display function INTO display.
    WRITE display TO display RIGHT-JUSTIFIED.
    CALL METHOD ui->set
      EXPORTING
        value = display.
  ENDMETHOD.

  METHOD change_value.
    DATA result TYPE f.
    MOVE display TO result.
    CASE function.
      WHEN '1/X'.
        IF result <> 0.
          COMPUTE result = 1 / result.
        ELSE.
          MOVE 'Error' TO display.                          "#EC NOTEXT
          CALL METHOD ui->set
            EXPORTING
              value = display.
          EXIT.
        ENDIF.
      WHEN '+-'.
        COMPUTE result =  -1 * result.
    ENDCASE.
    CALL METHOD write_display
      EXPORTING
        value   = result
      RECEIVING
        display = display.
    MOVE 'X' TO lock_flag.
    IF operation = '='.
      CLEAR operation.
    ENDIF.
    CALL METHOD ui->set
      EXPORTING
        value = display.
  ENDMETHOD.

  METHOD calculate.
    DATA result TYPE f.
    MOVE display TO value2.
    CATCH SYSTEM-EXCEPTIONS arithmetic_errors = 8.
      CASE operation.
        WHEN '+'.
          COMPUTE result = value1 + value2.
        WHEN '-'.
          COMPUTE result = value1 - value2.
        WHEN '*'.
          COMPUTE result = value1 * value2.
        WHEN '/'.
          COMPUTE result = value1 / value2.
        WHEN '='.
          COMPUTE result = value1.
        WHEN OTHERS.
          MOVE display TO result.
      ENDCASE.
    ENDCATCH.
    IF sy-subrc = 8.
      MOVE 'Error' TO display.                              "#EC NOTEXT
      CALL METHOD ui->set
        EXPORTING
          value = display.
      EXIT.
    ENDIF.
    MOVE result TO value1.
    CLEAR value2.
    CALL METHOD write_display
      EXPORTING
        value   = result
      RECEIVING
        display = display.
    MOVE function TO operation.
    MOVE 'X' TO clear_flag.
    IF function = '='.
      MOVE 'X' TO lock_flag.
    ELSE.
      MOVE ' ' TO lock_flag.
    ENDIF.
    CALL METHOD ui->set
      EXPORTING
        value = display.
  ENDMETHOD.

  METHOD handle_memory.
    DATA value TYPE f.
    value = display.
    CASE function.
      WHEN 'MC'.
        CLEAR memory.
      WHEN 'MR'.
        IF lock_flag = ' '.
          MOVE memory TO value.
          CALL METHOD write_display
            EXPORTING
              value   = value
            RECEIVING
              display = display.
          MOVE 'X' TO lock_flag.
        ENDIF.
      WHEN 'MS'.
        MOVE value TO memory.
      WHEN 'MP'.
        ADD value TO memory.
      WHEN 'MM'.
        SUBTRACT value FROM memory.
    ENDCASE.
    CALL METHOD ui->set
      EXPORTING
        value = display.
  ENDMETHOD.

  METHOD clear.
    CASE function.
      WHEN 'C'.
        CHECK lock_flag = ' '.
      WHEN 'CA'.
        CLEAR: value1,
               value2,
               operation,
               clear_flag,
               lock_flag.
    ENDCASE.
    CALL METHOD ui->set
      EXPORTING
        value = ``.
  ENDMETHOD.

  METHOD write_display.
    SET COUNTRY 'US'.
    WRITE value TO display RIGHT-JUSTIFIED EXPONENT 0.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  CALL METHOD calculator=>main.
