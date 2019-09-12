*"* use this source file for your ABAP unit test classes

CLASS lcl_test_customers_manager DEFINITION FOR TESTING
                            DURATION SHORT
                            RISK LEVEL HARMLESS
                            FINAL.
  PRIVATE SECTION.
    CLASS-METHODS class_teardown.
    METHODS test_get_customer          FOR TESTING.
    METHODS test_create_customer       FOR TESTING.
    METHODS test_delete_all            FOR TESTING.
    METHODS test_delete_customer_by_id FOR TESTING.
ENDCLASS.

CLASS lcl_test_customers_manager IMPLEMENTATION.
  METHOD test_get_customer.

    DATA id           TYPE demo_cr_customer_id.
    DATA name         TYPE demo_cr_customer_name.
    DATA customer1    TYPE demo_cr_scustomer.
    DATA customer2    TYPE demo_cr_scustomer.
    DATA customer_tab1 TYPE demo_cr_customers_tt.
    DATA customer_tab2 TYPE demo_cr_customers_tt.

    DATA l_customer TYPE demo_cr_customrs.

    DELETE FROM demo_cr_customrs.
    l_customer-id   = '11111111'.
    l_customer-name = 'AAAAAAAA'.
    INSERT demo_cr_customrs FROM l_customer.
    l_customer-id   = '22222222'.
    l_customer-name = 'BBBBBBBB'.
    INSERT demo_cr_customrs FROM l_customer.
    l_customer-id   = '33333333'.
    l_customer-name = 'CCCCCCCC'.
    INSERT demo_cr_customrs FROM l_customer.
    l_customer-id   = '44444444'.
    l_customer-name = 'DDDDDDDD'.
    INSERT demo_cr_customrs FROM l_customer.


    id = '11111111'.

    SELECT SINGLE *
           FROM demo_cr_customrs
           INTO CORRESPONDING FIELDS OF customer1
           WHERE id = id.

    customer2 = cl_demo_cr_customers_mngr=>get_customer_by_id( id ).

    cl_aunit_assert=>assert_equals(
       exp = customer1
       act = customer2
       msg = 'Wrong selection of customer by id' ).

    CLEAR: customer1, customer2.

    name = 'BBBBBBBB'.

    SELECT SINGLE *
           FROM demo_cr_customrs
           INTO CORRESPONDING FIELDS OF customer1
           WHERE name = name. "#EC WARNOK

    customer_tab2 = cl_demo_cr_customers_mngr=>get_customer_by_name( name ).

    READ TABLE customer_tab2 INTO customer2 INDEX 1. "#EC CI_NOORDER

    cl_aunit_assert=>assert_equals(
       exp = customer1
       act = customer2
       msg = 'Wrong selection of customer by name' ).

    CLEAR customer_tab2.

    SELECT *
           FROM demo_cr_customrs
           INTO CORRESPONDING FIELDS OF TABLE customer_tab1.

    customer_tab2 = cl_demo_cr_customers_mngr=>get_customer_by_name( '*' ).

    cl_aunit_assert=>assert_equals(
       exp = customer_tab1
       act = customer_tab2
       msg = 'Wrong selection of customers' ).

    CLEAR customer_tab2.

    SELECT *
           FROM demo_cr_customrs
           INTO CORRESPONDING FIELDS OF TABLE customer_tab1.

    customer_tab2 = cl_demo_cr_customers_mngr=>get_all( ).

    cl_aunit_assert=>assert_equals(
       exp = customer_tab1
       act = customer_tab2
       msg = 'Wrong selection of customers' ).

  ENDMETHOD.
  METHOD test_create_customer.
    DATA l_customer TYPE demo_cr_customrs.

    DELETE FROM demo_cr_customrs WHERE id = '12345678'.

    l_customer-id   = '12345678'.
    l_customer-name = 'XXXXXXXX'.

    TRY.
        cl_demo_cr_customers_mngr=>create_customer(
          EXPORTING
            i_customer      = l_customer-name ).
      CATCH cx_demo_cr_customer.
        cl_aunit_assert=>fail(
          EXPORTING
             msg    =  'No exception should occur'  ).
    ENDTRY.

    SELECT SINGLE *
           FROM demo_cr_customrs
           INTO CORRESPONDING FIELDS OF l_customer
           WHERE name = 'XXXXXXXX'. "#EC WARNOK

    cl_aunit_assert=>assert_subrc(
      EXPORTING
        act              =     sy-subrc ).

    l_customer-id = '00000000'.
    INSERT demo_cr_customrs FROM l_customer.
    l_customer-id = '99999999'.
    INSERT demo_cr_customrs FROM l_customer.

    TRY.
        cl_demo_cr_customers_mngr=>create_customer(
          EXPORTING
            i_customer      = 'XXXXXXXX' ).
        cl_aunit_assert=>fail(
          EXPORTING
             msg    =  'Exception should occur'  ).
      CATCH cx_demo_cr_customer. "#EC NO_HANDLER
    ENDTRY.

    DELETE FROM demo_cr_customrs.

  ENDMETHOD.
  METHOD test_delete_all.

    DATA l_customer TYPE demo_cr_customrs.
    DATA l_customers TYPE TABLE OF demo_cr_customrs. "#EC NEEDED

    l_customer-id   = '12345678'.
    l_customer-name = 'XXXXXXXX'.
    INSERT demo_cr_customrs FROM l_customer.

    cl_demo_cr_customers_mngr=>delete_all( ).
    SELECT *
           FROM demo_cr_customrs
           INTO CORRESPONDING FIELDS OF TABLE l_customers.
    cl_aunit_assert=>assert_subrc(
      EXPORTING
        act              =     sy-subrc
        exp              =     4 ).

  ENDMETHOD.
  METHOD test_delete_customer_by_id.
    DATA l_customer TYPE demo_cr_customrs.

    l_customer-id   = '12345678'.
    l_customer-name = 'XXXXXXXX'.
    INSERT demo_cr_customrs FROM l_customer.

    TRY.
        cl_demo_cr_customers_mngr=>delete_customer_by_id( '12345678' ).
      CATCH cx_demo_cr_customer.
        cl_aunit_assert=>fail(
          EXPORTING
             msg    =  'No exception should occur'  ).
    ENDTRY.

    SELECT SINGLE *
           FROM demo_cr_customrs
           INTO CORRESPONDING FIELDS OF l_customer. "#EC WARNOK
    cl_aunit_assert=>assert_subrc(
      EXPORTING
        act              =     sy-subrc
        exp              =     4 ).

    TRY.
        cl_demo_cr_customers_mngr=>delete_customer_by_id( '12345678' ).
        cl_aunit_assert=>fail(
          EXPORTING
             msg    =  'Exception should occur'  ).
      CATCH cx_demo_cr_customer. "#EC NO_HANDLER
    ENDTRY.

  ENDMETHOD.
  METHOD class_teardown.
    DELETE FROM demo_cr_customrs.
    COMMIT work.
  ENDMETHOD.
ENDCLASS.
