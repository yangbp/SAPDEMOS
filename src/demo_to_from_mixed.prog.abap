REPORT demo_to_from_mixed.


CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA:
      original  TYPE c LENGTH 30 VALUE 'ABAP_DOCU_START',
      to_sep    TYPE c LENGTH 1  VALUE '_',
      to_case   TYPE c LENGTH 1 VALUE 'a',
      to_min    TYPE i VALUE 1,
      from_sep  TYPE c LENGTH 1  VALUE '.',
      from_case TYPE c LENGTH 1  VALUE 'A',
      from_min  TYPE i VALUE 5.

    cl_demo_input=>new(
     )->add_field( CHANGING field = original
     )->add_line(
     )->add_field( CHANGING field = to_sep
     )->add_field( CHANGING field = to_case
     )->add_field( CHANGING field = to_min
     )->add_line(
     )->add_field( CHANGING field = from_sep
     )->add_field( CHANGING field = from_case
     )->add_field( CHANGING field = from_min
     )->request( ).

    DATA(out) = cl_demo_output=>new( ).
    TRY.
        out->write( |original:   { original }| ).
        DATA(to_mixed) = to_mixed( val  = original
                                   sep  = to_sep
                                   case = to_case
                                   min  = to_min ).
        out->write( |to_mixed:   { to_mixed }| ).
        DATA(from_mixed) = from_mixed( val  = to_mixed
                                       sep  = from_sep
                                       case = from_case
                                       min  = from_min ).
        out->write( |from_mixed: { from_mixed }| ).
      CATCH cx_sy_strg_par_val.
        out->write( 'Invalid parameters' ).
    ENDTRY.
    out->display( ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
