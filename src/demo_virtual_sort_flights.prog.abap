REPORT demo_virtual_sort_flights.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    TYPES:
      BEGIN OF flight,
        carrid   TYPE s_carr_id,
        connid   TYPE s_conn_id,
        cityfrom TYPE s_city,
        cityto   TYPE s_city,
      END OF flight,
      flights TYPE STANDARD TABLE OF flight
              WITH EMPTY KEY,
      BEGIN OF city,
        city      TYPE  s_city,
        latitude  TYPE  s_lati,
        longitude TYPE  s_long,
      END OF city,
      cities TYPE STANDARD TABLE OF city
                  WITH EMPTY KEY.
    CLASS-DATA:
      flight_tab    TYPE flights,
      from_city_tab TYPE cities,
      to_city_tab   TYPE cities.
    CLASS-METHODS:
      main,
      class_constructor.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    cl_demo_output=>new(

      )->next_section(
      `Ascending Sort by Latitude, Longitude of CITYFROM, CITYTO`

      )->write( VALUE flights(
                  FOR <idx>
                  IN cl_abap_itab_utilities=>virtual_sort(
                       im_virtual_source =
                         VALUE #(
                           ( source     = REF #( from_city_tab )
                             components =
                               VALUE #( ( name = 'latitude' )
                                        ( name = 'longitude' ) ) )
                           ( source     = REF #( to_city_tab )
                             components =
                               VALUE #( ( name = 'latitude' )
                                        ( name = 'longitude' ) ) )
                           ( source     = REF #( flight_tab )
                             components =
                               VALUE #( ( name = 'carrid' )
                                        ( name = 'connid' ) ) ) ) )
                  ( flight_tab[ <idx> ] ) )

      )->next_section(
      `Descending Sort by Latitude, Longitude of CITYFROM, CITYTO`

      )->write( VALUE flights(
                  FOR <idx>
                  IN cl_abap_itab_utilities=>virtual_sort(
                       im_virtual_source =
                         VALUE #(
                           ( source     = REF #( from_city_tab )
                             components =
                               VALUE #( ( name = 'latitude'
                                          descending = abap_true )
                                        ( name = 'longitude'
                                          descending = abap_true ) ) )
                           ( source     = REF #( to_city_tab )
                             components =
                               VALUE #( ( name = 'latitude'
                                          descending = abap_true )
                                        ( name = 'longitude'
                                          descending = abap_true ) ) )
                           ( source     = REF #( flight_tab )
                             components =
                               VALUE #( ( name = 'carrid' )
                                        ( name = 'connid' ) ) ) ) )
                  ( flight_tab[ <idx> ] ) )

      )->display( ).
  ENDMETHOD.
  METHOD class_constructor.
    SELECT carrid, connid, cityfrom, cityto
           FROM spfli
           INTO CORRESPONDING FIELDS OF TABLE @flight_tab.

    SELECT city, latitude, longitude
           FROM sgeocity
           INTO TABLE @DATA(cities).

    from_city_tab = VALUE #( FOR <fs> IN flight_tab
                             ( cities[ city = <fs>-cityfrom ] ) ).
    to_city_tab   = VALUE #( FOR <fs> IN flight_tab
                             ( cities[ city = <fs>-cityto ] ) ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
