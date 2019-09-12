REPORT demo_move_exact.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA: text     TYPE string VALUE `4 Apples + 2 Oranges`,
          num_text TYPE n LENGTH 8.
    DATA(out) = cl_demo_output=>new(
      )->begin_section( text
      )->begin_section( `Not really exact:` ).
    num_text = text.
    out->write_data( num_text
      )->next_section( `Try to be exact:` ).
    TRY.
        num_text = EXACT #( text ).
        out->write_data( num_text ).
      CATCH cx_sy_conversion_error INTO DATA(exc).
        out->write_text( exc->get_text( ) ).
    ENDTRY.
    out->display( ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
