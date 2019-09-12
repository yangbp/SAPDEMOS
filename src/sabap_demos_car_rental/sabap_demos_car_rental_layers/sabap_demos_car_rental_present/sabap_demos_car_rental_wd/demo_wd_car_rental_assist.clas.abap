class DEMO_WD_CAR_RENTAL_ASSIST definition
  public
  inheriting from CL_WD_COMPONENT_ASSISTANCE
  create public .

public section.
*"* public components of class DEMO_WD_CAR_RENTAL_ASSIST
*"* do not include other source files here!!!

  class-data CAR_RENTAL_SERVICE type ref to IF_DEMO_CR_CAR_RENTL_SERVICE .

  class-methods CLASS_CONSTRUCTOR .
  methods CREATE_CUSTOMER
    importing
      !I_CUSTOMER_NAME type DEMO_CR_CUSTOMER_NAME
    raising
      CX_DEMO_CR_CUSTOMER .
  methods GET_CUSTOMERS_BY_ID
    importing
      !I_SEARCH_ID type DEMO_CR_CUSTOMER_ID
      !I_CUSTOMER_TABLE_NODE type ref to IF_WD_CONTEXT_NODE .
  methods GET_CUSTOMERS_BY_NAME
    importing
      value(I_SEARCH_NAME) type DEMO_CR_CUSTOMER_NAME
      value(I_CUSTOMER_TABLE_NODE) type ref to IF_WD_CONTEXT_NODE .
  methods MAKE_RESERVATION
    importing
      !I_CUSTOMER_ID type DEMO_CR_CUSTOMER_ID
      !I_CATEGORY type DEMO_CR_CATEGORY
      !I_DATE_FROM type DEMO_CR_DATE_FROM
      !I_DATE_TO type DEMO_CR_DATE_TO
    raising
      CX_DEMO_CR_LOCK
      CX_DEMO_CR_NO_CUSTOMER
      CX_DEMO_CR_RESERVATION
      CX_DEMO_CR_CAR .
  methods GET_RESERVATIONS_BY_CUST_ID
    importing
      !I_RESERVATIONS type ref to IF_WD_CONTEXT_NODE
      !I_CUSTOMER_ID type DEMO_CR_CUSTOMER_ID .
  methods GET_CAR_RENTAL_SERVICE
    returning
      value(R_SERVICE) type ref to IF_DEMO_CR_CAR_RENTL_SERVICE .
protected section.
*"* protected components of class DEMO_WD_CAR_RENTAL_ASSIST
*"* do not include other source files here!!!
private section.
*"* private components of class DEMO_WD_CAR_RENTAL_ASSIST
*"* do not include other source files here!!!
ENDCLASS.



CLASS DEMO_WD_CAR_RENTAL_ASSIST IMPLEMENTATION.


method CLASS_CONSTRUCTOR.
  TRY.
      CALL METHOD cl_demo_cr_car_rental_service=>get_service
        RECEIVING
          r_service = car_rental_service.

    CATCH cx_root ##NO_HANDLER ##CATCH_ALL.
*      wd_controller->show_no_service_class( 2 ).
  ENDTRY.
endmethod.


method CREATE_CUSTOMER.

      me->car_rental_service->create_customer( i_customer_name ).


endmethod.


method GET_CAR_RENTAL_SERVICE.
  r_service = car_rental_service.
endmethod.


METHOD get_customers_by_id.

  DATA: l_customer_tab TYPE demo_cr_customers_tt,
        l_customer_wa LIKE LINE OF l_customer_tab,
        l_customer2_wa TYPE demo_cr_scustomer.

  l_customer2_wa = me->car_rental_service->get_customer_by_id( i_search_id ).

  IF l_customer2_wa IS NOT INITIAL.
    MOVE-CORRESPONDING l_customer2_wa TO l_customer_wa.
    APPEND l_customer_wa TO l_customer_tab.
  ENDIF.

  IF i_customer_table_node IS BOUND.

    i_customer_table_node->bind_table( NEW_ITEMS = l_customer_tab SET_INITIAL_ELEMENTS = ABAP_TRUE ).
  ENDIF.
ENDMETHOD.


method GET_CUSTOMERS_BY_NAME.

  data: l_customer_tab type demo_cr_customers_tt.

  l_customer_tab = me->car_rental_service->get_customers_by_name( i_search_name ).

  if i_customer_table_node is initial.
    exit.
  endif.

  i_customer_table_node->bind_table( l_customer_tab ).

endmethod.


method GET_RESERVATIONS_BY_CUST_ID.
  data: l_reservation_tab type demo_cr_reservations_tt.

  l_reservation_tab = me->car_rental_service->GET_RESERVATIONS_BY_CUST_ID( i_customer_id  ) .
  i_reservations->bind_table( l_reservation_tab ).

endmethod.


method MAKE_RESERVATION.


      me->car_rental_service->make_reservation(
        i_customer_id = i_customer_id
        i_category    = i_category
        i_date_from   = i_date_from
        i_date_to     = i_date_to
           ).

endmethod.
ENDCLASS.
