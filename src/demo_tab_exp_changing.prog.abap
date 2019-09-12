REPORT demo_tab_exp_changing.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
  PRIVATE SECTION.
    TYPES:
      BEGIN OF struct,
        col1 TYPE i,
        col2 TYPE i,
      END OF struct,
      itab TYPE STANDARD TABLE OF struct WITH EMPTY KEY.
    CLASS-METHODS:
      change_component
        IMPORTING p1 TYPE i
        EXPORTING p2 TYPE i,
      change_line
        CHANGING p TYPE struct.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA(itab) = VALUE itab(
                   ( col1 = 3 )
                   ( col1 = 5 )
                   ( col1 = 7 ) ).

    DATA(out) = cl_demo_output=>new(
      )->begin_section( `Before`
      )->write( itab ).

    DO lines( itab ) TIMES.
      change_component( EXPORTING p1 = itab[ sy-index ]-col1
                        IMPORTING p2 = itab[ sy-index ]-col2 ).
    ENDDO.

    out->next_section( `After change_component`
      )->write( itab ).

    DO lines( itab ) TIMES.
      change_line( CHANGING p = itab[ sy-index ] ).
    ENDDO.

    out->next_section( `After change_line`
      )->write( itab
      )->display( ).

  ENDMETHOD.
  METHOD change_component.
    p2 = ipow( base = p1 exp = 2 ).
  ENDMETHOD.
  METHOD change_line.
    p-col2 = ipow( base = p-col1 exp = 3 ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
