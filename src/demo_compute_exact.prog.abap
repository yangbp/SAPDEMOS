REPORT demo_compute_exact.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
  PRIVATE SECTION.
    CLASS-DATA:
      BEGIN OF out,
        div     TYPE string,
        result1 TYPE string,
        flag1   TYPE string,
        result2 TYPE string,
        flag2    TYPE string,
      END OF out,
      output LIKE TABLE OF out.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA: number TYPE i VALUE 3,
          result TYPE decfloat34,
          exc    TYPE REF TO  cx_sy_conversion_rounding.

    cl_demo_input=>request( CHANGING field = number ).

    cl_demo_output=>begin_section(
      |{ number } / div vs. { number } * ( 1 / div )| ).

    DO 100 TIMES.
      APPEND INITIAL LINE TO output.
      output[ sy-index ]-div = sy-index.
      TRY.
          result = EXACT #( number / sy-index ).
          output[ sy-index ]-result1 = result.
          output[ sy-index ]-flag1   = `X`.
        CATCH cx_sy_conversion_rounding INTO exc.
          output[ sy-index ]-result1 = exc->value.
          output[ sy-index ]-flag1   = ` `.
      ENDTRY.
      TRY.
          result = EXACT #( number * ( 1 / sy-index ) ).
          output[ sy-index ]-result2 = result.
          output[ sy-index ]-flag2   = `X`.
        CATCH cx_sy_conversion_rounding INTO exc.
          output[ sy-index ]-result2 = exc->value.
          output[ sy-index ]-flag2   = ` `.
      ENDTRY.
    ENDDO.
    cl_demo_output=>display( output ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
