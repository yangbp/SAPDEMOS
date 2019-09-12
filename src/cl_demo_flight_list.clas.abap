class CL_DEMO_FLIGHT_LIST definition
  public
  final
  create public
  shared memory enabled .

public section.

  data FLIGHT_LIST type SPFLI_TAB read-only .

  methods SET_FLIGHT_LIST
    raising
      CX_NO_FLIGHTS .
private section.
ENDCLASS.



CLASS CL_DEMO_FLIGHT_LIST IMPLEMENTATION.


  METHOD set_flight_list.
    SELECT *
           FROM spfli
           INTO TABLE @flight_list.
    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE cx_no_flights.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
