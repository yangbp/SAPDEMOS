REPORT demo_nmax_nmin.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA: a TYPE i VALUE 1,
          b TYPE i VALUE 0,
          c TYPE i VALUE 0.
    cl_demo_input=>new(
      )->add_text( `Parabola:`
      )->add_field( CHANGING field = a
      )->add_field( CHANGING field = b
      )->add_field( CHANGING field = c )->request( ).
    IF a = 0.
      cl_demo_output=>display(
        'You must enter a non-zero value for a' ).
      RETURN.
    ENDIF.

    CONSTANTS: xmin TYPE i VALUE -100,
               xmax TYPE i VALUE 100,
               n    TYPE i VALUE 20000.
    DATA: x  TYPE decfloat34,
          y  TYPE decfloat34,
          y0 TYPE decfloat34.
    DATA       txt  TYPE string.

    DO n + 1 TIMES.
      x = ( xmax - xmin ) / n * ( sy-index - 1 ) + xmin.
      y = a * x ** 2 + b * x + c.
      IF sy-index = 1.
        y0 = y.
      ELSE.
        IF a > 0.
          txt = 'Minimum'.
          y0 = nmin( val1 = y0 val2 = y ).
        ELSE.
          txt = 'Maximum'.
          y0 = nmax( val1 = y0 val2 = y ).
        ENDIF.
      ENDIF.
    ENDDO.
    cl_demo_output=>display( |{ txt } value of parabola is: { y0 }| ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
