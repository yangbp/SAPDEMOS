REPORT demo_for_groups_by_method.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS:
      main,
      class_constructor.
  PRIVATE SECTION.
    TYPES:
      spfli_tab    TYPE STANDARD TABLE OF spfli    WITH EMPTY KEY,
      sairport_tab TYPE STANDARD TABLE OF sairport WITH EMPTY KEY.
    CLASS-DATA:
      flights  TYPE spfli_tab,
      airports TYPE sairport_tab.
    CLASS-METHODS
      get_time_zone IMPORTING id               TYPE sairport-id
                    RETURNING VALUE(time_zone) TYPE sairport-time_zone.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA out TYPE REF TO if_demo_output.

    out = REDUCE #(
      INIT o = cl_demo_output=>new( )
      FOR GROUPS <group> OF wa IN flights
            GROUP BY ( tz_from = get_time_zone( wa-airpfrom )
                       tz_to   = get_time_zone( wa-airpto )
                       size    = GROUP SIZE index = GROUP INDEX )
      LET members = VALUE spfli_tab(
                      FOR <member> IN GROUP <group> ( <member> ) ) IN
      NEXT o = o->write( name = `Group key`
                         data = <group>
               )->write( members )->line( ) ).

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
