*"* use this source file for your ABAP unit test classes

CLASS lcl_test_reservations_manager DEFINITION FOR TESTING
                            DURATION SHORT
                            RISK LEVEL HARMLESS
                            FINAL.
  PRIVATE SECTION.
    CLASS-METHODS class_teardown.
    METHODS test_get_reservation          FOR TESTING.
    METHODS test_create_reservation       FOR TESTING.
    METHODS test_delete_all               FOR TESTING.
    METHODS test_delete_reservation_by_id FOR TESTING.
    METHODS test_lock_unlock              FOR TESTING.
ENDCLASS.

CLASS lcl_test_reservations_manager IMPLEMENTATION.
  METHOD test_get_reservation.

    DATA id            TYPE demo_cr_reservation_id.
    DATA cust_id       TYPE demo_cr_customer_id.
    DATA reservation1  TYPE demo_cr_sreservation.
    DATA reservation2  TYPE demo_cr_sreservation.
    DATA reservation_tab1 TYPE demo_cr_reservations_tt.
    DATA reservation_tab2 TYPE demo_cr_reservations_tt.

    DATA l_reservation  TYPE demo_cr_reservtn.

    DELETE FROM demo_cr_reservtn.
    l_reservation-reservation_id   = '11111111'.
    l_reservation-customer_id      = '88888888'.
    l_reservation-license_plate    = 'AAAAAAAA'.
    l_reservation-date_from        = sy-datum.
    l_reservation-date_to          = sy-datum.
    INSERT demo_cr_reservtn FROM l_reservation.

    DELETE FROM demo_cr_reservtn.
    l_reservation-reservation_id   = '11111111'.
    l_reservation-customer_id      = '88888888'.
    l_reservation-license_plate    = 'BBBBBBBB'.
    l_reservation-date_from        = sy-datum.
    l_reservation-date_to          = sy-datum.
    INSERT demo_cr_reservtn FROM l_reservation.

    DELETE FROM demo_cr_reservtn.
    l_reservation-reservation_id   = '22222222'.
    l_reservation-customer_id      = 'BBBBBBBB'.
    l_reservation-license_plate    = 'CCCCCCCC'.
    l_reservation-date_from        = sy-datum.
    l_reservation-date_to          = sy-datum.
    INSERT demo_cr_reservtn FROM l_reservation.

    id = '11111111'.

    SELECT SINGLE *
           FROM demo_cr_reservtn
           INTO CORRESPONDING FIELDS OF reservation1
           WHERE reservation_id = id.

    reservation2 = cl_demo_cr_reservations_mngr=>get_reservation_by_id( id ).

    cl_aunit_assert=>assert_equals(
       exp = reservation1
       act = reservation2
       msg = 'Wrong selection of reservation by id' ).

    CLEAR: reservation1, reservation2.

    cust_id = '88888888'.

    SELECT *
           FROM demo_cr_reservtn
           INTO CORRESPONDING FIELDS OF TABLE reservation_tab1
           WHERE customer_id = cust_id.

    reservation_tab2 = cl_demo_cr_reservations_mngr=>get_reservations_by_cust_id( cust_id ).

    cl_aunit_assert=>assert_equals(
       exp = reservation_tab1
       act = reservation_tab2
       msg = 'Wrong selection of reservations by customer id' ).

    CLEAR: reservation_tab1, reservation_tab2.

    SELECT *
           FROM demo_cr_reservtn
           INTO CORRESPONDING FIELDS OF TABLE reservation_tab1.

    reservation_tab2 = cl_demo_cr_reservations_mngr=>get_all( ).

    cl_aunit_assert=>assert_equals(
       exp = reservation_tab1
       act = reservation_tab2
       msg = 'Wrong selection of reservations' ).

  ENDMETHOD.
  METHOD test_create_reservation.
    DATA l_reservation TYPE demo_cr_sreservation.

    DELETE FROM demo_cr_reservtn WHERE reservation_id = '12345678'.

    l_reservation-reservation_id   = '12345678'.
    l_reservation-customer_id      = '12345678'.
    l_reservation-license_plate    = '12345678'.
    l_reservation-date_from        = sy-datum.
    l_reservation-date_to          = sy-datum.

    TRY.
        cl_demo_cr_reservations_mngr=>create_reservation(
          EXPORTING
            i_reservation      = l_reservation ).
      CATCH cx_demo_cr_reservation.
        cl_aunit_assert=>fail(
          EXPORTING
             msg    =  'No exception should occur'  ).
    ENDTRY.

    SELECT SINGLE *
           FROM demo_cr_reservtn
           INTO CORRESPONDING FIELDS OF l_reservation
           WHERE reservation_id = '12345678'.

    cl_aunit_assert=>assert_subrc(
      EXPORTING
        act              =     sy-subrc ).

    TRY.
        cl_demo_cr_reservations_mngr=>create_reservation(
          EXPORTING
            i_reservation      = l_reservation ).
        cl_aunit_assert=>fail(
          EXPORTING
             msg    =  'Exception should occur'  ).
      CATCH cx_demo_cr_reservation. "#EC NO_HANDLER
    ENDTRY.

    DELETE FROM demo_cr_reservtn.

  ENDMETHOD.
  METHOD test_delete_all.
    DATA l_reservation  TYPE demo_cr_reservtn.
    DATA l_reservations TYPE TABLE OF demo_cr_reservtn. "#EC NEEDED

    DELETE FROM demo_cr_reservtn WHERE reservation_id = '12345678'.

    l_reservation-reservation_id   = '12345678'.
    l_reservation-customer_id      = '12345678'.
    l_reservation-license_plate    = '12345678'.
    l_reservation-date_from        = sy-datum.
    l_reservation-date_to          = sy-datum.

    INSERT demo_cr_reservtn FROM l_reservation.

    cl_demo_cr_reservations_mngr=>delete_all( ).
    SELECT *
           FROM demo_cr_reservtn
           INTO CORRESPONDING FIELDS OF TABLE l_reservations.
    cl_aunit_assert=>assert_subrc(
      EXPORTING
        act              =     sy-subrc
        exp              =     4 ).

  ENDMETHOD.
  METHOD test_delete_reservation_by_id.

    DATA l_reservation  TYPE demo_cr_reservtn.

    DELETE FROM demo_cr_reservtn WHERE reservation_id = '12345678'.

    l_reservation-reservation_id   = '12345678'.
    l_reservation-customer_id      = '12345678'.
    l_reservation-license_plate    = '12345678'.
    l_reservation-date_from        = sy-datum.
    l_reservation-date_to          = sy-datum.
    INSERT demo_cr_reservtn FROM l_reservation.

    TRY.
        cl_demo_cr_reservations_mngr=>delete_reservation_by_id( '12345678' ).
      CATCH cx_demo_cr_reservation.
        cl_aunit_assert=>fail(
          EXPORTING
             msg    =  'No exception should occur'  ).
    ENDTRY.

    SELECT SINGLE *
           FROM demo_cr_reservtn
           INTO CORRESPONDING FIELDS OF l_reservation
           WHERE reservation_id = '12345678'.
    cl_aunit_assert=>assert_subrc(
      EXPORTING
        act              =     sy-subrc
        exp              =     4 ).

    TRY.
        cl_demo_cr_reservations_mngr=>delete_reservation_by_id( '12345678' ).
        cl_aunit_assert=>fail(
          EXPORTING
             msg    =  'Exception should occur'  ).
      CATCH cx_demo_cr_reservation. "#EC NO_HANDLER
    ENDTRY.

  ENDMETHOD.
  METHOD test_lock_unlock.
    DATA l_reservation TYPE demo_cr_reservtn.

    DELETE FROM demo_cr_reservtn WHERE reservation_id = '12345678'.

    l_reservation-reservation_id   = '12345678'.
    l_reservation-customer_id      = '12345678'.
    l_reservation-license_plate    = '12345678'.
    l_reservation-date_from        = sy-datum.
    l_reservation-date_to          = sy-datum.
    INSERT demo_cr_reservtn FROM l_reservation.

    TRY.
        cl_demo_cr_reservations_mngr=>lock( '00000000' ).
      CATCH cx_demo_cr_lock.
        cl_aunit_assert=>fail(
          EXPORTING
             msg    =  'No exception should occur'  ).
    ENDTRY.
    TRY.
        cl_demo_cr_reservations_mngr=>lock( '12345678' ).
      CATCH cx_demo_cr_lock.
        cl_aunit_assert=>fail(
          EXPORTING
             msg    =  'No exception should occur'  ).
    ENDTRY.
    TRY.
        cl_demo_cr_reservations_mngr=>lock( '12345678' ).
        cl_aunit_assert=>fail(
          EXPORTING
             msg    =  'Exception should occur'  ).
      CATCH cx_demo_cr_lock. "#EC NO_HANDLER
    ENDTRY.
    cl_demo_cr_reservations_mngr=>unlock( '12345678' ).
    TRY.
        cl_demo_cr_reservations_mngr=>lock( '12345678' ).
      CATCH cx_demo_cr_lock.
        cl_aunit_assert=>fail(
          EXPORTING
             msg    =  'No exception should occur'  ).
    ENDTRY.
    cl_demo_cr_reservations_mngr=>unlock( '12345678' ).

  ENDMETHOD.
  METHOD class_teardown.
    DELETE FROM demo_cr_reservtn.
    COMMIT work.
  ENDMETHOD.
ENDCLASS.
