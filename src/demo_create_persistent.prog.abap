REPORT demo_create_persistent.

SELECTION-SCREEN BEGIN OF SCREEN 400 TITLE text-400.
PARAMETERS delete AS CHECKBOX.
SELECTION-SCREEN END OF SCREEN 400.
SELECTION-SCREEN BEGIN OF SCREEN 500 TITLE text-500.
PARAMETERS commit AS CHECKBOX.
SELECTION-SCREEN END OF SCREEN 500.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.

    DATA(wa_spfli) = VALUE spfli(
      carrid     = 'LH'
      connid     = '123'
      countryfr  = 'DE'
      cityfrom   = 'FRANKFURT'
      airpfrom   = 'FRA'
      countryto  = 'SG'
      cityto     = 'SINGAPORE'
      airpto     = 'SIN'
      fltime     = '740'
      deptime    = '234500'
      arrtime    = '180000'
      distance   = '10000'
      distid     = 'KM'
      fltype     = ' '
      period     = '1' ).

    DATA(agent) = ca_spfli_persistent=>agent.
    TRY.
        DATA(connection) =
          agent->get_persistent( i_carrid = wa_spfli-carrid
                                 i_connid = wa_spfli-connid ).
        MESSAGE 'Connection already exists' TYPE 'I'.
        CALL SELECTION-SCREEN 400 STARTING AT 10 10.
        IF delete = 'X'.
          TRY.
              agent->delete_persistent( i_carrid = wa_spfli-carrid
                                        i_connid = wa_spfli-connid ).
              COMMIT WORK.
            CATCH cx_root INTO DATA(exc).
              MESSAGE exc->get_text( ) TYPE 'I'.
          ENDTRY.
        ENDIF.
      CATCH cx_root INTO exc.
        MESSAGE exc->get_text( ) TYPE 'I'.
        TRY.
            connection = agent->create_persistent(
                           i_carrid = wa_spfli-carrid
                           i_connid = wa_spfli-connid
                           i_countryfr = wa_spfli-countryfr
                           i_cityfrom = wa_spfli-cityfrom
                           i_airpfrom = wa_spfli-airpfrom
                           i_countryto = wa_spfli-countryto
                           i_cityto = wa_spfli-cityto
                           i_airpto = wa_spfli-airpto
                           i_fltime = wa_spfli-fltime
                           i_deptime = wa_spfli-deptime
                           i_arrtime = wa_spfli-arrtime
                           i_distance = wa_spfli-distance
                           i_distid = wa_spfli-distid
                           i_fltype = wa_spfli-fltype
                           i_period = wa_spfli-period            ).
            MESSAGE 'Connection created' TYPE 'I'.
            CALL SELECTION-SCREEN 500 STARTING AT 10 10.
            IF commit = 'X'.
              COMMIT WORK.
            ENDIF.
          CATCH cx_root INTO exc.
            MESSAGE exc->get_text( ) TYPE 'I'.
        ENDTRY.
    ENDTRY.

  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
