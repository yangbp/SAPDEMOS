REPORT demo_select_inline_declaration.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.

    TYPES BEGIN OF output_line.
    INCLUDE TYPE scarr AS scarr RENAMING WITH SUFFIX _scarr.
    INCLUDE TYPE spfli AS spfli RENAMING WITH SUFFIX _spfli.
    TYPES END OF output_line.
    TYPES output TYPE STANDARD TABLE OF output_line WITH EMPTY KEY.

    data carrier type scarr-carrid VALUE 'LH'.
    cl_demo_input=>request( CHANGING field = carrier ).

    SELECT *
       FROM scarr INNER JOIN spfli ON scarr~carrid = spfli~carrid
       WHERE scarr~carrid = @carrier
       ORDER BY scarr~carrid
       INTO TABLE @DATA(itab).

    SELECT scarr~*, spfli~*
       FROM scarr INNER JOIN spfli ON scarr~carrid = spfli~carrid
       WHERE scarr~carrid = @carrier
       ORDER BY scarr~carrid
       INTO TABLE @DATA(jtab).

    ASSERT itab = jtab.

    cl_demo_output=>write( name = 'OUTPUT1' data =
      VALUE output( FOR wa IN itab ( scarr = wa-scarr
                                     spfli = wa-spfli ) ) ).

    SELECT scarr~carrname,
           spfli~connid, spfli~cityfrom, spfli~cityto
       FROM scarr INNER JOIN spfli ON scarr~carrid = spfli~carrid
       WHERE scarr~carrid = @carrier
       ORDER BY scarr~carrid
       INTO TABLE @DATA(output2).

    cl_demo_output=>display( output2 ).

  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
