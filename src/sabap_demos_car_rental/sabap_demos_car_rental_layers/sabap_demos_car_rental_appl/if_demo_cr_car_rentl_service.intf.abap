*"* components of interface IF_DEMO_CR_CAR_RENTL_SERVICE
interface IF_DEMO_CR_CAR_RENTL_SERVICE
  public .


  methods CREATE_CUSTOMER
    importing
      !I_CUSTOMER type DEMO_CR_CUSTOMER_NAME
    returning
      value(R_CUSTOMER_ID) type DEMO_CR_CUSTOMER_ID
    raising
      CX_DEMO_CR_CUSTOMER .
  methods GET_CARS_BY_CATEGORY
    importing
      !I_CATEGORY type DEMO_CR_CATEGORY
    returning
      value(R_CARS) type DEMO_CR_CARS_TT .
  methods GET_CUSTOMER_BY_ID
    importing
      !I_CUSTOMER_ID type DEMO_CR_CUSTOMER_ID
    returning
      value(R_CUSTOMER) type DEMO_CR_SCUSTOMER .
  methods GET_CUSTOMERS_BY_NAME
    importing
      !I_CUSTOMER_NAME type DEMO_CR_CUSTOMER_NAME
    returning
      value(R_CUSTOMERS) type DEMO_CR_CUSTOMERS_TT .
  methods GET_RESERVATIONS_BY_CUST_ID
    importing
      !I_CUSTOMER_ID type DEMO_CR_CUSTOMER_ID
    returning
      value(R_RESERVATIONS) type DEMO_CR_RESERVATIONS_TT .
  methods MAKE_RESERVATION
    importing
      !I_CUSTOMER_ID type DEMO_CR_CUSTOMER_ID
      !I_CATEGORY type DEMO_CR_CATEGORY
      !I_DATE_FROM type DEMO_CR_DATE_FROM
      !I_DATE_TO type DEMO_CR_DATE_TO
    returning
      value(R_RESERVATION_ID) type DEMO_CR_RESERVATION_ID
    raising
      CX_DEMO_CR_NO_CUSTOMER
      CX_DEMO_CR_LOCK
      CX_DEMO_CR_RESERVATION .
endinterface.
