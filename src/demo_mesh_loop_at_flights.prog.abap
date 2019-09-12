REPORT demo_mesh_loop_at_flights.

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
        scarr TYPE t_scarr
          ASSOCIATION _spfli TO spfli
                   ON carrid = carrid USING KEY carrid,
        spfli TYPE t_spfli
          ASSOCIATION _sflight TO sflight
                   ON carrid = carrid AND
                      connid = connid USING KEY carrid_connid
          ASSOCIATION _sairport TO sairport
                   ON id = airpfrom,
        sflight TYPE t_sflight,
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
        LOOP AT
          flights-scarr\_spfli[ flights-scarr[ carrname = name ]
                                  WHERE countryto = country  ]
             INTO DATA(spfli_wa).
          out->write( spfli_wa ).
        ENDLOOP.

        out->next_section(
          'Chained Association SCARR\_spfli\_sairport' ).
        LOOP AT
          flights-scarr\_spfli[ flights-scarr[ carrname = name ]
                                  WHERE countryto = country
                                ]\_sairport[ USING KEY primary_key ]
             INTO DATA(sairport_wa).
          out->write( sairport_wa ).
        ENDLOOP.

        out->next_section(
          'Chained Association' &&
          ' SCARR\_spfli\_sflight\^_sflight~spfli' ).
        LOOP AT
          flights-scarr\_spfli[ flights-scarr[ carrname = name ]
                                  WHERE countryto = country
                                ]\_sflight[
                                  WHERE planetype = plane1 OR
                                        planetype = plane2
                                ]\^_sflight~spfli[ ]
             ASSIGNING FIELD-SYMBOL(<spfli_wa>).
          out->write( <spfli_wa> ).
        ENDLOOP.

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
