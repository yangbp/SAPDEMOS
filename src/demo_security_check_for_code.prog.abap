REPORT demo_security_check_for_code.

TYPES source_code TYPE c LENGTH 255.

DATA: source_code  TYPE TABLE OF source_code,
      declarations TYPE TABLE OF source_code,
      black_list   TYPE cl_demo_secure_abap_code=>string_table,
      white_list   TYPE cl_demo_secure_abap_code=>string_table.

DATA(out) = cl_demo_output=>new( ).

APPEND `->` TO  black_list.
APPEND `=>` TO  black_list.

* Demo 1

APPEND `DATA`  TO white_list.
APPEND `DO`    TO white_list.
APPEND `ENDDO` TO white_list.

source_code = VALUE #( ( CONV source_code( 'DATA number TYPE i.' ) )
                       ( CONV source_code( 'DO 10 TIMES.' ) )
                       ( CONV source_code( '  number = number + sy-index.' ) )
                       ( CONV source_code( 'ENDDO.' ) ) ).

IF cl_demo_secure_abap_code=>check( source_code = source_code
                                    black_list  = black_list
                                    white_list  = white_list ) = 0.
  out->write( 'Demo 1 OK' ).
ELSE.
  out->write( 'Demo 1 not OK' ).
ENDIF.

* Demo 2

source_code = VALUE #( ( CONV source_code( 'DATA number TYPE i.' ) )
                       ( CONV source_code( 'DO 10 TIMES.' ) )
                       ( CONV source_code( '  number = number + forbidden_class=>get_from_forbidden_table( ).' ) )
                       ( CONV source_code( 'ENDDO.' ) ) ).

IF cl_demo_secure_abap_code=>check( source_code = source_code
                                    black_list  = black_list
                                    white_list  = white_list ) = 0.
  out->write( 'Demo 2 OK' ).
ELSE.
  out->write( 'Demo 2 not OK' ).
ENDIF.


* Demo 3

CLEAR white_list.
APPEND `INSERT` TO white_list.

source_code = VALUE #( ( CONV source_code( 'INSERT wa INTO tab.' ) ) ).

IF cl_demo_secure_abap_code=>check( source_code = source_code
                                    black_list  = black_list
                                    white_list  = white_list ) = 0.
  out->write( 'Demo 3 OK' ).
ELSE.
  out->write( 'Demo 3 not OK' ).
ENDIF.

* Demo 4

APPEND `DATA tab TYPE TABLE OF line.` TO declarations.

IF cl_demo_secure_abap_code=>check( source_code  = source_code
                                    black_list   = black_list
                                    white_list   = white_list
                                    declarations = declarations ) = 0.
  out->write( 'Demo 4 OK' ).
ELSE.
  out->write( 'Demo 4 not OK' ).
ENDIF.

out->display( ).
