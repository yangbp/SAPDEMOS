REPORT demo_filter_table.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-DATA:
      cityfrom TYPE spfli-cityfrom VALUE 'Frankfurt',
      cityto   TYPE spfli-cityto   VALUE 'New York'.
    CLASS-METHODS:
      main,
      init.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    init( ).

    TYPES: BEGIN OF filter,
             cityfrom TYPE spfli-cityfrom,
             cityto   TYPE spfli-cityto,
           END OF filter,
           filter_tab TYPE HASHED TABLE OF filter
                 WITH UNIQUE KEY cityfrom cityto.

    DATA(filter_tab) = VALUE filter_tab(
        ( cityfrom = cityfrom cityto = cityto )
        ( cityfrom = cityto   cityto = cityfrom ) ).

    SELECT carrid, connid, cityfrom, cityto
          FROM spfli
          ORDER BY carrid, connid, cityfrom, cityto
          INTO TABLE @DATA(spfli_tab).

    cl_demo_output=>display(
      FILTER #( spfli_tab IN filter_tab
                  WHERE cityfrom = cityfrom  AND cityto = cityto ) ).
  ENDMETHOD.
  METHOD init.
    cl_demo_input=>add_field( CHANGING field = cityfrom ).
    cl_demo_input=>request(   CHANGING field = cityto ).
    cityfrom = to_upper( cityfrom ).
    cityto = to_upper( cityto ).
    IF cityfrom = cityto.
      LEAVE PROGRAM.
    ENDIF.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
