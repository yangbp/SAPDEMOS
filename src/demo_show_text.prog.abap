REPORT  demo_show_text.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA: text       TYPE REF TO cl_demo_text,
          text_table TYPE cl_demo_text=>t_text,
          text_line  TYPE cl_demo_text=>t_line.

    text = cl_demo_text=>new( ).

    text_line = 'First line of text'.
    text->add_line( text_line ).
    text->add_line( ' ' ).
    DO 10 TIMES.
      CLEAR text_line.
      text_line(3) = sy-index.
      text_line  = |Table line { text_line }|.
      APPEND text_line TO text_table.
    ENDDO.
    text->add_table( text_table ).
    text->add_line( ' ' ).
    text_line = 'Last line of text'.
    text->add_line( text_line ).

    text->display( ).

    text->delete( ).
    text->add_line( 'New text' ).
    text->display( ).

  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
