REPORT demo_case_type_of_exception.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
  PRIVATE SECTION.
    CLASS-DATA out TYPE REF TO if_demo_output.
    CLASS-METHODS my_sqrt IMPORTING num TYPE any
                          RAISING   cx_dynamic_check.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA number TYPE string.
    out = cl_demo_output=>new( ).
    cl_demo_input=>request( CHANGING field = number ).
    TRY.
        my_sqrt( number ).
      CATCH cx_root INTO DATA(exc).
        CASE TYPE OF exc.
          WHEN TYPE cx_sy_arithmetic_error.
            out->display( 'Arithmetic error' ).
          WHEN TYPE cx_sy_conversion_error.
            out->display( 'Conversion error' ).
          WHEN OTHERS.
            out->display( 'Other error' ).
        ENDCASE.
    ENDTRY.
  ENDMETHOD.
  METHOD my_sqrt.
    DATA(sqrt) = sqrt( CONV decfloat34( num ) ).
    out->display( sqrt ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
