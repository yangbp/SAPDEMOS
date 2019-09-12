class CL_DEMO_CR_CAR_RENTAL_SERVICE definition
  public
  final
  create private .

public section.
*"* public components of class CL_DEMO_CR_CAR_RENTAL_SERVICE
*"* do not include other source files here!!!

  interfaces IF_DEMO_CR_CAR_RENTL_SERVICE .

  class-methods GET_SERVICE
    returning
      value(R_SERVICE) type ref to IF_DEMO_CR_CAR_RENTL_SERVICE .
  class-methods CLASS_CONSTRUCTOR .
*"* protected components of class ZCL_MA_CAR_RENTAL_SERVICE
*"* do not include other source files here!!!
protected section.
private section.
*"* private components of class CL_DEMO_CR_CAR_RENTAL_SERVICE
*"* do not include other source files here!!!

  class-data SINGLE_REF type ref to CL_DEMO_CR_CAR_RENTAL_SERVICE .
ENDCLASS.



CLASS CL_DEMO_CR_CAR_RENTAL_SERVICE IMPLEMENTATION.


METHOD CLASS_CONSTRUCTOR.

  CREATE OBJECT single_ref.

ENDMETHOD.


METHOD GET_SERVICE.

  "Lazy variant, not needed for eager variant with creation in static constructor
  "IF single_ref IS INITIAL.
  "  CREATE OBJECT single_ref.
  "ENDIF.

  r_service = single_ref.

ENDMETHOD.


METHOD IF_DEMO_CR_CAR_RENTL_SERVICE~CREATE_CUSTOMER.

  r_customer_id = cl_demo_cr_customers_mngr=>create_customer( i_customer =  i_customer ).

ENDMETHOD.


METHOD IF_DEMO_CR_CAR_RENTL_SERVICE~GET_CARS_BY_CATEGORY.

  r_cars = cl_demo_cr_cars_mngr=>get_cars_by_category( i_category ).

ENDMETHOD.


METHOD IF_DEMO_CR_CAR_RENTL_SERVICE~GET_CUSTOMERS_BY_NAME.

  r_customers = cl_demo_cr_customers_mngr=>get_customer_by_name( i_customer_name ).

ENDMETHOD.


METHOD IF_DEMO_CR_CAR_RENTL_SERVICE~GET_CUSTOMER_BY_ID.

  r_customer = cl_demo_cr_customers_mngr=>get_customer_by_id( i_customer_id  ).

ENDMETHOD.


METHOD IF_DEMO_CR_CAR_RENTL_SERVICE~GET_RESERVATIONS_BY_CUST_ID.

  r_reservations = cl_demo_cr_reservations_mngr=>get_reservations_by_cust_id( i_customer_id ).

ENDMETHOD.


METHOD if_demo_cr_car_rentl_service~make_reservation.

  DATA reservation TYPE REF TO cl_demo_cr_reservation_service.
  DATA name TYPE string VALUE 'CL_DEMO_CR_RESERVATION_CAT'.

  TRY.
      name = name && i_category.
      CREATE OBJECT reservation TYPE (name).

      r_reservation_id = reservation->make_reservation( i_customer_id = i_customer_id
                                                        i_date_from   = i_date_from
                                                        i_date_to     = i_date_to ).
    CATCH cx_sy_create_object_error.
      RAISE EXCEPTION TYPE cx_demo_cr_reservation
        EXPORTING
          textid = cx_demo_cr_reservation=>internal_error.
  ENDTRY.

ENDMETHOD.
ENDCLASS.
