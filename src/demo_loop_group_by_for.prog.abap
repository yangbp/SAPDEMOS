REPORT demo_loop_group_by_for.

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
      DATA(members) = VALUE itab( FOR m IN GROUP <group_key> ( m ) ).
      aggregate-sum = REDUCE i( INIT sum = 0
                                FOR m IN GROUP <group_key>
                                NEXT sum = sum + m-num ).
      aggregate-max = REDUCE i( INIT max = 0
                                FOR m IN GROUP <group_key>
                                NEXT max = nmax( val1 = max
                                                 val2 = m-num ) ).
      aggregate-min = REDUCE i( INIT min = 101
                                FOR m IN GROUP <group_key>
                                NEXT min = nmin( val1 = min
                                                 val2 = m-num ) ).
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
      seed =  sy-uzeit + 1  min = 1 max = 100 ).
    numbers = VALUE #( FOR j = 1 UNTIL j > lines
                       ( key = rnd_key->get_next( )
                         num = rnd_num->get_next( ) ) ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
