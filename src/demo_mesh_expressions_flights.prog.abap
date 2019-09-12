REPORT demo_mesh_expressions_flights.

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
                 WITH UNIQUE KEY carrid connid ,
      t_sflight  TYPE HASHED TABLE OF sflight
                 WITH UNIQUE KEY carrid connid fldate,
      t_sairport TYPE HASHED TABLE OF sairport
                 WITH UNIQUE KEY id,
      BEGIN OF MESH t_flights,
        scarr TYPE t_scarr
          ASSOCIATION _spfli TO spfli
                   ON carrid = carrid,
        spfli TYPE t_spfli
          ASSOCIATION _sflight TO sflight
                   ON carrid = carrid AND
                      connid = connid
          ASSOCIATION _sairport TO sairport
                   ON id = airpfrom,
        sflight TYPE t_sflight,
        sairport TYPE t_sairport,
      END OF MESH t_flights.
    CLASS-DATA:
      flights    TYPE t_flights,
      in         TYPE REF TO if_demo_input,
      out        TYPE REF TO if_demo_output,
      name       TYPE scarr-carrname VALUE 'Lufthansa',
      id         TYPE spfli-carrid   VALUE 'LH',
      connection TYPE spfli-connid   VALUE '0400',
      date       TYPE sflight-fldate.
    CLASS-METHODS:
      input.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    input( ).

    TRY.

        out->begin_section(
          'Forward Association scarr\_spfli' ).
        DATA(spfli_wa) =
          flights-scarr\_spfli[ flights-scarr[ carrname = name ]
                                  connid = connection ].
        out->write( spfli_wa ).

        out->next_section(
          'Inverse Association spfli\^_spfli~scarr' ).
        DATA(scarr_wa) =
          flights-spfli\^_spfli~scarr[
            flights-spfli[ carrid = ID connid = CONNECTION ] ].
        out->write( scarr_wa ).

        out->next_section(
          'Chained Association scarr\_spfli\_sflight' ).
        DATA(sflight_wa) =
          flights-scarr\_spfli[ flights-scarr[ carrname = name ]
                                  connid = connection
                                ]\_sflight[ fldate = date ].
        out->write( sflight_wa ).

        out->next_section(
          'Addressing Component' ).
        DATA(price) =
          flights-scarr\_spfli[ flights-scarr[ carrname = name ]
                                  connid = connection
                                ]\_sflight[ fldate = date ]-price.
        out->write( price ).

        out->next_section(
          'Assigning to Field Symbol' ).
        ASSIGN
          flights-scarr\_spfli[ flights-scarr[ carrname = NAME ]
                                  connid = CONNECTION
                                ]\_sflight[ fldate = DATE ]
          TO FIELD-SYMBOL(<sflight_wa>).
        IF sy-subrc = 0.
          out->write( 'Field symbol OK' ).
        ENDIF.

        out->next_section(
          'Write Access and Check Existence' ).
        flights-scarr\_spfli[ flights-scarr[ carrname = NAME ]
                                connid = CONNECTION
                              ]\_sflight[ fldate = DATE
                              ]-price = price - 10.
        IF line_exists(
          flights-scarr\_spfli[ flights-scarr[ carrname = name ]
                                  connid = connection
                                ]\_sflight[ fldate = date
                                              price = price - 10 ] ).
          out->write( 'Line found!' ).
        ENDIF.
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
    TRY.
        date = flights-sflight[ carrid = id
                                connid = connection ]-fldate.
      CATCH cx_sy_itab_line_not_found.
        LEAVE PROGRAM.
    ENDTRY.
    in->add_field( CHANGING  field = name
     )->add_field( CHANGING  field = connection
     )->add_field( CHANGING  field = id
     )->add_field( CHANGING  field = date
     )->request( ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
