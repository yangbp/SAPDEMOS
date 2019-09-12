REPORT demo_shift_substring.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA output TYPE TABLE OF string.
    output = VALUE #(
      ( `            oo            ` ) ).
    output = VALUE #(
      LET n = strlen( output[ 1 ] ) IN
      BASE output
      FOR j = 2 UNTIL j > n / 2
      LET r = output[ j - 1 ] l = strlen( r ) / 2 IN
        ( shift_left(  val = substring( val = r
                                        len = l )
                                        circular = 1 ) &&
          shift_right( val = substring( val = r
                                        off = l )
                                        circular = 1 ) ) ).
    output = VALUE #(
      LET n = strlen( output[ 1 ] ) IN
      BASE output
      FOR j = n / 2 + 1 UNTIL j > n - 1
      LET r = output[ j - 1 ] l = strlen( r ) / 2 IN
        ( shift_right( val = substring( val = r
                                        len = l )
                                        circular = 1 ) &&
          shift_left(  val = substring( val = r
                                        off = l )
                                        circular = 1 ) ) ).
    cl_demo_output=>display( output ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
