REPORT demo_list_line_elements NO STANDARD PAGE HEADING LINE-SIZE 60.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
  PRIVATE SECTION.
    CLASS-DATA: x TYPE i,
                y TYPE i.
    CLASS-METHODS pos.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA: x0 TYPE i VALUE 10,
          y0 TYPE i VALUE 10,
          n  TYPE i VALUE 16,
          i  TYPE i VALUE 0.

    x = x0.
    y = y0.
    pos( ).

    WHILE i LE n.
      WRITE line_bottom_left_corner AS LINE.
      x = x + 1. pos( ).
      ULINE AT x(i).
      x = x + i. pos( ).
      WRITE line_bottom_right_corner AS LINE.
      y = y - 1. pos( ).
      DO i TIMES.
        WRITE '|'.
        y = y - 1. pos( ).
      ENDDO.
      WRITE line_top_right_corner AS LINE.
      i = i + 1.
      x = x - i. pos( ).
      ULINE AT x(i).
      x = x - 1. pos( ).
      WRITE line_top_left_corner AS LINE.
      y = y + 1. pos( ).
      DO i TIMES.
        WRITE '|'.
        y = y + 1. pos( ).
      ENDDO.
      i = i + 1.
    ENDWHILE.
  ENDMETHOD.

  METHOD pos.
    SKIP TO LINE y.
    POSITION x.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
