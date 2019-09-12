class CL_DEMO_AMDP_VS_OPEN_SQL definition
  public
  final
  create public .

public section.

  interfaces IF_AMDP_MARKER_HDB .

  types:
    BEGIN OF ty_invoice_header,
        invoice_guid TYPE snwd_so_inv_head-node_key,
        created_at   TYPE snwd_so_inv_head-created_at,
        paid_at      TYPE snwd_so_inv_head-changed_at,
        buyer_guid   TYPE snwd_so_inv_head-buyer_guid,
      END OF ty_invoice_header .
  types:
    BEGIN OF ty_invoice_item,
        item_guid     TYPE snwd_so_inv_item-node_key,
        invoice_guid  TYPE snwd_so_inv_head-node_key,
        product_guid  TYPE snwd_so_inv_item-product_guid,
        gross_amount  TYPE snwd_so_inv_item-gross_amount,
        currency_code TYPE snwd_so_inv_item-currency_code,
      END OF ty_invoice_item .
  types:
    BEGIN OF ty_customer_info,
        customer_guid TYPE snwd_bpa-node_key,
        customer_id   TYPE snwd_bpa-bp_id,
        customer_name TYPE snwd_bpa-company_name,
        country       TYPE snwd_ad-country,
        postal_code   TYPE snwd_ad-postal_code,
        city          TYPE snwd_ad-city,
      END OF ty_customer_info .
  types:
    tt_invoice_header TYPE STANDARD TABLE OF ty_invoice_header WITH KEY invoice_guid .
  types:
    tt_invoice_item   TYPE STANDARD TABLE OF ty_invoice_item .
  types:
    tt_customer_info  TYPE STANDARD TABLE OF ty_customer_info .

  methods AMDP
    importing
      value(IV_PAYMENT_DATE) type D
      value(IV_CLNT) type SY-MANDT
    exporting
      value(ET_INVOICE_HEADER) type TT_INVOICE_HEADER
      value(ET_INVOICE_ITEM) type TT_INVOICE_ITEM
      value(ET_CUSTOMER_INFO) type TT_CUSTOMER_INFO
    raising
      CX_AMDP_ERROR .
  methods OPEN_SQL_NESTED_SELECT
    importing
      value(IV_PAYMENT_DATE) type D
    exporting
      value(ET_INVOICE_HEADER) type TT_INVOICE_HEADER
      value(ET_INVOICE_ITEM) type TT_INVOICE_ITEM
      value(ET_CUSTOMER_INFO) type TT_CUSTOMER_INFO .
  methods OPEN_SQL_FOR_ALL_ENTRIES
    importing
      value(IV_PAYMENT_DATE) type D
    exporting
      value(ET_INVOICE_HEADER) type TT_INVOICE_HEADER
      value(ET_INVOICE_ITEM) type TT_INVOICE_ITEM
      value(ET_CUSTOMER_INFO) type TT_CUSTOMER_INFO .
  methods OPEN_SQL_SUBQUERY
    importing
      value(IV_PAYMENT_DATE) type D
    exporting
      value(ET_INVOICE_HEADER) type TT_INVOICE_HEADER
      value(ET_INVOICE_ITEM) type TT_INVOICE_ITEM
      value(ET_CUSTOMER_INFO) type TT_CUSTOMER_INFO .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS CL_DEMO_AMDP_VS_OPEN_SQL IMPLEMENTATION.


  METHOD amdp BY DATABASE PROCEDURE FOR HDB
         LANGUAGE SQLSCRIPT OPTIONS READ-ONLY
         USING snwd_ad snwd_bpa snwd_so_inv_head snwd_so_inv_item.

    --  Selection of invoices paid on a specified date
    --  plus business partner and product information

    -- Retrieve all invoice header which were paid on the requested date
    et_invoice_header = select
        node_key            as invoice_guid,
        created_at as created_at,
        changed_at as paid_at,
        buyer_guid
      from
        snwd_so_inv_head
      where
        client         = :iv_clnt
        and payment_status = 'P' -- only paid invoices
        and left(changed_at, 8) = :iv_payment_date
        order by invoice_guid;

    -- Get the items of those invoices
    et_invoice_item = select
        node_key   as item_guid,
        parent_key as invoice_guid,
        product_guid,
        gross_amount,
        currency_code
      from snwd_so_inv_item
      where parent_key in
          ( select invoice_guid
              from :et_invoice_header )
        order by item_guid, invoice_guid, product_guid;

    -- Get the information about the customers
    et_customer_info = select
        bpa.node_key     as customer_guid,
        bpa.bp_id        as customer_id,
        bpa.company_name as customer_name,
        ad.country,
        ad.postal_code,
        ad.city
      from snwd_bpa as bpa
      join snwd_ad as ad on ad.node_key = bpa.address_guid
      where bpa.node_key in ( select distinct buyer_guid
                                from :et_invoice_header )
      order by customer_id;
  ENDMETHOD.


  METHOD open_sql_for_all_entries.

    "Selection of invoices paid on a specified date
    "plus business partner and product information

    DATA lv_payment_date_min TYPE timestamp.
    DATA lv_payment_date_max TYPE timestamp.

    CONVERT DATE iv_payment_date TIME '0001'
      INTO TIME STAMP lv_payment_date_min TIME ZONE 'UTC'.
    CONVERT DATE iv_payment_date TIME '2359'
      INTO TIME STAMP lv_payment_date_max TIME ZONE 'UTC'.

    "Retrieve all invoice header which were paid on the requested date
    SELECT
      node_key       AS invoice_guid,
      created_at     AS created_at,
      changed_at     AS paid_at,
      buyer_guid
    FROM
      snwd_so_inv_head
    INTO TABLE @et_invoice_header
    WHERE                                               "#EC CI_NOFIELD
      payment_status = 'P'
      AND changed_at BETWEEN @lv_payment_date_min AND @lv_payment_date_max
    ORDER BY invoice_guid.

    "Get the items of those invoices
    SELECT
        node_key   AS item_guid,
        parent_key AS invoice_guid,
        product_guid,
        gross_amount,
        currency_code
     from snwd_so_inv_item
     into table @et_invoice_item
     for all entries in @et_invoice_header
     where  parent_key = @et_invoice_header-invoice_guid
     order by primary key.

    "Get the information about the customers
    SELECT
        bpa~node_key     AS customer_guid,
        bpa~bp_id        AS customer_id,
        bpa~company_name AS customer_name,
        ad~country,
        ad~postal_code,
        ad~city
      FROM snwd_bpa AS bpa
      JOIN snwd_ad AS ad ON ad~node_key = bpa~address_guid
      INTO TABLE @et_customer_info
      FOR ALL ENTRIES IN @et_invoice_header
      WHERE bpa~node_key = @et_invoice_header-buyer_guid.

    SORT et_customer_info BY customer_guid.

  ENDMETHOD.


  METHOD open_sql_nested_select.

    "Selection of invoices paid on a specified date
    "plus business partner and product information

    DATA ls_invoice_head  TYPE ty_invoice_header.
    DATA lt_invoice_item  TYPE tt_invoice_item.
    DATA lt_customer_info TYPE tt_customer_info.

    DATA lv_payment_date_min TYPE timestamp.
    DATA lv_payment_date_max TYPE timestamp.

    CONVERT DATE iv_payment_date TIME '0001'
      INTO TIME STAMP lv_payment_date_min TIME ZONE 'UTC'.
    CONVERT DATE iv_payment_date TIME '2359'
      INTO TIME STAMP lv_payment_date_max TIME ZONE 'UTC'.

    "Retrieve all invoice header which were paid on the requested date
    SELECT
      node_key       AS invoice_guid,
      created_at     AS created_at,
      changed_at     AS paid_at,
      buyer_guid
    FROM
      snwd_so_inv_head
    WHERE                                               "#EC CI_NOFIELD
      payment_status = 'P'
      AND changed_at BETWEEN @lv_payment_date_min AND @lv_payment_date_max
    ORDER BY invoice_guid
    INTO @ls_invoice_head.

      CLEAR lt_invoice_item.
      CLEAR lt_customer_info.

      "Get the items of invoice
      SELECT
        node_key   AS item_guid,
        parent_key AS invoice_guid,
        product_guid,
        gross_amount,
        currency_code
      FROM snwd_so_inv_item
      WHERE parent_key = @ls_invoice_head-invoice_guid
      ORDER BY item_guid, invoice_guid, product_guid
      INTO TABLE @lt_invoice_item.

      "Get the information about the customers
      SELECT
       bpa~node_key     AS customer_guid,
       bpa~bp_id        AS customer_id,
       bpa~company_name AS customer_name,
       ad~country,
       ad~postal_code,
       ad~city
     FROM snwd_bpa AS bpa
     JOIN snwd_ad AS ad ON ad~node_key = bpa~address_guid
     WHERE bpa~node_key = @ls_invoice_head-buyer_guid
     INTO TABLE @lt_customer_info.

      APPEND ls_invoice_head           TO et_invoice_header.
      APPEND LINES OF lt_invoice_item  TO et_invoice_item.
      APPEND LINES OF lt_customer_info TO et_customer_info.
    ENDSELECT.

    "Remove duplicates
    SORT et_customer_info BY customer_guid.
    DELETE ADJACENT DUPLICATES FROM et_customer_info.
  ENDMETHOD.


  METHOD open_sql_subquery.

    "Selection of invoices paid on a specified date
    "plus business partner and product information

    DATA lv_payment_date_min TYPE timestamp.
    DATA lv_payment_date_max TYPE timestamp.

    CONVERT DATE iv_payment_date TIME '0001'
      INTO TIME STAMP lv_payment_date_min TIME ZONE 'UTC'.
    CONVERT DATE iv_payment_date TIME '2359'
      INTO TIME STAMP lv_payment_date_max TIME ZONE 'UTC'.

    "Retrieve all invoice header which were paid on the requested date
    SELECT
     node_key       AS invoice_guid,
     created_at     AS created_at,
     changed_at     AS paid_at,
     buyer_guid
   FROM
     snwd_so_inv_head
       WHERE
     payment_status = 'P'
     AND changed_at BETWEEN @lv_payment_date_min AND @lv_payment_date_max
   ORDER BY invoice_guid
   INTO TABLE @et_invoice_header.

    "Get the items of those invoices
    SELECT
        node_key   AS item_guid,
        parent_key AS invoice_guid,
        product_guid,
        gross_amount,
        currency_code
     FROM snwd_so_inv_item
     WHERE  parent_key IN
          ( SELECT node_key FROM snwd_so_inv_head
               WHERE payment_status = 'P'
                 AND changed_at
                       BETWEEN @lv_payment_date_min AND @lv_payment_date_max )
     ORDER BY item_guid, invoice_guid, product_guid
     INTO TABLE @et_invoice_item.

    "Get the information about the customers
    SELECT
        bpa~node_key     AS customer_guid,
        bpa~bp_id        AS customer_id,
        bpa~company_name AS customer_name,
        ad~country,
        ad~postal_code,
        ad~city
      FROM snwd_bpa AS bpa
      JOIN snwd_ad AS ad ON ad~node_key = bpa~address_guid
      WHERE bpa~node_key IN ( SELECT buyer_guid FROM snwd_so_inv_head
               WHERE payment_status = 'P'
                 AND changed_at
                       BETWEEN @lv_payment_date_min AND @lv_payment_date_max )
      ORDER BY customer_id
      INTO TABLE @et_customer_info.

  ENDMETHOD.
ENDCLASS.
