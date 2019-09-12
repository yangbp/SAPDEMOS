REPORT demo_matrix.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    TYPES: t_column TYPE STANDARD TABLE OF string   WITH EMPTY KEY,
           t_rows   TYPE STANDARD TABLE OF t_column WITH EMPTY KEY.
    CLASS-METHODS: main.
  PRIVATE SECTION.
    CLASS-DATA:
      rows    TYPE i,
      columns TYPE i,
      x       TYPE i VALUE 1,
      y       TYPE i VALUE 1.
    CLASS-METHODS initialize.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    initialize( ).

    "Old way
    DATA: column     TYPE t_column,
          matrix_old TYPE t_rows.
    DO columns TIMES.
      DATA(idx) = sy-index - 1.
      CLEAR column.
      DO rows TIMES.
        APPEND sy-abcde+idx(1) && |{ sy-index }| TO column.
      ENDDO.
      APPEND column TO matrix_old.
    ENDDO.

    "New way
    DATA(matrix_new) =
      VALUE t_rows(
        FOR i = 0 UNTIL i > columns - 1 (
          VALUE t_column(
            FOR j = 1 UNTIL j > rows
              ( sy-abcde+i(1) && |{ j }| ) ) ) ).

    ASSERT matrix_new = matrix_old.

    TRY.
        cl_demo_output=>display( matrix_new[ x ][ y ] ).
      CATCH cx_sy_itab_line_not_found.
        cl_demo_output=>display( 'Not found' ).
    ENDTRY.
  ENDMETHOD.
  METHOD initialize.
    rows = 100.
    columns = strlen( sy-abcde ).
    cl_demo_input=>add_field( CHANGING field = x ).
    cl_demo_input=>add_field( CHANGING field = y ).
    cl_demo_input=>request( ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
