REPORT demo_extract_at.

DATA: spfli_wa    TYPE spfli,
      sflight_wa  TYPE sflight.

FIELD-GROUPS: header, flight_info, flight_date.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA: spfli_tab   LIKE TABLE OF spfli_wa,
          sflight_tab LIKE TABLE OF sflight_wa.

    INSERT: spfli_wa-carrid spfli_wa-connid sflight_wa-fldate
              INTO header,
            spfli_wa-cityfrom spfli_wa-cityto
              INTO flight_info.

    SELECT *
           FROM spfli
           INTO TABLE @spfli_tab.

    SELECT *
           FROM sflight
           INTO TABLE @sflight_tab.

    LOOP AT spfli_tab INTO spfli_wa.
      sflight_wa-fldate = '--------'.
      EXTRACT flight_info.
      LOOP AT sflight_tab INTO sflight_wa
              WHERE carrid = spfli_wa-carrid AND
                    connid = spfli_wa-connid.
        EXTRACT flight_date.
      ENDLOOP.
    ENDLOOP.

    SORT STABLE.
    LOOP.
      AT FIRST.
        DATA(out) = cl_demo_output=>new(
          )->begin_section( `Flight list`
          )->begin_section( `--------------------` ).
      ENDAT.
      AT flight_info WITH flight_date.
        out->next_section( |{ spfli_wa-carrid   } {
                              spfli_wa-connid   } {
                              spfli_wa-cityfrom } {
                              spfli_wa-cityto   }| ).
      ENDAT.
      AT flight_date.
        out->write( |{ spfli_wa-carrid   } {
                       spfli_wa-connid   } {
                       sflight_wa-fldate }| ).
      ENDAT.
      AT LAST.
        out->line( )->write( |{ cnt(spfli_wa-carrid) } Airlines| ).
      ENDAT.
    ENDLOOP.
    out->display( ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
