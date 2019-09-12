REPORT demo_transaction_service.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS: main,
      class_constructor.
ENDCLASS.

CLASS th DEFINITION.
  PUBLIC SECTION.
    METHODS handle FOR EVENT finished OF if_os_transaction
      IMPORTING status.
ENDCLASS.

CLASS th IMPLEMENTATION.
  METHOD handle.
    IF status = oscon_tstatus_fin_success.
      MESSAGE 'Update commited ...' TYPE 'I'.
    ENDIF.
  ENDMETHOD.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD class_constructor.
    cl_os_system=>init_and_set_modes(
      i_external_commit = oscon_false
      i_update_mode = oscon_dmode_default ).
  ENDMETHOD.
  METHOD main.

    DATA(t) = cl_os_system=>get_transaction_manager(
      )->create_transaction( ).

    DATA(h) = NEW th( ).
    SET HANDLER h->handle FOR t.

    DATA(wa_spfli) = VALUE spfli(
      carrid     = 'LH'
      connid     = '123' ).

    TRY.

        t->start( ).

        DATA(connection) = ca_spfli_persistent=>agent->get_persistent(
          i_carrid = wa_spfli-carrid
          i_connid = wa_spfli-connid ).
        wa_spfli = VALUE #( BASE wa_spfli
          deptime = connection->get_deptime( ) + 3600
          arrtime = connection->get_arrtime( ) + 3600 ).
        connection->set_deptime( wa_spfli-deptime ).
        connection->set_arrtime( wa_spfli-arrtime ).

        t->end( ).

      CATCH cx_root INTO DATA(exc).
        MESSAGE exc->get_text( ) TYPE 'I'.
    ENDTRY.

  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
