class CL_DEMO_CR_TEST_RESERVATION definition
  public
  abstract
  create public
  for testing
  duration short
  risk level harmless .

public section.
*"* public components of class CL_DEMO_CR_TEST_RESERVATION
*"* do not include other source files here!!!
protected section.
*"* protected components of class CL_DEMO_CR_TEST_RESERVATION
*"* do not include other source files here!!!

  data CATEGORY type DEMO_CR_CATEGORY .

  methods TEST_MAKE_RESERVATION .
private section.
*"* private components of class CL_DEMO_CR_TEST_RESERVATION
*"* do not include other source files here!!!

  class-methods CLASS_SETUP .
  class-methods CLASS_TEARDOWN .
ENDCLASS.



CLASS CL_DEMO_CR_TEST_RESERVATION IMPLEMENTATION.


  METHOD CLASS_SETUP.
    cl_demo_cr_cars_mngr=>delete_all( ).
    cl_demo_cr_customers_mngr=>delete_all( ).
    cl_demo_cr_reservations_mngr=>delete_all( ).
    COMMIT work.
  ENDMETHOD.


  METHOD CLASS_TEARDOWN.
    cl_demo_cr_cars_mngr=>delete_all( ).
    cl_demo_cr_customers_mngr=>delete_all( ).
    cl_demo_cr_reservations_mngr=>delete_all( ).
    COMMIT WORK.
  ENDMETHOD.


  METHOD TEST_MAKE_RESERVATION.
    DATA reservation_service  TYPE REF TO cl_demo_cr_reservation_service.
    DATA l_date TYPE sy-datum.
    DATA l_car TYPE demo_cr_scar.
    DATA l_reservation TYPE demo_cr_sreservation.

    DATA name TYPE string.

    name = 'CL_DEMO_CR_RESERVATION_CAT' && me->category.

    TRY.
        CREATE OBJECT reservation_service TYPE (name).
      CATCH cx_sy_create_object_error.
        cl_aunit_assert=>fail(
          EXPORTING
             msg    =  'Unknown category'  ).
    ENDTRY.

    "Initial customer
    TRY.
        reservation_service->make_reservation( i_customer_id = '00000000'
                                i_date_from   = sy-datum
                                i_date_to     = sy-datum ).
        cl_aunit_assert=>fail(
          EXPORTING
             msg    =  'Exception should occur'  ).
      CATCH cx_demo_cr_no_customer. "#EC NO_HANDLER
      CATCH cx_demo_cr_lock cx_demo_cr_reservation.
        cl_aunit_assert=>fail(
          EXPORTING
             msg    =  'Wrong exception'  ).
    ENDTRY.

    " Initial dates
    TRY.
        reservation_service->make_reservation( i_customer_id = '12345678'
                                i_date_from   = l_date
                                i_date_to     = sy-datum ).
        cl_aunit_assert=>fail(
          EXPORTING
             msg    =  'Exception should occur'  ).
      CATCH cx_demo_cr_no_customer cx_demo_cr_lock.
        cl_aunit_assert=>fail(
          EXPORTING
             msg    =  'Wrong exception'  ).
      CATCH cx_demo_cr_reservation. "#EC NO_HANDLER
    ENDTRY.
    TRY.
        reservation_service->make_reservation( i_customer_id = '12345678'
                                i_date_from   = sy-datum
                                i_date_to     = l_date ).
        cl_aunit_assert=>fail(
          EXPORTING
             msg    =  'Exception should occur'  ).
      CATCH cx_demo_cr_no_customer cx_demo_cr_lock.
        cl_aunit_assert=>fail(
          EXPORTING
             msg    =  'Wrong exception'  ).
      CATCH cx_demo_cr_reservation. "#EC NO_HANDLER
    ENDTRY.

    "No cars at all
    TRY.
        reservation_service->make_reservation( i_customer_id = '12345678'
                                i_date_from   = sy-datum
                                i_date_to     = sy-datum ).
        cl_aunit_assert=>fail(
          EXPORTING
             msg    =  'Exception should occur'  ).
      CATCH cx_demo_cr_no_customer cx_demo_cr_lock.
        cl_aunit_assert=>fail(
          EXPORTING
             msg    =  'Wrong exception'  ).
      CATCH cx_demo_cr_reservation. "#EC NO_HANDLER
    ENDTRY.

    "Create and load cars
    l_car-license_plate = 'XX123456'.
    l_car-category = me->category.
    TRY.
        cl_demo_cr_cars_mngr=>create_car(
          EXPORTING
            i_car      = l_car ).
      CATCH cx_demo_cr_car. "#EC NO_HANDLER
    ENDTRY.

    TRY.
        CREATE OBJECT reservation_service TYPE (name).
      CATCH cx_sy_create_object_error.
        cl_aunit_assert=>fail(
          EXPORTING
             msg    =  'Unknown category'  ).
    ENDTRY.

    "Wrong reservation id
    l_reservation-reservation_id   = '99999999'.
    l_reservation-customer_id      = '12345678'.
    l_reservation-license_plate    = 'XX123456'.
    l_reservation-date_from        = sy-datum.
    l_reservation-date_to          = sy-datum.
    TRY.
        cl_demo_cr_reservations_mngr=>create_reservation(
          EXPORTING
            i_reservation      = l_reservation ).
      CATCH cx_demo_cr_reservation. "#EC NO_HANDLER
    ENDTRY.
    l_reservation-reservation_id   = '00000000'.
    l_reservation-customer_id      = '12345678'.
    l_reservation-license_plate    = 'XX123456'.
    l_reservation-date_from        = sy-datum + 1.
    l_reservation-date_to          = sy-datum + 1.
    TRY.
        cl_demo_cr_reservations_mngr=>create_reservation(
          EXPORTING
            i_reservation      = l_reservation ).
      CATCH cx_demo_cr_reservation. "#EC NO_HANDLER
    ENDTRY.

    TRY.
        l_date = sy-datum + 2.
        reservation_service->make_reservation( i_customer_id = '12345678'
                                               i_date_from   = l_date
                                               i_date_to     = l_date ).
        cl_aunit_assert=>fail(
          EXPORTING
             msg    =  'Exception should occur'  ).
      CATCH cx_demo_cr_no_customer cx_demo_cr_lock.
        cl_aunit_assert=>fail(
          EXPORTING
             msg    =  'Wrong exception'  ).
      CATCH cx_demo_cr_reservation. "#EC NO_HANDLER
    ENDTRY.

    cl_demo_cr_reservations_mngr=>delete_all( ).

    "Succesful reservation
    TRY.
        reservation_service->make_reservation( i_customer_id = '12345678'
                                               i_date_from   = sy-datum
                                               i_date_to     = sy-datum ).
      CATCH cx_demo_cr_no_customer cx_demo_cr_lock cx_demo_cr_reservation.
        cl_aunit_assert=>fail(
          EXPORTING
             msg    =  'No exception should occur'  ).
    ENDTRY.

    "Locking
    TRY.
        cl_demo_cr_reservations_mngr=>lock( '00000001' ).
      CATCH cx_demo_cr_lock. "#EC NO_HANDLER
    ENDTRY.
    TRY.
        reservation_service->make_reservation( i_customer_id = '12345678'
                                               i_date_from   = sy-datum
                                               i_date_to     = sy-datum ).
        cl_aunit_assert=>fail(
          EXPORTING
             msg    =  'Exception should occur'  ).
      CATCH cx_demo_cr_no_customer  cx_demo_cr_reservation.
        cl_aunit_assert=>fail(
          EXPORTING
             msg    =  'Wrong exception'  ).
      CATCH cx_demo_cr_lock. "#EC NO_HANDLER
    ENDTRY.
    cl_demo_cr_reservations_mngr=>unlock( '00000001' ).

    "No car
    TRY.
        reservation_service->make_reservation( i_customer_id = '12345678'
                                               i_date_from   = sy-datum
                                               i_date_to     = sy-datum ).
        cl_aunit_assert=>fail(
          EXPORTING
             msg    =  'Exception should occur'  ).
      CATCH cx_demo_cr_no_customer cx_demo_cr_lock.
        cl_aunit_assert=>fail(
          EXPORTING
             msg    =  'Wrong exception'  ).
      CATCH cx_demo_cr_reservation. "#EC NO_HANDLER
    ENDTRY.

  ENDMETHOD.
ENDCLASS.
