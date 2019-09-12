REPORT demo_for_groups_by_aggregates.

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
    CLASS-METHODS sort
      IMPORTING itab        TYPE itab
      RETURNING VALUE(rtab) TYPE itab.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    TYPES:
      BEGIN OF aggregate,
        sum TYPE i,
        max TYPE i,
        min TYPE i,
        avg TYPE decfloat34,
      END OF aggregate.
    DATA out TYPE REF TO if_demo_output.

    initialize( ).

    out = REDUCE #(
      INIT o = cl_demo_output=>new(
                 )->next_section( `Table` )->WRITE( numbers )
           aggregate = VALUE aggregate( )
           MEMBERS   = VALUE itab( )
      FOR GROUPS <group_key> OF <wa> IN numbers
            GROUP BY ( key = <wa>-key count = GROUP SIZE )
            ASCENDING
      NEXT aggregate = VALUE #(
             sum = REDUCE i( INIT SUM = 0
                     FOR m IN GROUP <group_key>
                     NEXT sum = sum + m-num )
             max = REDUCE i( INIT max = 0
                     FOR m IN GROUP <group_key>
                     NEXT max = nmax( val1 = max
                                      val2 = m-num ) )
             min = REDUCE i( INIT MIN = 101
                     FOR m IN GROUP <group_key>
                     NEXT min = nmin( val1 = min
                                val2 = m-num ) )
             avg = aggregate-sum / <group_key>-count )
           members = sort(
                       VALUE itab( FOR m IN GROUP <group_key> ( m ) ) )
           o = o->next_section( |Group Key: { <group_key>-key }|
             )->WRITE( MEMBERS
             )->WRITE( aggregate ) ).

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
  METHOD sort.
    rtab = itab.
    SORT rtab  BY num DESCENDING.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
