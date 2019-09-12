REPORT demo_int_to_hex.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
  PRIVATE SECTION.
    TYPES:
      BEGIN OF line,
        int1 TYPE c LENGTH 60,
        int2 TYPE c LENGTH 60,
        int4 TYPE c LENGTH 60,
        int8 TYPE c LENGTH 60,
      END OF line.
    CLASS-DATA output TYPE TABLE OF line.
    CLASS-METHODS write_output IMPORTING VALUE(idx) TYPE i
                                         VALUE(col) TYPE i
                                         text       TYPE clike.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA: int1 TYPE int1,
          int2 TYPE int2,
          int4 TYPE int4,
          int8 TYPE int8,
          xstr TYPE xstring,
          xfld TYPE x LENGTH 8.
    cl_demo_output=>begin_section(
      `Conversion of Integers to Byte Fields and Byte Strings` ).
    DO 9 TIMES.
      int1 = ipow( base = 2 exp = sy-index - 1 ) - 1 .
      xstr = int1.
      xfld = int1.
      write_output(
        idx = sy-index
        col = 1
        text = |{ int1 WIDTH = 4 ALIGN = RIGHT } {
                  xfld ALIGN = LEFT } { xstr ALIGN = LEFT }| ).
    ENDDO.
    DO 15 TIMES.
      int2 = - ipow( base = 2 exp = 16 - sy-index ) + 1 .
      xstr = int2.
      xfld = int2.
      write_output(
        idx = sy-index
        col = 2
        text = |{ int2 WIDTH = 7 ALIGN = RIGHT } {
                  xfld ALIGN = LEFT } { xstr ALIGN = LEFT }| ).
    ENDDO.
    DO 16 TIMES.
      int2 = ipow( base = 2 exp = sy-index - 1 ) - 1 .
      xstr = int2.
      xfld = int2.
      write_output(
        idx = sy-index + 15
        col = 2
        text = |{ int2 WIDTH = 7 ALIGN = RIGHT } {
                  xfld ALIGN = LEFT } { xstr ALIGN = LEFT }| ).
    ENDDO.
    DO 31 TIMES.
      int4 = - CONV decfloat34(
                 ipow( base = 2 exp = 32 - sy-index ) ) + 1 .
      xstr = int4.
      xfld = int4.
      write_output(
        idx = sy-index
        col = 3
        text = |{ int4 WIDTH = 12 ALIGN = RIGHT } {
                  xfld ALIGN = LEFT } { xstr ALIGN = LEFT }| ).
    ENDDO.
    DO 32 TIMES.
      int4 = CONV decfloat34(
               ipow( base = 2 exp = sy-index - 1 )  ) - 1 .
      xstr = int4.
      xfld = int4.
      write_output(
        idx = sy-index + 31
        col = 3
        text = |{ int4 WIDTH = 12 ALIGN = RIGHT } {
                  xfld ALIGN = LEFT } { xstr ALIGN = LEFT }| ).
    ENDDO.
    DO 63 TIMES.
      int8 = - CONV decfloat34(
                 ipow( base = 2 exp = 64 - sy-index ) ) + 1 .
      xstr = int8.
      xfld = int8.
      write_output(
        idx = sy-index
        col = 4
        text = |{ int8 WIDTH = 21 ALIGN = RIGHT } {
                  xfld ALIGN = LEFT } { xstr ALIGN = LEFT }| ).
    ENDDO.
    DO 64 TIMES.
      int8 = CONV decfloat34(
                ipow( base = 2 exp = sy-index - 1 ) ) - 1 .
      xstr = int8.
      xfld = int8.
      write_output(
        idx = sy-index + 63
        col = 4
        text = |{ int8 WIDTH = 21 ALIGN = RIGHT } {
                  xfld ALIGN = LEFT } { xstr ALIGN = LEFT }| ).
    ENDDO.
    cl_demo_output=>display( output ).
  ENDMETHOD.
  METHOD write_output.
    ASSIGN output[ idx ] TO FIELD-SYMBOL(<line>).
    IF sy-subrc <> 0.
      DO.
        APPEND INITIAL LINE TO output ASSIGNING <line>.
        IF sy-tabix = idx.
          EXIT.
        ENDIF.
      ENDDO.
    ENDIF.
    ASSIGN COMPONENT col OF STRUCTURE <line> TO FIELD-SYMBOL(<col>).
    <col> = text.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
