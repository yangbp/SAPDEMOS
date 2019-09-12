REPORT demo_loop_at_itab_using_key.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    TYPES:
      BEGIN OF spfli_line,
        carrid   TYPE spfli-carrid,
        connid   TYPE spfli-connid,
        cityfrom TYPE spfli-cityfrom,
        cityto   TYPE spfli-cityto,
      END OF spfli_line.

    DATA(out) = cl_demo_output=>new( ).
    DATA output TYPE TABLE OF spfli_line WITH EMPTY KEY.

    DATA spfli_tab TYPE HASHED TABLE
                   OF spfli_line
                   WITH UNIQUE KEY primary_key
                     COMPONENTS carrid connid
                   WITH NON-UNIQUE SORTED KEY city_from_to
                     COMPONENTS cityfrom cityto
                   WITH NON-UNIQUE SORTED KEY city_to_from
                     COMPONENTS cityto cityfrom.

    FIELD-SYMBOLS <spfli> LIKE LINE OF spfli_tab.

    SELECT carrid, connid, cityfrom, cityto
           FROM spfli
           ORDER BY carrid, connid
           INTO TABLE @spfli_tab.

    CLEAR output.
    out->next_section( 'LOOP without USING KEY' ).
    LOOP AT spfli_tab ASSIGNING <spfli>.
      output = VALUE #( BASE output ( <spfli> ) ).
    ENDLOOP.
    out->write( output ).

    CLEAR output.
    out->next_section( 'LOOP with USING KEY cityfrom cityto' ).
    LOOP AT spfli_tab ASSIGNING <spfli> USING KEY city_from_to.
      output = VALUE #( BASE output ( <spfli> ) ).
    ENDLOOP.
    out->write( output ).

    CLEAR output.
    out->next_section( 'LOOP with USING KEY cityto cityfrom' ).
    LOOP AT spfli_tab ASSIGNING <spfli> USING KEY city_to_from.
      output = VALUE #( BASE output ( <spfli> ) ).
    ENDLOOP.
    out->write( output ).

    out->display( ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
