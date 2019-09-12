REPORT demo_field_symbols_casting.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.

    TYPES: BEGIN OF t_date,
              year  TYPE n LENGTH 4,
              month TYPE n LENGTH 2,
              day   TYPE n LENGTH 2,
           END OF t_date.

    FIELD-SYMBOLS: <fs1> TYPE t_date,
                   <fs2> TYPE any,
                   <fs3> TYPE n.

    DATA(out) = cl_demo_output=>new(
      )->write_text( |sy-datum: { sy-datum }|
      )->line( ).

*------- Casting with implicit typing ------------

    ASSIGN sy-datum TO <fs1> CASTING.

    out->write_text( |Year: { <fs1>-year }| ).
    out->write_text( |Month: { <fs1>-month }| ).
    out->write_text( |Day: { <fs1>-day }| ).
    out->line( ).

*------- Casting with explicit typing ------------

    ASSIGN sy-datum TO <fs2> CASTING TYPE t_date.

    DO.
      ASSIGN COMPONENT sy-index OF STRUCTURE <fs2> TO <fs3>.
      IF sy-subrc <> 0.
        EXIT.
      ENDIF.
      out->write_text( |Component { sy-index }: { <fs3> }| ).
    ENDDO.

    out->display( ).

  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
