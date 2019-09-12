*"* use this source file for your ABAP unit test classes

CLASS lcl_test_car_rental_service DEFINITION FOR TESTING
                                  DURATION SHORT
                                  RISK LEVEL HARMLESS
                                  FINAL.
  PRIVATE SECTION.
    CLASS-METHODS class_setup.
    CLASS-METHODS class_teardown.
    METHODS setup.
    METHODS teardown.
    METHODS test_all FOR TESTING.
    DATA service TYPE REF TO if_demo_cr_car_rentl_service.
ENDCLASS.

CLASS lcl_test_car_rental_service IMPLEMENTATION.
  METHOD class_setup.
    DATA l_car TYPE demo_cr_scar.

    cl_demo_cr_cars_mngr=>delete_all( ).
    cl_demo_cr_customers_mngr=>delete_all( ).
    cl_demo_cr_reservations_mngr=>delete_all( ).
    COMMIT WORK.

    "Create a car
    l_car-license_plate = 'XX123456'.
    l_car-category = 'A'.
    TRY.
        cl_demo_cr_cars_mngr=>create_car(
          EXPORTING
            i_car      = l_car ).
      CATCH cx_demo_cr_car. "#EC NO_HANDLER
    ENDTRY.
  ENDMETHOD.
  METHOD setup.
    service = cl_demo_cr_car_rental_service=>get_service( ).
  ENDMETHOD.
  METHOD test_all.
    DATA l_cars      TYPE demo_cr_cars_tt.
    DATA l_car       TYPE demo_cr_scar.
    DATA l_customers TYPE demo_cr_customers_tt.
    DATA l_customer  TYPE demo_cr_scustomer.
    DATA l_reservations TYPE demo_cr_reservations_tt.
    DATA l_reservation  TYPE demo_cr_sreservation.

    DATA l_date      TYPE sy-datum.

    "Get cars

    l_cars = service->get_cars_by_category( 'A' ).
    READ TABLE l_cars INTO l_car INDEX 1.
    cl_aunit_assert=>assert_equals(
       exp = 'XX123456'
       act = l_car-license_plate
       msg = 'Get cars failed' ).

    "Create Customer
    TRY.
        service->create_customer( '12345678' ).
      CATCH cx_demo_cr_customer.
        cl_aunit_assert=>fail(
          EXPORTING
             msg    =  'No exception should occur'  ).
    ENDTRY.
    l_customer = service->get_customer_by_id( '00000001' ).
    cl_aunit_assert=>assert_equals(
       exp = '12345678'
       act = l_customer-name
       msg = 'Get customer by name failed' ).
    l_customers = service->get_customers_by_name( '12345678' ).
    READ TABLE l_customers INTO l_customer INDEX 1.
    cl_aunit_assert=>assert_equals(
       exp = '00000001'
       act = l_customer-id
       msg = 'Get customer by name failed' ).

    "Make reservation
    TRY.
        service->make_reservation(
          EXPORTING
            i_customer_id =     '00000000'
            i_category    =     'A'
            i_date_from   =     sy-datum
            i_date_to     =     sy-datum ).
        cl_aunit_assert=>fail(
           EXPORTING
              msg    =  'Exception should occur'  ).
      CATCH cx_demo_cr_no_customer. "#EC NO_HANDLER
      CATCH cx_demo_cr_lock cx_demo_cr_reservation.
        cl_aunit_assert=>fail(
           EXPORTING
              msg    =  'Wrong exception'  ).
    ENDTRY.
    TRY.
        service->make_reservation(
          EXPORTING
            i_customer_id =     '12345678'
            i_category    =     'A'
            i_date_from   =     l_date
            i_date_to     =     l_date ).
        cl_aunit_assert=>fail(
           EXPORTING
              msg    =  'Exception should occur'  ).
      CATCH cx_demo_cr_reservation. "#EC NO_HANDLER
      CATCH cx_demo_cr_lock cx_demo_cr_no_customer.
        cl_aunit_assert=>fail(
           EXPORTING
              msg    =  'Wrong exception'  ).
    ENDTRY.
    TRY.
        service->make_reservation(
          EXPORTING
            i_customer_id =     '12345678'
            i_category    =     'X'
            i_date_from   =     sy-datum
            i_date_to     =     sy-datum ).
        cl_aunit_assert=>fail(
           EXPORTING
              msg    =  'Exception should occur'  ).
      CATCH cx_demo_cr_reservation. "#EC NO_HANDLER
      CATCH cx_demo_cr_lock cx_demo_cr_no_customer.
        cl_aunit_assert=>fail(
           EXPORTING
              msg    =  'Wrong exception'  ).
    ENDTRY.
    TRY.
        service->make_reservation(
          EXPORTING
            i_customer_id =     '12345678'
            i_category    =     'A'
            i_date_from   =     sy-datum
            i_date_to     =     sy-datum ).
      CATCH cx_demo_cr_reservation cx_demo_cr_lock cx_demo_cr_no_customer.
        cl_aunit_assert=>fail(
           EXPORTING
              msg    =  'No exception should occur'  ).
    ENDTRY.
    l_reservations = service->get_reservations_by_cust_id( '12345678' ).
    READ TABLE l_reservations INTO l_reservation INDEX 1.
    cl_aunit_assert=>assert_equals(
       exp = '00000001'
       act = l_reservation-reservation_id
       msg = 'Get reservation by customer id failed' ).
    TRY.
        cl_demo_cr_reservations_mngr=>lock( '00000001' ).
      CATCH cx_demo_cr_lock. "#EC NO_HANDLER
    ENDTRY.
    TRY.
        service->make_reservation(
          EXPORTING
            i_customer_id =     '12345678'
            i_category    =     'A'
            i_date_from   =     sy-datum
            i_date_to     =     sy-datum ).
        cl_aunit_assert=>fail(
          EXPORTING
             msg    =  'Exception should occur'  ).
      CATCH cx_demo_cr_no_customer cx_demo_cr_reservation.
        cl_aunit_assert=>fail(
          EXPORTING
             msg    =  'Wrong exception'  ).
      CATCH cx_demo_cr_lock. "#EC NO_HANDLER
    ENDTRY.
    cl_demo_cr_reservations_mngr=>unlock( '00000001' ).
  ENDMETHOD.
  METHOD teardown.
    CLEAR service.
  ENDMETHOD.
  METHOD class_teardown.
    cl_demo_cr_cars_mngr=>delete_all( ).
    cl_demo_cr_customers_mngr=>delete_all( ).
    cl_demo_cr_reservations_mngr=>delete_all( ).
    COMMIT WORK.
  ENDMETHOD.
ENDCLASS.
