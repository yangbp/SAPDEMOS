REPORT demo_for_groups_by_values.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS:
      main,
      initialize.
  PRIVATE SECTION.
    TYPES spfli_tab TYPE STANDARD TABLE OF spfli WITH EMPTY KEY.
    CLASS-DATA:
      carrier TYPE spfli-carrid VALUE 'LH',
      flights TYPE spfli_tab.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    initialize( ).

    DATA out TYPE REF TO if_demo_output.
    out = REDUCE #(
      INIT o = cl_demo_output=>new(
                 )->begin_section( `Flights`
                 )->write( flights
                 )->begin_section( `Grouping` )
      FOR GROUPS group OF flight IN flights
            GROUP BY
              ( carrier = flight-carrid cityfr = flight-cityfrom
                size = GROUP SIZE index = GROUP INDEX )
            ASCENDING
      LET members = VALUE spfli_tab(
                       FOR <flight> IN GROUP group ( <flight> ) ) IN
      NEXT o = o->begin_section(
                    |Group Key: { group-carrier }, { group-cityfr }|
               )->write(
                    |Group Size: {  group-size  }, | &&
                    |Group Index: { group-index }|
               )->write( members )->end_section( ) ).

    out->display( ).
  ENDMETHOD.
  METHOD initialize.
    cl_demo_input=>request( CHANGING field = carrier ).
    carrier = to_upper( carrier ).
    SELECT *
           FROM spfli
           WHERE carrid = @carrier
           INTO TABLE @flights.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
