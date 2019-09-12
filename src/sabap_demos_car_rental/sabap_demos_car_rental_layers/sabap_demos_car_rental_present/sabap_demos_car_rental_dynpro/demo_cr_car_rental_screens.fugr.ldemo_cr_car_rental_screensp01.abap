*&---------------------------------------------------------------------*
*&  Include           LDEMO_CR_CAR_RENTAL_SCREENSP01
*&---------------------------------------------------------------------*

CLASS screen_handler IMPLEMENTATION.
  METHOD class_constructor.
    CALL METHOD cl_demo_cr_car_rental_service=>get_service
      RECEIVING
        r_service = car_rental_service.
  ENDMETHOD.
  METHOD status_0100.
    SET PF-STATUS 'SCREEN_100'.
    SET TITLEBAR 'CAR_RESERVATION'.
  ENDMETHOD.
  METHOD user_command_0100.
    CASE g_ok_code.
      WHEN 'CSTMR_SRCH_BY_ID'.
        screen_handler=>customer_search_by_id( ).
      WHEN 'CSTMR_SRCH_BY_NAME'.
        screen_handler=>customer_search_by_name( ).
      WHEN 'CUSTOMER_CREATE'.
        screen_handler=>customer_create( ).
      WHEN 'RESERVATION_CREATE'.
        screen_handler=>reservation_create( ).
      WHEN OTHERS.
        screen_handler=>get_reservations( ).
    ENDCASE.
    CLEAR g_ok_code.
  ENDMETHOD.
  METHOD cancel.
    LEAVE PROGRAM.
  ENDMETHOD.
  METHOD customer_search_by_id.
    DATA customer_tab TYPE demo_cr_customers_tt.
    DATA customer_wa  LIKE LINE OF customer_tab.
    customer_wa = screen_handler=>car_rental_service->get_customer_by_id(
      demo_cr_scustomer_cntrl-id ).
    CLEAR g_customers.
    MOVE-CORRESPONDING customer_wa TO g_customer.
    APPEND g_customer TO g_customers.
  ENDMETHOD.
  METHOD customer_search_by_name.
    DATA customer_tab TYPE demo_cr_customers_tt.
    DATA customer_wa  LIKE LINE OF customer_tab.
    customer_tab = screen_handler=>car_rental_service->get_customers_by_name(
      demo_cr_scustomer_cntrl-name ).
    CLEAR g_customers.
    LOOP AT customer_tab INTO customer_wa.
      MOVE-CORRESPONDING customer_wa TO g_customer.
      APPEND g_customer TO g_customers.
    ENDLOOP.
  ENDMETHOD.
  METHOD customer_create.
    DATA customer_tab TYPE demo_cr_customers_tt.
    DATA customer_wa  LIKE LINE OF customer_tab.
    DATA exc TYPE REF TO cx_demo_cr_customer.
    CALL SELECTION-SCREEN 200 STARTING AT 10 10.
    IF sy-subrc <> 0.
      RETURN.
    ENDIF.
    TRY.
        screen_handler=>car_rental_service->create_customer( g_name ).
      CATCH cx_demo_cr_customer INTO exc.
        MESSAGE exc TYPE 'I' DISPLAY LIKE 'E'.
    ENDTRY.
    customer_tab = screen_handler=>car_rental_service->get_customers_by_name(
      g_name ).
    READ TABLE customer_tab INTO customer_wa INDEX 1.
    MOVE-CORRESPONDING customer_wa TO g_customer.
    APPEND g_customer TO g_customers.
  ENDMETHOD.
  METHOD reservation_create.
    DATA reservation_tab TYPE demo_cr_reservations_tt.
    DATA reservation_wa  LIKE LINE OF reservation_tab.
    DATA customer_wa  LIKE LINE OF g_customers.
    DATA exc TYPE REF TO cx_demo_cr_car_rental.
    READ TABLE g_customers WITH KEY mark = 'X' INTO customer_wa.
    IF sy-subrc <> 0.
      RETURN.
    ENDIF.
    g_commnt = customer_wa-name.
    CALL SELECTION-SCREEN 300 STARTING AT 10 10.
    IF sy-subrc <> 0.
      RETURN.
    ENDIF.
    TRY.
        screen_handler=>car_rental_service->make_reservation(
          EXPORTING
            i_customer_id =  customer_wa-id
            i_category    =  g_cat
            i_date_from   =  g_from
            i_date_to     =  g_to ).
      CATCH cx_demo_cr_no_customer cx_demo_cr_lock cx_demo_cr_reservation INTO exc.
        MESSAGE exc TYPE 'I' DISPLAY LIKE 'E'.
        RETURN.
    ENDTRY.
    reservation_tab = screen_handler=>car_rental_service->get_reservations_by_cust_id(
      customer_wa-id ).
    CLEAR g_reservations.
    LOOP AT reservation_tab INTO reservation_wa.
      MOVE-CORRESPONDING reservation_wa TO g_reservation.
      APPEND g_reservation TO g_reservations.
    ENDLOOP.
  ENDMETHOD.
  METHOD get_reservations.
    DATA reservation_tab TYPE demo_cr_reservations_tt.
    DATA reservation_wa  LIKE LINE OF reservation_tab.
    DATA customer_wa     LIKE LINE OF g_customers.
    READ TABLE g_customers WITH KEY mark = 'X' INTO customer_wa.
    IF sy-subrc <> 0.
      RETURN.
    ENDIF.
    reservation_tab = screen_handler=>car_rental_service->get_reservations_by_cust_id(
      customer_wa-id  ) .
    CLEAR g_reservations.
    LOOP AT reservation_tab INTO reservation_wa.
      MOVE-CORRESPONDING reservation_wa TO g_reservation.
      APPEND g_reservation TO g_reservations.
    ENDLOOP.
  ENDMETHOD.
ENDCLASS.

CLASS customer_table IMPLEMENTATION.
  METHOD change_tc_attr.
    DESCRIBE TABLE g_customers LINES customers-lines.
  ENDMETHOD.
  METHOD mark.
    DATA customers_wa    LIKE LINE OF g_customers.
    IF customers-line_sel_mode = 1
    AND g_customer-mark = 'X'.
      LOOP AT g_customers INTO customers_wa
        WHERE mark = 'X'.
        customers_wa-mark = ''.
        MODIFY g_customers
          FROM customers_wa
          TRANSPORTING mark.
      ENDLOOP.
    ENDIF.
    MODIFY g_customers
      FROM g_customer
      INDEX customers-current_line
      TRANSPORTING mark.
  ENDMETHOD.
ENDCLASS.

CLASS reservation_table IMPLEMENTATION.
  METHOD change_tc_attr.
    DESCRIBE TABLE g_reservations LINES customers-lines.
  ENDMETHOD.
  METHOD mark.
    DATA reservations_wa LIKE LINE OF g_reservations.
    IF reservations-line_sel_mode = 1
    AND g_reservation-mark = 'X'.
      LOOP AT g_reservations INTO reservations_wa
        WHERE mark = 'X'.
        reservations_wa-mark = ''.
        MODIFY g_reservations
          FROM reservations_wa
          TRANSPORTING mark.
      ENDLOOP.
    ENDIF.
    MODIFY g_reservations
      FROM g_reservation
      INDEX reservations-current_line
      TRANSPORTING mark.
  ENDMETHOD.
ENDCLASS.
