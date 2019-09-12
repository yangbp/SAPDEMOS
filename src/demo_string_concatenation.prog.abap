REPORT demo_string_concatenation.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA(n) = 10000.
    cl_demo_input=>request( CHANGING field = n ).
    IF n <= 0 OR n >= 100000.
      EXIT.
    ENDIF.

    GET RUN TIME FIELD DATA(t1).
    DATA(result1) =
      REDUCE string( INIT s = ``
                     FOR i = 1 UNTIL i > n
                     NEXT s = s && CONV string( i ) ).
    GET RUN TIME FIELD DATA(t2).
    DATA(t21) = t2 - t1.

    GET RUN TIME FIELD DATA(t3).
    DATA(result2) =
      REDUCE string( INIT s = ``
                     FOR i = 1 UNTIL i > n
                     LET num = CONV string( i ) IN
                     NEXT s = s && num ).
    GET RUN TIME FIELD DATA(t4).
    DATA(t43) = t4 - t3.

    ASSERT result1 = result2.
    cl_demo_output=>display( |Optimization factor: { t21 / t43 }| ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
