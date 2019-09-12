REPORT demo_tab_exp_line.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS: class_constructor,
                   main.
  PRIVATE SECTION.
    CLASS-DATA
      flight_tab
        TYPE STANDARD TABLE OF spfli
        WITH EMPTY KEY
        WITH UNIQUE HASHED KEY id COMPONENTS carrid connid
        WITH NON-UNIQUE SORTED KEY cities COMPONENTS cityfrom cityto.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    TRY.
        DATA(out) = cl_demo_output=>new(
          )->begin_section(
          `Primary index line 1`
          )->write(
            flight_tab[ 1 ] ).

        out->next_section(
          `Secondary index CITIES line 1`
          )->write(
            flight_tab[ KEY cities INDEX 1 ] ).

        out->next_section(
          `Free key CARRID, CONNID not optimized`
          )->write(
            flight_tab[ carrid = 'UA'
                        connid = '0941' ] ) ##primkey[id].

        out->next_section(
          `Secondary key ID optimized`
          )->write(
            flight_tab[ KEY id COMPONENTS carrid = 'UA'
                                          connid = '0941' ] ).

        out->next_section(
          `Secondary key CITIES optimized`
          )->write(
            flight_tab[ KEY cities cityfrom = 'FRANKFURT'
                                   cityto   = 'NEW YORK' ] ).

      CATCH cx_sy_itab_line_not_found.
        out->write( `Nothing found` ).
    ENDTRY.
    out->display( ).
  ENDMETHOD.
  METHOD class_constructor.
    SELECT *
           FROM spfli
           ORDER BY carrid, connid
           INTO TABLE @flight_tab.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
