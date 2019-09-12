REPORT demo_loop_group_by_values.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS:
      main,
      initialize.
  PRIVATE SECTION.
    CLASS-DATA:
      carrier TYPE spfli-carrid VALUE 'LH',
      flights TYPE TABLE OF spfli WITH EMPTY KEY.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    initialize( ).
    DATA(out) = cl_demo_output=>new( ).

    out->begin_section( `Flights` ).
    out->write( flights ).
    out->begin_section( `Grouping` ).
    DATA members LIKE flights.
    LOOP AT flights INTO DATA(flight)
         GROUP BY ( carrier = flight-carrid cityfr = flight-cityfrom
                    size = GROUP SIZE index = GROUP INDEX )
                  ASCENDING
                  REFERENCE INTO DATA(group_ref).
      out->begin_section(
        |Group Key: { group_ref->carrier }, { group_ref->cityfr }| ).
      out->write(
        |Group Size: {  group_ref->size  }, | &&
        |Group Index: { group_ref->index }| ).
      CLEAR members.
      LOOP AT GROUP group_ref ASSIGNING FIELD-SYMBOL(<flight>).
        members = VALUE #( BASE members ( <flight> ) ).
      ENDLOOP.
      out->write( members )->end_section( ).
    ENDLOOP.

    out->display( ).
  ENDMETHOD.
  METHOD initialize.
    cl_demo_input=>request( CHANGING field = carrier ).
    carrier = to_upper( carrier ).
    SELECT * FROM spfli
             WHERE carrid = @carrier
             INTO TABLE @flights.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
