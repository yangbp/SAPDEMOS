REPORT demo_shared_objects.

CLASS demo_flight_list_handler DEFINITION FINAL CREATE PRIVATE.
  PUBLIC SECTION.
    CLASS-DATA flight_list_handler
    TYPE REF TO demo_flight_list_handler.
    CLASS-METHODS class_constructor.
    METHODS get_flight_list
      RETURNING
        VALUE(flights) TYPE REF TO spfli_tab
      RAISING
       cx_no_flights.
  PRIVATE SECTION.
    DATA area_handle TYPE REF TO cl_demo_flights.
    METHODS create_flight_list
      RAISING
        cx_shm_attach_error
        cx_no_flights.
ENDCLASS.

CLASS demo_flight_list_handler IMPLEMENTATION.
  METHOD class_constructor.
    CREATE OBJECT flight_list_handler.
  ENDMETHOD.
  METHOD get_flight_list.
    DATA flight_list TYPE REF TO cl_demo_flight_list.
    IF area_handle IS INITIAL.
      TRY.
          area_handle = cl_demo_flights=>attach_for_read( ).
        CATCH cx_shm_attach_error.
          TRY.
              me->create_flight_list( ).
              area_handle = cl_demo_flights=>attach_for_read( ).
            CATCH cx_shm_attach_error.
              CREATE OBJECT flight_list.
              flight_list->set_flight_list( ).
          ENDTRY.
      ENDTRY.
    ENDIF.
    IF area_handle IS NOT INITIAL.
      flights = REF #( area_handle->root->flight_list ).
    ELSEIF flight_list IS NOT INITIAL.
      flights = REF #( flight_list->flight_list ).
    ELSE.
      RAISE EXCEPTION TYPE cx_no_flights.
    ENDIF.
  ENDMETHOD.
  METHOD create_flight_list.
    DATA: flight_list  TYPE REF TO cl_demo_flight_list,
          exc_ref      TYPE REF TO cx_no_flights.
    DATA(area_handle) = cl_demo_flights=>attach_for_write( ).
    CREATE OBJECT flight_list AREA HANDLE area_handle.
    area_handle->set_root( flight_list ).
    TRY.
        flight_list->set_flight_list( ).
      CATCH cx_no_flights INTO exc_ref.
        area_handle->detach_rollback( ).
        RAISE EXCEPTION exc_ref.
    ENDTRY.
    area_handle->detach_commit( ).
  ENDMETHOD.
ENDCLASS.

CLASS shm_demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.
CLASS shm_demo IMPLEMENTATION.
  METHOD main.
    DATA: flight_list_handler TYPE REF TO demo_flight_list_handler,
          flight_list TYPE REF TO spfli_tab.
    flight_list_handler =
      demo_flight_list_handler=>flight_list_handler.
    TRY.
        flight_list = flight_list_handler->get_flight_list( ).
      CATCH cx_no_flights.
         cl_demo_output=>display_text( 'No flight list available' ).
        RETURN.
    ENDTRY.
    cl_demo_output=>display_data( flight_list->* ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  shm_demo=>main( ).
