REPORT demo_cr_car_rental_initialize.

CLASS car_rental_initialize DEFINITION
  FINAL
  CREATE PUBLIC.
  PUBLIC SECTION.
    CLASS-METHODS main
      RAISING
        cx_demo_cr_customer
        cx_demo_cr_reservation
        cx_demo_cr_lock
        cx_demo_cr_car .
  PRIVATE SECTION.
ENDCLASS.

CLASS car_rental_initialize IMPLEMENTATION.
  METHOD main.

    DATA  lr_service TYPE REF TO if_demo_cr_car_rentl_service.
    DATA  l_customer TYPE demo_cr_customer_name.
    DATA  l_car TYPE demo_cr_scar.
    DATA: l_random_number_int TYPE i,
          l_random_number_int_max TYPE i,
          l_random_number_s TYPE string,
          l_random_number TYPE REF TO cl_abap_random_int,
          l_license_plate TYPE demo_cr_license_plate.

    "Create customers
    cl_demo_cr_customers_mngr=>delete_all( ).
    l_customer = 'Conan Placid'.                            "#EC NOTEXT
    cl_demo_cr_customers_mngr=>create_customer( l_customer ).
    l_customer = 'Granny Smith'.                            "#EC NOTEXT
    cl_demo_cr_customers_mngr=>create_customer( l_customer ).
    l_customer = 'Lotti Logic'.                             "#EC NOTEXT
    cl_demo_cr_customers_mngr=>create_customer( l_customer ).
    l_customer = 'Hugo Parker'.                             "#EC NOTEXT
    cl_demo_cr_customers_mngr=>create_customer( l_customer  ).
    l_customer = 'Herman German'.                           "#EC NOTEXT
    cl_demo_cr_customers_mngr=>create_customer( l_customer  ).

    "Create cars
    cl_demo_cr_cars_mngr=>delete_all( ).
    l_random_number_int = 1234.
    DO 10 TIMES.
      l_random_number_s = l_random_number_int.
      CONCATENATE l_random_number_s ' CA' INTO l_license_plate.
      l_car-license_plate = l_license_plate.
      l_car-category = 'A'.
      cl_demo_cr_cars_mngr=>create_car( l_car ).
      l_random_number_int = l_random_number_int + 1.
      l_random_number_int_max = l_random_number_int + 100.
      l_random_number = cl_abap_random_int=>create(
        seed   = l_random_number_int
        min    = l_random_number_int
        max    = l_random_number_int_max ).
      l_random_number_int = l_random_number->get_next( ).
    ENDDO.
    l_random_number_int = '4711'.
    DO 10 TIMES.
      l_random_number_s = l_random_number_int.
      CONCATENATE l_random_number_s ' NY' INTO l_license_plate.
      l_car-license_plate = l_license_plate.
      l_car-category = 'B'.
      cl_demo_cr_cars_mngr=>create_car( l_car ).
      l_random_number_int = l_random_number_int + 1.
      l_random_number_int_max = l_random_number_int + 100.
      l_random_number = cl_abap_random_int=>create(
        seed   = l_random_number_int
        min    = l_random_number_int
        max    = l_random_number_int_max ).
      l_random_number_int = l_random_number->get_next( ).
    ENDDO.
    l_random_number_int = '4222'.
    DO 10 TIMES.
      l_random_number_s = l_random_number_int.
      CONCATENATE l_random_number_s ' AZ' INTO l_license_plate.
      l_car-license_plate = l_license_plate.
      l_car-category = 'C'.
      cl_demo_cr_cars_mngr=>create_car( l_car ).
      l_random_number_int = l_random_number_int + 1.
      l_random_number_int_max = l_random_number_int + 100.
      l_random_number = cl_abap_random_int=>create(
        seed   = l_random_number_int
        min    = l_random_number_int
        max    = l_random_number_int_max ).
      l_random_number_int = l_random_number->get_next( ).
    ENDDO.

    "Create reservations
    cl_demo_cr_reservations_mngr=>delete_all( ).
    lr_service = cl_demo_cr_car_rental_service=>get_service( ).
    lr_service->make_reservation(
       i_customer_id = '1'
       i_category    = 'A'
       i_date_from   = sy-datum
       i_date_to     = sy-datum ).
    lr_service->make_reservation(
       i_customer_id = '2'
       i_category    = 'B'
       i_date_from   = sy-datum
       i_date_to     = sy-datum ).
    lr_service->make_reservation(
       i_customer_id = '3'
       i_category    = 'C'
       i_date_from   = sy-datum
       i_date_to     = sy-datum ).

    COMMIT WORK.

  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  car_rental_initialize=>main( ).

  "Unit tests
  INCLUDE demo_cr_test_car_rental_init.
