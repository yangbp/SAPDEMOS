*"* use this source file for your ABAP unit test classes

CLASS cl_test_selects DEFINITION FOR TESTING
                   DURATION SHORT
                   RISK LEVEL HARMLESS
                   FINAL.
  PRIVATE SECTION.
    METHODS test_selects FOR TESTING.
ENDCLASS.

CLASS cl_test_selects IMPLEMENTATION.
  METHOD test_selects.
    DATA order_ids TYPE RANGE OF snwd_so-so_id.

    IF cl_db_sys=>is_in_memory_db = abap_false.
     RETURN.
    ENDIF.

    SELECT 'I' AS sign, 'EQ' AS option, so_id AS low
           FROM snwd_so UP TO 3 ROWS
           INTO CORRESPONDING FIELDS OF TABLE @order_ids
           ORDER BY low.

    DATA(oref) = NEW CL_DEMO_AMDP_MESH( ).

    DATA sales_order_hdb TYPE CL_DEMO_AMDP_MESH=>t_sales_order.
    oref->select_hdb(
       EXPORTING
         clnt      = sy-mandt
         order_ids = order_ids
       IMPORTING
         orders   = sales_order_hdb-orders
         bupas    = sales_order_hdb-bupas
         adresses = sales_order_hdb-addresses
         items    = sales_order_hdb-items
         products = sales_order_hdb-products ).

    DATA sales_order_osql TYPE CL_DEMO_AMDP_MESH=>t_sales_order.
    oref->select_open_sql(
       EXPORTING
         order_ids = order_ids
       IMPORTING
         orders   = sales_order_osql-orders
         bupas    = sales_order_osql-bupas
         adresses = sales_order_osql-addresses
         items    = sales_order_osql-items
         products = sales_order_osql-products ).

    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act                  = sales_order_osql
        exp                  = sales_order_hdb ).

  ENDMETHOD.
ENDCLASS.
