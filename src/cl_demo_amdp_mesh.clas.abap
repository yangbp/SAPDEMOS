class CL_DEMO_AMDP_MESH definition
  public
  final
  create public .

public section.

  interfaces IF_AMDP_MARKER_HDB .

  types:
    t_orders TYPE SORTED TABLE OF snwd_so WITH UNIQUE KEY node_key .
  types:
    t_items TYPE SORTED TABLE OF snwd_so_i WITH UNIQUE KEY node_key
                                           with NON-UNIQUE SORTED key parent_key COMPONENTS parent_key.
  types:
    t_products TYPE SORTED TABLE OF snwd_pd WITH UNIQUE KEY node_key .
  types:
    t_bupas TYPE SORTED TABLE OF snwd_bpa WITH UNIQUE KEY node_key .
  types:
    t_addresses TYPE SORTED TABLE OF snwd_ad WITH UNIQUE KEY node_key .
  types:
    BEGIN OF MESH t_sales_order,
        addresses TYPE t_addresses,
        bupas TYPE t_bupas
              ASSOCIATION _addresses TO addresses ON node_key = address_guid,
        products TYPE t_products,
        items TYPE t_items
              ASSOCIATION _products TO products ON node_key = product_guid,
        orders TYPE t_orders
               ASSOCIATION _items TO items ON parent_key = node_key USING KEY parent_key
               ASSOCIATION _buyers TO bupas ON node_key   = buyer_guid,
      END OF MESH t_sales_order .
  types:
    t_order_ids TYPE RANGE OF snwd_so-so_id .

  methods SELECT
    importing
      value(ORDER_IDS) type T_ORDER_IDS
    returning
      value(SALES_ORDER) type T_SALES_ORDER
    raising CX_AMDP_ERROR.
private section.

  methods SELECT_HDB
    importing
      value(ORDER_IDS) type T_ORDER_IDS
      value(CLNT) type SY-MANDT
    exporting
      value(ORDERS) type T_ORDERS
      value(BUPAS) type T_BUPAS
      value(ADRESSES) type T_ADDRESSES
      value(ITEMS) type T_ITEMS
      value(PRODUCTS) type T_PRODUCTS
    raising CX_AMDP_ERROR.
  methods SELECT_OPEN_SQL
    importing
      value(ORDER_IDS) type T_ORDER_IDS
    exporting
      value(ORDERS) type T_ORDERS
      value(BUPAS) type T_BUPAS
      value(ADRESSES) type T_ADDRESSES
      value(ITEMS) type T_ITEMS
      value(PRODUCTS) type T_PRODUCTS .
ENDCLASS.



CLASS CL_DEMO_AMDP_MESH IMPLEMENTATION.


  METHOD select.
    CASE substring( val = cl_db_sys=>dbsys_type len = 3 ).
      WHEN 'HDB'.
        select_hdb(
           EXPORTING
             clnt      = sy-mandt
             order_ids = order_ids
           IMPORTING
             orders   = sales_order-orders
             bupas    = sales_order-bupas
             adresses = sales_order-addresses
             items    = sales_order-items
             products = sales_order-products ).
      WHEN OTHERS.
        select_open_sql(
           EXPORTING
             order_ids = order_ids
           IMPORTING
             orders   = sales_order-orders
             bupas    = sales_order-bupas
             adresses = sales_order-addresses
             items    = sales_order-items
             products = sales_order-products ).
    ENDCASE.
  ENDMETHOD.


  METHOD select_hdb  BY DATABASE PROCEDURE
                     FOR HDB LANGUAGE SQLSCRIPT
                     OPTIONS READ-ONLY
                     USING snwd_so snwd_so_i snwd_pd snwd_bpa snwd_ad.
    orders = select * from snwd_so
      where client = :clnt and so_id in (
        select low from :order_ids );

    bupas = select * from snwd_bpa
      where client = :clnt and node_key in (
        select DISTINCT buyer_guid from :orders );

    adresses = select * from snwd_ad
      where client = :clnt and node_key in (
        select address_guid from :bupas );

    items = select * from snwd_so_i
      where parent_key in ( select node_key from :orders );

    products = select * from snwd_pd as product
      where client = :clnt and node_key in (
        select distinct product_guid from :items );
  ENDMETHOD.


  METHOD select_open_sql.
    SELECT *
           FROM snwd_so
           INTO TABLE @orders
           WHERE so_id IN @order_ids.

    SELECT *
           FROM snwd_so_i
           FOR ALL ENTRIES IN @orders
           WHERE parent_key = @orders-node_key
           INTO TABLE @items.

    SELECT *
          FROM snwd_pd
          FOR ALL ENTRIES IN @items
          WHERE node_key = @items-product_guid
          INTO TABLE @products.

    SELECT *
          FROM snwd_bpa
          INTO TABLE bupas
          FOR ALL ENTRIES IN orders
          WHERE node_key = orders-buyer_guid
          ##SELECT_FAE_WITH_LOB[WEB_ADDRESS].

    SELECT *
           FROM snwd_ad
           FOR ALL ENTRIES IN @bupas
           WHERE node_key = @bupas-address_guid
           INTO TABLE @adresses.
  ENDMETHOD.
ENDCLASS.
