REPORT demo_loop_group_by_method.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS:
      main,
      class_constructor.
  PRIVATE SECTION.
    CLASS-DATA:
      flights  TYPE TABLE OF spfli    WITH EMPTY KEY,
      airports TYPE TABLE OF sairport WITH EMPTY KEY.
    CLASS-METHODS
      get_time_zone IMPORTING id               TYPE sairport-id
                    RETURNING VALUE(time_zone) TYPE sairport-time_zone.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA(out) = cl_demo_output=>new( ).

    DATA members LIKE flights.
    LOOP AT flights INTO DATA(wa)
         GROUP BY ( tz_from = get_time_zone( wa-airpfrom )
                    tz_to   = get_time_zone( wa-airpto )
                    size = GROUP SIZE index = GROUP INDEX )
         ASSIGNING FIELD-SYMBOL(<group>).
      out->write( name = `Group key`
                  data = <group> ).
      CLEAR members.
      LOOP AT GROUP <group> ASSIGNING FIELD-SYMBOL(<member>).
        members = VALUE #( BASE members ( <member> ) ).
      ENDLOOP.
      out->write( members )->line( ).
    ENDLOOP.

    out->display( ).
  ENDMETHOD.
  METHOD class_constructor.
    SELECT * FROM spfli    INTO TABLE flights.
    SELECT * FROM sairport INTO TABLE airports.
  ENDMETHOD.
  METHOD get_time_zone.
    time_zone = airports[ id = id ]-time_zone.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
