class CL_DEMO_CR_RESERVATION_SERVICE definition
  public
  abstract
  create public .

public section.
*"* public components of class CL_DEMO_CR_RESERVATION_SERVICE
*"* do not include other source files here!!!
  methods MAKE_RESERVATION
    importing
      !I_CUSTOMER_ID type DEMO_CR_CUSTOMER_ID
      !I_DATE_FROM type DEMO_CR_DATE_FROM
      !I_DATE_TO type DEMO_CR_DATE_TO
    returning
      value(R_RESERVATION_ID) type DEMO_CR_RESERVATION_ID
    raising
      CX_DEMO_CR_NO_CUSTOMER
      CX_DEMO_CR_LOCK
      CX_DEMO_CR_RESERVATION .
protected section.
*"* protected components of class CL_DEMO_CR_RESERVATION_SERVICE
*"* do not include other source files here!!!

  data CAR_TAB type DEMO_CR_CARS_TT .
  constants BASIS_RATE type DEMO_CR_BASIS_RATE value 20. "#EC NOTEXT

  methods COMPUTE_PRICE
    importing
      !I_DATE_FROM type DEMO_CR_DATE_FROM
      !I_DATE_TO type DEMO_CR_DATE_TO
    returning
      value(R_PRICE) type DEMO_CR_PRICE .
private section.
*"* private components of class CL_DEMO_CR_RESERVATION_SERVICE
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_DEMO_CR_RESERVATION_SERVICE IMPLEMENTATION.


METHOD COMPUTE_PRICE.
  r_price = me->basis_rate * ( i_date_to - i_date_from + 1 ).
ENDMETHOD.


METHOD make_reservation.

  DATA: l_reservation_tab TYPE demo_cr_reservations_tt,
        l_reservation_wa TYPE demo_cr_sreservation,
        l_reservation_lock_wa TYPE demo_cr_sreservation,
        l_car_wa TYPE demo_cr_scar,
        l_max_reservation_wa TYPE demo_cr_sreservation.

  "Check customer_id
  IF i_customer_id IS INITIAL.
    RAISE EXCEPTION TYPE cx_demo_cr_no_customer.
  ENDIF.

  "Check reservation date
  IF i_date_from IS INITIAL OR i_date_to IS INITIAL OR i_date_from > i_date_to.
    RAISE EXCEPTION TYPE cx_demo_cr_reservation
      EXPORTING
        textid = cx_demo_cr_reservation=>reservation_create.
  ENDIF.

  "Get reservations
  l_reservation_tab = cl_demo_cr_reservations_mngr=>get_all( ).

  "Locking
  TRY.
    LOOP AT me->car_tab INTO l_car_wa.
      LOOP AT l_reservation_tab
          INTO l_reservation_lock_wa
          WHERE license_plate = l_car_wa-license_plate.
        cl_demo_cr_reservations_mngr=>lock( i_reservation_id =  l_reservation_lock_wa-reservation_id ).
      ENDLOOP.
    ENDLOOP.
  ENDTRY.

  "Find new reservation id
  SORT l_reservation_tab BY reservation_id DESCENDING.
  READ TABLE l_reservation_tab INTO l_max_reservation_wa INDEX 1.

  "Check availability of cars
  LOOP AT me->car_tab INTO l_car_wa.
    LOOP AT l_reservation_tab
      TRANSPORTING NO FIELDS
      WHERE license_plate = l_car_wa-license_plate          "#EC NEEDED
            AND NOT ( date_from > i_date_to OR
                      date_to   < i_date_from ).
    ENDLOOP.

    IF sy-subrc <> 0.
      l_reservation_wa-reservation_id = l_max_reservation_wa-reservation_id + 1.
      l_reservation_wa-customer_id    = i_customer_id.
      l_reservation_wa-license_plate  = l_car_wa-license_plate.
      l_reservation_wa-date_from      = i_date_from.
      l_reservation_wa-date_to        = i_date_to.
      l_reservation_wa-price = me->compute_price(
          i_date_from = i_date_from
          i_date_to   = i_date_to
          ).
      TRY.
          cl_demo_cr_reservations_mngr=>create_reservation( i_reservation =  l_reservation_wa ).
          INSERT l_reservation_wa INTO TABLE l_reservation_tab.
          r_reservation_id = l_reservation_wa-reservation_id.
        CATCH cx_demo_cr_reservation.
          LOOP AT me->car_tab INTO l_car_wa.
            LOOP AT l_reservation_tab
                INTO l_reservation_lock_wa
                WHERE license_plate = l_car_wa-license_plate.

              cl_demo_cr_reservations_mngr=>unlock( i_reservation_id =  l_reservation_lock_wa-reservation_id ).

            ENDLOOP.
          ENDLOOP.
          RAISE EXCEPTION TYPE cx_demo_cr_reservation
            EXPORTING
              textid = cx_demo_cr_reservation=>reservation_create.
      ENDTRY.

      LOOP AT me->car_tab INTO l_car_wa.
        LOOP AT l_reservation_tab
            INTO l_reservation_lock_wa
            WHERE license_plate = l_car_wa-license_plate.

          cl_demo_cr_reservations_mngr=>unlock( i_reservation_id =  l_reservation_lock_wa-reservation_id ).

        ENDLOOP.
      ENDLOOP.
      RETURN.
    ENDIF.
  ENDLOOP.

  LOOP AT me->car_tab INTO l_car_wa.
    LOOP AT l_reservation_tab
        INTO l_reservation_lock_wa
        WHERE license_plate = l_car_wa-license_plate.

      cl_demo_cr_reservations_mngr=>unlock( i_reservation_id =  l_reservation_lock_wa-reservation_id ).

    ENDLOOP.
  ENDLOOP.
  RAISE EXCEPTION TYPE cx_demo_cr_reservation
    EXPORTING
      textid = cx_demo_cr_reservation=>reservation_create.

ENDMETHOD.
ENDCLASS.
