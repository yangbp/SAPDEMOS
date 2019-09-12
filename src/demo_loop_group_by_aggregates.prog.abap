REPORT demo_loop_group_by_aggregates.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS:
      main,
      initialize.
  PRIVATE SECTION.
    TYPES:
      BEGIN OF line,
        key TYPE i,
        num TYPE i,
      END OF line,
      itab TYPE STANDARD TABLE OF line WITH EMPTY KEY.
    CLASS-DATA
      numbers TYPE itab.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    initialize( ).

    DATA(out) = cl_demo_output=>new( ).

    DATA:
      BEGIN OF aggregate,
        sum TYPE i,
        max TYPE i,
        min TYPE i,
        avg TYPE decfloat34,
      END OF aggregate.

    out->next_section( `Table`
      )->write( numbers ).

    LOOP AT numbers ASSIGNING FIELD-SYMBOL(<wa>)
         GROUP BY ( key = <wa>-key  count = GROUP SIZE )
         ASCENDING
         ASSIGNING FIELD-SYMBOL(<group_key>).

      out->next_section( |Group Key: { <group_key>-key }| ).
      aggregate = VALUE #( min = 101 ).
      DATA(members) = VALUE itab( ).
      LOOP AT GROUP <group_key> ASSIGNING FIELD-SYMBOL(<member>).
        members = VALUE #( BASE members ( <member> ) ).
        aggregate-sum = aggregate-sum + <member>-num.
        aggregate-max = nmax( val1 = aggregate-max
                              val2 = <member>-num ).
        aggregate-min = nmin( val1 = aggregate-min
                              val2 = <member>-num ).
      ENDLOOP.
      aggregate-avg = aggregate-sum / <group_key>-count.
      SORT members BY num DESCENDING.
      out->write( members
        )->write( aggregate ).
    ENDLOOP.
    out->display( ).
  ENDMETHOD.
  METHOD initialize.
    DATA(keys) = 3.
    cl_demo_input=>add_field( CHANGING field = keys ).
    DATA(lines) = 10.
    cl_demo_input=>request( CHANGING field = lines ).
    IF keys <= 0 OR lines <= 0.
      RETURN.
    ENDIF.

    DATA(rnd_key) = cl_abap_random_int=>create(
      seed = CONV i( sy-uzeit ) min = 1 max = keys ).
    DATA(rnd_num) = cl_abap_random_int=>create(
      seed = sy-uzeit + 1 min = 1 max = 100 ).
    numbers = VALUE #( FOR j = 1 UNTIL j > lines
                       ( key = rnd_key->get_next( )
                         num = rnd_num->get_next( ) ) ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
