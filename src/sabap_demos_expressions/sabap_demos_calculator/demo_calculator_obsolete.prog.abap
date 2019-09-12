REPORT demo_calculator_obsolete.

DATA:  display(18),
       function TYPE syst-ucomm,
       value1   TYPE f,
       value2   TYPE f,
       memory   TYPE f,
       operation(10),
       clear_flag,
       lock_flag.

DO.

  CALL FUNCTION 'DEMO_CALCULATOR_UI'
    EXPORTING
      display  = display
    IMPORTING
      function = function.

  REPLACE 'F_'  WITH `` INTO function.

  IF display = 'Error' AND function(2) <> 'CA'.
    CONTINUE.
  ENDIF.

  CASE function.
    WHEN 'CANCEL'.
      LEAVE PROGRAM.
    WHEN '0' OR '1' OR '2' OR '3' OR '4' OR '5' OR '6' OR '7' OR '8' OR '9' OR '.'.
      PERFORM number_input USING function.
    WHEN '1/X' OR '+-'.
      PERFORM change_value USING function.
    WHEN '+' OR '-' OR '*' OR '/' OR '='.
      PERFORM calculate.
    WHEN 'MC' OR 'MR' OR 'MS' OR 'MP' OR 'MM'.
      PERFORM handle_memory USING function.
    WHEN 'C' OR 'CA'.
      PERFORM clear USING function.
  ENDCASE.

ENDDO.


FORM number_input USING function.
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
ENDFORM.

FORM change_value USING function.
  DATA result TYPE f.
  MOVE display TO result.
  CASE function.
    WHEN '1/X'.
      IF result <> 0.
        COMPUTE result = 1 / result.
      ELSE.
        MOVE 'Error' TO display.                            "#EC NOTEXT
        EXIT.
      ENDIF.
    WHEN '+-'.
      COMPUTE result =  -1 * result.
  ENDCASE.
  PERFORM write_display USING result.
  MOVE 'X' TO lock_flag.
  IF operation = '='.
    CLEAR operation.
  ENDIF.
ENDFORM.

FORM calculate.
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
        MOVE value1 TO result.
      WHEN OTHERS.
        MOVE display TO result.
    ENDCASE.
  ENDCATCH.
  IF sy-subrc = 8.
    MOVE 'Error' TO display.                                "#EC NOTEXT
    EXIT.
  ENDIF.
  MOVE result TO value1.
  CLEAR value2.
  PERFORM write_display USING result.
  MOVE function TO operation.
  MOVE 'X' TO clear_flag.
  IF function = '='.
    MOVE 'X' TO lock_flag.
  ELSE.
    MOVE ' ' TO lock_flag.
  ENDIF.
ENDFORM.

FORM handle_memory USING function.
  DATA value TYPE f.
  value = display.
  CASE function.
    WHEN 'MC'.
      CLEAR memory.
    WHEN 'MR'.
      IF lock_flag = ' '.
        MOVE memory TO value.
        PERFORM write_display USING value.
        MOVE 'X' TO lock_flag.
      ENDIF.
    WHEN 'MS'.
      MOVE value TO memory.
    WHEN 'MP'.
      ADD value TO memory.
    WHEN 'MM'.
      SUBTRACT value FROM memory.
  ENDCASE.
ENDFORM.

FORM clear USING function.
  CASE function.
    WHEN 'C'.
      CHECK lock_flag = ' '.
      CLEAR display.
    WHEN 'CA'.
      CLEAR:
        value1,
        value2,
        operation,
        clear_flag,
        lock_flag,
        display.
  ENDCASE.
ENDFORM.

FORM write_display USING value.
  SET COUNTRY 'US'.
  WRITE value TO display RIGHT-JUSTIFIED EXPONENT 0.
ENDFORM.
