REPORT demo_corresponding_table_exp.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS:
      main,
      class_constructor.
  PRIVATE SECTION.
    CLASS-DATA:
      itab TYPE HASHED TABLE OF spfli WITH UNIQUE KEY carrid connid,
      BEGIN OF struct,
        carrid   TYPE spfli-carrid,
        connid   TYPE spfli-connid,
        cityfrom TYPE spfli-cityfrom,
        cityto   TYPE spfli-cityto,
      END OF struct,
      carrid TYPE spfli-carrid VALUE 'LH',
      connid TYPE spfli-connid VALUE '0400'.
    CLASS-METHODS
      input.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    input( ).
    TRY.

        struct =
          CORRESPONDING #( itab[ carrid = carrid connid = connid ] ).

        cl_demo_output=>display( struct ).
      CATCH cx_sy_itab_line_not_found.
        cl_demo_output=>display( 'Nothing found' ).
    ENDTRY.
  ENDMETHOD.
  METHOD class_constructor.
    SELECT *
           FROM spfli
           INTO TABLE @itab.
  ENDMETHOD.
  METHOD input.
    cl_demo_input=>add_field( CHANGING field = carrid ).
    cl_demo_input=>add_field( CHANGING field = connid ).
    cl_demo_input=>request( ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
