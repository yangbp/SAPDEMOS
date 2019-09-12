*&---------------------------------------------------------------------*
*&  Include           DEMO_CR_TEST_CAR_RENTAL_INITLZ
*&---------------------------------------------------------------------*

CLASS lcl_test_car_rental_initialize DEFINITION FOR TESTING
                                     DURATION SHORT
                                     RISK LEVEL HARMLESS
                                     FINAL.
  PRIVATE SECTION.
    METHODS test_initialize FOR TESTING.
ENDCLASS.

CLASS lcl_test_car_rental_initialize IMPLEMENTATION.
  METHOD test_initialize.
    DATA l_reservations TYPE demo_cr_reservations_tt.
    SUBMIT demo_cr_car_rental_initialize EXPORTING LIST TO MEMORY
                                         AND RETURN.
    l_reservations = cl_demo_cr_reservations_mngr=>get_all( ).
    cl_aunit_assert=>assert_not_initial(
      EXPORTING
        act              =     l_reservations
        msg              =     'No reservations found' ).
  ENDMETHOD.
ENDCLASS.
