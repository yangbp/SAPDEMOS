REPORT demo_round_and_rescale.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
  PRIVATE SECTION.
    TYPES:
      BEGIN OF line,
        arg       TYPE i,
        result    TYPE decfloat34,
        scale     TYPE i,
        precision TYPE i,
      END OF line,
      result TYPE STANDARD TABLE OF line WITH EMPTY KEY.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA(val) = CONV decfloat34( '1234.56789 ' ).
    DATA(out) = cl_demo_output=>new(
      )->begin_section( 'Value'
      )->write(
        |{ val
         }, scale = { cl_abap_math=>get_scale( val )
         }, precision = { cl_abap_math=>get_number_of_digits( val ) }|
      )->begin_section( 'Round with dec'
      )->write(
       REDUCE result(
         INIT tab TYPE result
         FOR i = -5 UNTIL i > 6
         LET rddec = round( val = val dec = i
             mode  = cl_abap_math=>round_half_up ) IN
         NEXT tab = VALUE #( BASE tab
          ( arg = i
            result = rddec
            scale = cl_abap_math=>get_scale( rddec )
            precision = cl_abap_math=>get_number_of_digits( rddec )
          ) ) )
      )->next_section( 'Round with prec'
      )->write(
       REDUCE result(
         INIT tab TYPE result
         FOR i = 1  UNTIL i > 10
         LET rdprec = round( val = val prec = i
             mode   = cl_abap_math=>round_half_up ) IN
         NEXT tab = VALUE #( BASE tab
          ( arg = i
            result = rdprec
            scale = cl_abap_math=>get_scale( rdprec )
            precision = cl_abap_math=>get_number_of_digits( rdprec )
          ) ) )
      )->next_section( 'Rescale with dec'
      )->write(
       REDUCE result(
         INIT tab TYPE result
         FOR i = -5 UNTIL i > 8
         LET rsdec = rescale( val = val dec = i
             mode  = cl_abap_math=>round_half_up ) IN
         NEXT tab  = VALUE #( BASE tab
          ( arg = i
            result = rsdec
            scale = cl_abap_math=>get_scale( rsdec )
            precision = cl_abap_math=>get_number_of_digits( rsdec )
          ) ) )
      )->next_section( 'Rescale with prec'
      )->write(
       REDUCE result(
         INIT tab TYPE result
         FOR i = 1  UNTIL i > 12
         LET rsprec = rescale( val = val prec = i
             mode   = cl_abap_math=>round_half_up ) IN
         NEXT tab = VALUE #( BASE tab
          ( arg = i
            result = rsprec
            scale = cl_abap_math=>get_scale( rsprec )
            precision = cl_abap_math=>get_number_of_digits( rsprec )
          ) ) )
      )->display( ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
