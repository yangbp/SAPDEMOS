REPORT demo_try.


CLASS try_demo DEFINITION.
  PUBLIC SECTION.
    CLASS-DATA: result TYPE p LENGTH 8 DECIMALS 2,
                oref   TYPE REF TO cx_root,
                text   TYPE string.
    CLASS-METHODS main.
  PRIVATE SECTION.
    CLASS-DATA number TYPE i.
    CLASS-DATA out TYPE REF TO if_demo_output.
    CLASS-METHODS calculation
      IMPORTING  p_number LIKE number
      CHANGING p_result LIKE result
               p_text   LIKE text
      RAISING  cx_sy_arithmetic_error.
ENDCLASS.

CLASS try_demo IMPLEMENTATION.
  METHOD main.
    cl_demo_input=>request( CHANGING field = number ).
    out = cl_demo_output=>new( ).
    TRY.
        IF abs( number ) > 100.
          RAISE EXCEPTION TYPE cx_demo_abs_too_large.
        ENDIF.
        calculation( EXPORTING p_number = number
                     CHANGING  p_result = result
                               p_text   = text ).
      CATCH cx_sy_arithmetic_error INTO oref.
        text = oref->get_text( ).
      CATCH cx_root INTO oref.
        text = oref->get_text( ).
    ENDTRY.
    IF NOT text IS INITIAL.
      out->write( text ).
    ENDIF.
    out->display( |Final result: { result ALIGN = LEFT }| ).
  ENDMETHOD.
  METHOD calculation.
    DATA l_oref TYPE REF TO cx_root.
    TRY.
        p_result =  1 / p_number.
        out->write(
          |Result of division: { p_result ALIGN = LEFT }| ).
        p_result = sqrt( p_number ).
        out->write(
          |Result of square root: { p_result ALIGN = LEFT }| ).
      CATCH cx_sy_zerodivide INTO l_oref.
        p_text = l_oref->get_text( ).
      CLEANUP.
        CLEAR p_result.
    ENDTRY.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  try_demo=>main( ).
