REPORT demo_function_group_counter .

DATA number TYPE i VALUE 5.

CALL FUNCTION 'SET_COUNTER'
     EXPORTING
          set_value = number.

DO 3 TIMES.
  CALL FUNCTION 'INCREMENT_COUNTER'.
ENDDO.

CALL FUNCTION 'GET_COUNTER'
     IMPORTING
          get_value = number.

cl_demo_output=>display( number ).
