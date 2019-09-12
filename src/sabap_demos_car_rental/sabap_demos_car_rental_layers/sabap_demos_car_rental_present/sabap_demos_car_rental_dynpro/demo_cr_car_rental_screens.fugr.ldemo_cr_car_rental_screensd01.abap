*&---------------------------------------------------------------------*
*&  Include           LDEMO_CR_CAR_RENTAL_SCREENSD01
*&---------------------------------------------------------------------*

CLASS screen_handler DEFINITION FINAL.
  PUBLIC SECTION.
    CLASS-DATA    car_rental_service TYPE REF TO if_demo_cr_car_rentl_service.
    CLASS-METHODS: class_constructor,
                   status_0100,
                   user_command_0100,
                   cancel.
  PRIVATE SECTION.
    CLASS-METHODS: customer_search_by_id,
                   customer_search_by_name,
                   customer_create,
                   reservation_create,
                   get_reservations.
ENDCLASS.

CLASS customer_table DEFINITION FINAL.
  PUBLIC SECTION.
    CLASS-METHODS: change_tc_attr,
                   mark.
ENDCLASS.

CLASS reservation_table DEFINITION FINAL.
  PUBLIC SECTION.
    CLASS-METHODS: change_tc_attr,
                   mark.
ENDCLASS.
