class CL_DEMO_CR_RESERVATION_CATA definition
  public
  inheriting from CL_DEMO_CR_RESERVATION_SERVICE
  final
  create public .

public section.
*"* public components of class CL_DEMO_CR_RESERVATION_CATA
*"* do not include other source files here!!!

  methods CONSTRUCTOR .
protected section.
*"* protected components of class CL_DEMO_CR_RESERVATION_CATA
*"* do not include other source files here!!!

  methods COMPUTE_PRICE
    redefinition .

private section.
*"* private components of class CL_DEMO_CR_RESERVATION_CATA
*"* do not include other source files here!!!

  constants CATA_RATE type DEMO_CR_CAT_SCALE value '1'. "#EC NOTEXT
ENDCLASS.



CLASS CL_DEMO_CR_RESERVATION_CATA IMPLEMENTATION.


  METHOD COMPUTE_PRICE.

    r_price = super->compute_price( i_date_from = i_date_from
                                    i_date_to    = i_date_to ) * me->cata_rate.

  ENDMETHOD.


  METHOD CONSTRUCTOR.

    super->constructor( ).
    me->car_tab = cl_demo_cr_cars_mngr=>get_cars_by_category( 'A' ).

  ENDMETHOD.
ENDCLASS.
