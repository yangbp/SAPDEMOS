* Use this include for your local test classes

CLASS lcl_test_cars_manager DEFINITION FOR TESTING
                            DURATION SHORT
                            RISK LEVEL HARMLESS
                            FINAL.
  PRIVATE SECTION.
    CLASS-METHODS class_teardown.
    METHODS test_get_cars_by_category   FOR TESTING.
    METHODS test_create_car             FOR TESTING.
    METHODS test_delete_all             FOR TESTING.
    METHODS test_delete_cars_by_license FOR TESTING.
ENDCLASS.

CLASS lcl_test_cars_manager IMPLEMENTATION.
  METHOD test_get_cars_by_category.

    DATA l_car  TYPE demo_cr_cars.

    DATA itab TYPE demo_cr_cars_tt.
    DATA itab_all_cars TYPE demo_cr_cars_tt.
    DATA itab_category TYPE demo_cr_cars_tt.

    DELETE FROM demo_cr_cars.
    l_car-license_plate = 'AA123456'.
    l_car-category = 'A'.
    INSERT demo_cr_cars FROM l_car.
    l_car-license_plate = 'BB123456'.
    l_car-category = 'A'.
    INSERT demo_cr_cars FROM l_car.
    l_car-license_plate = 'CC123456'.
    l_car-category = 'B'.
    INSERT demo_cr_cars FROM l_car.
    l_car-license_plate = 'EE123456'.
    l_car-category = 'C'.
    INSERT demo_cr_cars FROM l_car.
    l_car-license_plate = 'FF123456'.
    l_car-category = 'C'.
    INSERT demo_cr_cars FROM l_car.
    l_car-license_plate = 'GG123456'.
    l_car-category = 'C'.
    INSERT demo_cr_cars FROM l_car.

    SELECT * FROM demo_cr_cars INTO CORRESPONDING FIELDS OF TABLE itab_all_cars.
    itab_category[] = itab_all_cars[].
    DELETE itab_category WHERE category <> 'A'.
    SORT itab_category.

    CLEAR itab.
    itab = cl_demo_cr_cars_mngr=>get_cars_by_category( 'A' ).
    SORT itab.
    cl_aunit_assert=>assert_equals(
      exp = itab_category
      msg = 'Wrong detection of category A cars'
      act = itab ).

    itab_category[] = itab_all_cars[].
    DELETE itab_category WHERE category <> 'B'.
    SORT itab_category.

    CLEAR itab.
    itab = cl_demo_cr_cars_mngr=>get_cars_by_category( 'B' ).
    SORT itab.
    cl_aunit_assert=>assert_equals(
      exp = itab_category
      msg = 'Wrong detection of category B cars'
      act = itab ).

    itab_category[] = itab_all_cars[].
    DELETE itab_category WHERE category <> 'C'.
    SORT itab_category.

    CLEAR itab.
    itab = cl_demo_cr_cars_mngr=>get_cars_by_category( 'C' ).
    SORT itab.
    cl_aunit_assert=>assert_equals(
    exp = itab_category
    msg = 'Wrong  detection of category C cars'
    act = itab ).
  ENDMETHOD.
  METHOD test_create_car.
    DATA l_car TYPE demo_cr_scar.

    DELETE FROM demo_cr_cars WHERE license_plate = 'XX123456'.

    l_car-license_plate = 'XX123456'.
    l_car-category = 'A'.

    TRY.
        cl_demo_cr_cars_mngr=>create_car(
          EXPORTING
            i_car      = l_car ).
      CATCH cx_demo_cr_car.
        cl_aunit_assert=>fail(
          EXPORTING
             msg    =  'No exception should occur'  ).
    ENDTRY.

    SELECT SINGLE *
           FROM demo_cr_cars
           INTO CORRESPONDING FIELDS OF l_car
           WHERE license_plate = 'XX123456'.

    cl_aunit_assert=>assert_subrc(
      EXPORTING
        act              =     sy-subrc ).

    TRY.
        cl_demo_cr_cars_mngr=>create_car(
          EXPORTING
            i_car      = l_car ).
        cl_aunit_assert=>fail(
          EXPORTING
             msg    =  'Exception should occur'  ).
      CATCH cx_demo_cr_car. "#EC NO_HANDLER
    ENDTRY.

    DELETE FROM demo_cr_cars WHERE license_plate = 'XX123456'.

  ENDMETHOD.
  METHOD test_delete_all.

    DATA l_car  TYPE demo_cr_cars.
    DATA l_cars TYPE demo_cr_cars_tt. "#EC NEEDED

    DELETE FROM demo_cr_cars WHERE license_plate = 'XX123456'.
    l_car-license_plate = 'XX123456'.
    l_car-category = 'A'.
    INSERT demo_cr_cars FROM l_car.

    cl_demo_cr_cars_mngr=>delete_all( ).
    SELECT *
           FROM demo_cr_cars
           INTO CORRESPONDING FIELDS OF TABLE l_cars.
    cl_aunit_assert=>assert_subrc(
      EXPORTING
        act              =     sy-subrc
        exp              =     4 ).

  ENDMETHOD.
  METHOD test_delete_cars_by_license.

    DATA l_car TYPE demo_cr_cars.

    DELETE FROM demo_cr_cars WHERE license_plate = 'XX123456'.
    l_car-license_plate = 'XX123456'.
    l_car-category = 'A'.
    INSERT demo_cr_cars FROM l_car.

    TRY.
        cl_demo_cr_cars_mngr=>delete_cars_by_licence_plate(  i_license_plate = 'XX123456' ).
      CATCH cx_demo_cr_car.
        cl_aunit_assert=>fail(
      EXPORTING
         msg    =  'No exception should occur'  ).
    ENDTRY.
    SELECT SINGLE *
           FROM demo_cr_cars
           INTO CORRESPONDING FIELDS OF l_car
           WHERE license_plate = 'XX123456'.
    cl_aunit_assert=>assert_subrc(
      EXPORTING
        act              =     sy-subrc
        exp              =     4 ).

    TRY.
        cl_demo_cr_cars_mngr=>delete_cars_by_licence_plate(  i_license_plate = 'XX123456' ).
        cl_aunit_assert=>fail(
          EXPORTING
             msg    =  'Exception should occur'  ).
      CATCH cx_demo_cr_car. "#EC NO_HANDLER
    ENDTRY.

  ENDMETHOD.
  METHOD class_teardown.
    DELETE FROM demo_cr_cars.
    COMMIT work.
  ENDMETHOD.
ENDCLASS.
