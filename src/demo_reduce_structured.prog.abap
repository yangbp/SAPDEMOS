REPORT demo_reduce_structured.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS:
      main,
      class_constructor.
  PRIVATE SECTION.
    TYPES:
      BEGIN OF line,
        id  TYPE string,
        num TYPE i,
      END OF line,
      BEGIN OF result,
        text TYPE string,
        sum  TYPE i,
        max  TYPE i,
      END OF result.
    CLASS-DATA
      itab TYPE TABLE OF line WITH EMPTY KEY.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    cl_demo_output=>write( itab ).

    DATA(result) = REDUCE result(
                     INIT res = VALUE result( max  = 0
                                              text = `Result: ` )
                          sep  = ``
                     FOR <wa> IN itab
                     NEXT res-text = res-text && sep
                                              && <wa>-id
                          res-sum = res-sum + <wa>-num
                          res-max = nmax( val1 = res-max
                                          val2 = <wa>-num )
                          sep     = `-` ).

    cl_demo_output=>display( result ).
  ENDMETHOD.
  METHOD class_constructor.
    DATA(rnd) = cl_abap_random_int=>create( seed = CONV i( sy-uzeit )
                                            min  = 0
                                            max  = 1000 ).
    itab = VALUE #( FOR j = 0 UNTIL j > 9
                    ( id  = sy-abcde+j(1)
                      num = rnd->get_next( ) ) ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
