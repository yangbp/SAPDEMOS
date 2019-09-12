class CL_DEMO_CR_CARS_MNGR definition
  public
  final
  create public .

public section.
*"* public components of class CL_DEMO_CR_CARS_MNGR
*"* do not include other source files here!!!

  class-methods GET_CARS_BY_CATEGORY
    importing
      !I_CATEGORY type DEMO_CR_CATEGORY
    returning
      value(R_CARS) type DEMO_CR_CARS_TT .
  class-methods CREATE_CAR
    importing
      !I_CAR type DEMO_CR_SCAR
    raising
      CX_DEMO_CR_CAR .
  class-methods DELETE_ALL .
  class-methods DELETE_CARS_BY_LICENCE_PLATE
    importing
      !I_LICENSE_PLATE type DEMO_CR_LICENSE_PLATE
    raising
      CX_DEMO_CR_CAR .
protected section.
*"* protected components of class CL_DEMO_CR_CARS_MNGR
*"* do not include other source files here!!!
private section.
*"* private components of class CL_DEMO_CR_CARS_MNGR
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_DEMO_CR_CARS_MNGR IMPLEMENTATION.


METHOD CREATE_CAR.

  DATA l_car_wa TYPE demo_cr_cars.

  l_car_wa-license_plate = i_car-license_plate.
  l_car_wa-category = i_car-category.

  INSERT demo_cr_cars FROM l_car_wa.

  IF sy-subrc <> 0.
    RAISE EXCEPTION TYPE cx_demo_cr_car_modify EXPORTING textid = cx_demo_cr_car_modify=>car_create
                                                         license_plate = i_car-license_plate.
  ENDIF.

ENDMETHOD.


METHOD DELETE_ALL.

  DELETE FROM demo_cr_cars. "#EC CI_NOWHERE

ENDMETHOD.


METHOD DELETE_CARS_BY_LICENCE_PLATE.

  DELETE FROM demo_cr_cars
         WHERE license_plate = i_license_plate.

  IF sy-subrc <> 0.
    RAISE EXCEPTION TYPE cx_demo_cr_car_modify EXPORTING textid = cx_demo_cr_car_modify=>car_delete
                                                         license_plate = i_license_plate.
  ENDIF.

ENDMETHOD.


METHOD GET_CARS_BY_CATEGORY.

  SELECT *
         FROM demo_cr_cars
         INTO CORRESPONDING FIELDS OF TABLE r_cars
         WHERE category = i_category.

ENDMETHOD.
ENDCLASS.
