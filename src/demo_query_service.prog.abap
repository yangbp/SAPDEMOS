REPORT demo_query_service.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA: airpfrom TYPE s_fromairp VALUE 'FRA',
          airpto   TYPE s_toairp   VALUE 'SIN'.

    cl_demo_input=>new(
      )->add_field( CHANGING field = airpfrom
      )->add_field( CHANGING field = airpto )->request( ).

    TYPES: BEGIN OF result,
             carrid TYPE s_carr_id,
             connid TYPE s_conn_id,
           END OF result,
           results TYPE TABLE OF result WITH EMPTY KEY.

    TRY.
        DATA(query) = cl_os_system=>get_query_manager( )->create_query(
          i_filter  = `AIRPFROM = PAR1 AND AIRPTO = PAR2` ).

        DATA(agent) = ca_spfli_persistent=>agent.
        cl_demo_output=>display(
          VALUE results(
            FOR <connection>
            IN agent->if_os_ca_persistency~get_persistent_by_query(
              i_query   = query
              i_par1    = airpfrom
              i_par2    = airpto )
              ( carrid = CAST cl_spfli_persistent(
                                <connection> )->get_carrid( )
                connid = CAST cl_spfli_persistent(
                                <connection> )->get_connid( ) ) ) ).
      CATCH cx_root INTO DATA(exc).
        cl_demo_output=>display( exc->get_text( ) ).
    ENDTRY.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
