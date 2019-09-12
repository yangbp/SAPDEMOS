*"* use this source file for your ABAP unit test classes

CLASS lcl_test_reservation_cata DEFINITION FOR TESTING
                                INHERITING FROM cl_demo_cr_test_reservation
                                DURATION SHORT
                                RISK LEVEL HARMLESS
                                FINAL.
  PRIVATE SECTION.
    METHODS test_make_reservation_cata FOR TESTING.
ENDCLASS.

CLASS lcl_test_reservation_cata IMPLEMENTATION.
  METHOD test_make_reservation_cata.
    DATA l_reservation_tab TYPE demo_cr_reservations_tt.
    DATA l_reservation LIKE LINE OF l_reservation_tab.

    me->category = 'A'.
    me->test_make_reservation( ).

    l_reservation_tab =
      cl_demo_cr_reservations_mngr=>get_reservations_by_cust_id( '12345678' ).

    cl_aunit_assert=>assert_not_initial(
      EXPORTING
        act              =     l_reservation_tab
        msg              =     'Reservation table is initial' ).

    READ TABLE l_reservation_tab INTO l_reservation INDEX 1.
    cl_aunit_assert=>assert_equals(
      EXPORTING
        exp                  =     l_reservation-price
        act                  =     20 * cl_demo_cr_reservation_cata=>cata_rate
        msg                  =     'Wrong price' ).
  ENDMETHOD.
ENDCLASS.
