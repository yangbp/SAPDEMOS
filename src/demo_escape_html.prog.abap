REPORT  demo_escape_html.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA: body     TYPE string,
          esc_body TYPE string.

    body = `<table border> `
        && `<tr><td>11</td><td>12</td></tr> `
        && `<tr><td>21</td><td>22</td></tr> `
        && `</table>`.

    esc_body = escape( val    = body
                       format = cl_abap_format=>e_html_text ).

    cl_demo_output=>new(
      )->begin_section( 'Original text'
      )->write_text( body

      )->next_section( 'Original text formatted as HTML'
      )->write_html( body

      )->next_section( 'Escaped text'
      )->write_text( esc_body

      )->next_section( 'Escaped text formatted as HTML'
      )->write_html( esc_body

      )->display( ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
