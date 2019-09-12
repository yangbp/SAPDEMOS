REPORT demo_tab_exp_side_effect.

TYPES itab TYPE STANDARD TABLE OF i WITH EMPTY KEY.

CLASS class DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS meth IMPORTING idx          TYPE i
                                 line1        TYPE i OPTIONAL
                                 VALUE(line2) TYPE i OPTIONAL
                       CHANGING  ptab         TYPE itab.
ENDCLASS.

CLASS class IMPLEMENTATION.
  METHOD meth.
    ptab[ idx ] = 111.
    IF line1 IS SUPPLIED.
      cl_demo_output=>write_data( line1 ).
    ELSEIF line2 IS SUPPLIED.
      cl_demo_output=>write_data( line2 ).
    ENDIF.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.

  DATA(itab) = VALUE itab( ( 1 ) ( 2 ) ( 3 ) ( 4 ) ).

  class=>meth( EXPORTING idx    = 1
                         line1 = itab[ 1 ] ##operator
               CHANGING  ptab  = itab ).

  class=>meth( EXPORTING idx   = 2
                         line1 = VALUE #( itab[ 2 ] )
               CHANGING  ptab  = itab ).

  class=>meth( EXPORTING idx   = 3
                         line2 = itab[ 3 ]
               CHANGING  ptab  = itab ).

  class=>meth( EXPORTING idx   = 4
                         line2 = VALUE #( itab[ 4 ] )
               CHANGING  ptab  = itab ).

  cl_demo_output=>display( ).
