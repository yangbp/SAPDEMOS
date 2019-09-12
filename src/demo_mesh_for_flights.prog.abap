REPORT demo_mesh_for_flights.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS:
      main,
      class_constructor.
  PRIVATE SECTION.
    TYPES:
      t_scarr    TYPE HASHED TABLE OF scarr
                 WITH UNIQUE KEY carrid,
      t_spfli    TYPE HASHED TABLE OF spfli
                 WITH UNIQUE KEY carrid connid
                 WITH NON-UNIQUE SORTED KEY carrid
                                 COMPONENTS carrid,
      t_sflight  TYPE HASHED TABLE OF sflight
                 WITH UNIQUE KEY carrid connid fldate
                 WITH NON-UNIQUE SORTED KEY carrid_connid
                                 COMPONENTS carrid connid,
      t_sairport TYPE HASHED TABLE OF sairport
                 WITH UNIQUE KEY id,
      BEGIN OF MESH t_flights,
        scarr    TYPE t_scarr
           ASSOCIATION _spfli TO spfli
                    ON carrid = carrid USING KEY carrid,
        spfli    TYPE t_spfli
           ASSOCIATION _sflight TO sflight
                    ON carrid = carrid AND
                       connid = connid USING KEY carrid_connid
           ASSOCIATION _sairport TO sairport
                    ON id = airpfrom,
        sflight  TYPE t_sflight,
        sairport TYPE t_sairport,
      END OF MESH t_flights.
    CLASS-DATA:
      flights TYPE t_flights,
      in      TYPE REF TO if_demo_input,
      out     TYPE REF TO if_demo_output,
      name    TYPE scarr-carrname VALUE 'United Airlines',
      country TYPE spfli-countryto VALUE 'US',
      plane1  TYPE sflight-planetype VALUE '747-400',
      plane2  TYPE sflight-planetype VALUE 'A310-300'.
    CLASS-METHODS:
      input.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    input( ).

    TRY.

        out->begin_section(
          'Initial Association SCARR\_spfli' ).
        DATA(spfli_tab) = VALUE t_spfli(
          FOR spfli_wa IN
            flights-scarr\_spfli[ flights-scarr[ carrname = name ]
                                    WHERE countryto = country ]
             ( spfli_wa ) ).
        out->write( spfli_tab ).
        DATA(distance) = REDUCE spfli-distance(
          INIT d TYPE spfli-distance
          FOR spfli_wa IN
            flights-scarr\_spfli[ flights-scarr[ carrname = name ]
                                    WHERE countryto = country ]
             NEXT d = d + SWITCH spfli-distance( spfli_wa-distid
                                    WHEN 'KM'
                                      THEN spfli_wa-distance * '1.60934'
                                    WHEN 'MI'
                                      THEN spfli_wa-distance
                                    ELSE 0 ) ).
        out->write( |Sum of distances in miles: { distance }| ).

        out->next_section(
          'Chained Association SCARR\_spfli\_sairport' ).
        DATA(sairport_tab) = VALUE t_sairport(
          FOR sairport_wa IN
            flights-scarr\_spfli[ flights-scarr[ carrname = name ]
                                    WHERE countryto = country
                                   ]\_sairport[
                                     USING KEY primary_key ]
            ( sairport_wa ) ).
        out->write( sairport_tab ).

        out->next_section(
          'Chained Association' &&
          ' SCARR\_spfli\_sflight\^_sflight~spfli' ).
        spfli_tab = VALUE t_spfli(
          FOR spfli_wa IN
            flights-scarr\_spfli[ flights-scarr[ carrname = name ]
                                    WHERE countryto = country
                                  ]\_sflight[
                                    WHERE planetype = plane1 OR
                                          planetype = plane2
                                  ]\^_sflight~spfli[ ]
             ( spfli_wa ) ).
        out->write( spfli_tab ).

      CATCH cx_sy_itab_line_not_found.
        out->write( 'Exception!' ).
    ENDTRY.
    out->display( ).
  ENDMETHOD.
  METHOD class_constructor.
    in  = cl_demo_input=>new( ).
    out = cl_demo_output=>new( ).

    SELECT *
           FROM scarr
           INTO TABLE @flights-scarr.
    SELECT *
           FROM spfli
           INTO TABLE @flights-spfli.
    SELECT *
           FROM sflight
           INTO TABLE @flights-sflight.
    SELECT *
           FROM sairport
           INTO TABLE @flights-sairport.

  ENDMETHOD.
  METHOD input.
    in->add_field( CHANGING field = name
     )->add_field( CHANGING field = country
     )->add_field( CHANGING field = plane1
     )->add_field( CHANGING field = plane2
     )->request( ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
