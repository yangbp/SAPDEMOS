class CL_DEMO_CR_CUSTOMERS_MNGR definition
  public
  final
  create public.

public section.
*"* public components of class CL_DEMO_CR_CUSTOMERS_MNGR
*"* do not include other source files here!!!

  class-methods DELETE_CUSTOMER_BY_ID
    importing
      !I_CUSTOMER_ID type DEMO_CR_CUSTOMER_ID
    raising
      CX_DEMO_CR_CUSTOMER .
  class-methods DELETE_ALL .
  class-methods CREATE_CUSTOMER
    importing
      !I_CUSTOMER type DEMO_CR_CUSTOMER_NAME
    returning
      value(R_CUSTOMER_ID) type DEMO_CR_CUSTOMER_ID
    raising
      CX_DEMO_CR_CUSTOMER .
  class-methods GET_CUSTOMER_BY_NAME
    importing
      value(I_NAME) type DEMO_CR_CUSTOMER_NAME
    returning
      value(R_CUSTOMERS) type DEMO_CR_CUSTOMERS_TT .
  class-methods GET_CUSTOMER_BY_ID
    importing
      !I_ID type DEMO_CR_CUSTOMER_ID
    returning
      value(R_CUSTOMER) type DEMO_CR_SCUSTOMER .
  class-methods GET_ALL
    returning
      value(R_CUSTOMERS) type DEMO_CR_CUSTOMERS_TT .
*"* protected components of class ZCL_MA_CUSTOMERS_MANAGER
*"* do not include other source files here!!!
protected section.
private section.
*"* private components of class ZCL_MA_CUSTOMERS_MANAGER
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_DEMO_CR_CUSTOMERS_MNGR IMPLEMENTATION.


METHOD CREATE_CUSTOMER.

  DATA:
    l_customer_wa TYPE demo_cr_customrs,
    l_customer_tab TYPE demo_cr_customers_tt,
    l_max_customer_wa LIKE LINE OF l_customer_tab.

  "Find new customer id
  l_customer_tab = cl_demo_cr_customers_mngr=>get_all( ).
  SORT l_customer_tab BY id DESCENDING.
  READ TABLE l_customer_tab INTO l_max_customer_wa INDEX 1.
  l_max_customer_wa-id = l_max_customer_wa-id + 1.
  l_max_customer_wa-name = i_customer.

  MOVE-CORRESPONDING l_max_customer_wa TO l_customer_wa. "#EC ENHOK
  INSERT demo_cr_customrs FROM l_customer_wa.

  IF sy-subrc <> 0.
    RAISE EXCEPTION TYPE cx_demo_cr_customer_modify
      EXPORTING textid = cx_demo_cr_customer_modify=>customer_create
                name   = i_customer.
  ENDIF.

  r_customer_id = l_max_customer_wa-id.

ENDMETHOD.


METHOD DELETE_ALL.

  DELETE FROM demo_cr_customrs. "#EC CI_NOWHERE

ENDMETHOD.


METHOD DELETE_CUSTOMER_BY_ID.

  DELETE FROM demo_cr_customrs
         WHERE id = i_customer_id.

  IF sy-subrc <> 0.
    RAISE EXCEPTION TYPE cx_demo_cr_customer_modify
      EXPORTING textid = cx_demo_cr_customer_modify=>customer_delete.
  ENDIF.

ENDMETHOD.


METHOD GET_ALL.

  SELECT *
         FROM demo_cr_customrs
         INTO CORRESPONDING FIELDS OF TABLE r_customers.

ENDMETHOD.


METHOD GET_CUSTOMER_BY_ID.

  SELECT SINGLE *
         FROM demo_cr_customrs
         INTO CORRESPONDING FIELDS OF r_customer
         WHERE id = i_id.

ENDMETHOD.


METHOD GET_CUSTOMER_BY_NAME.

  IF i_name CA '*'.
    REPLACE ALL OCCURRENCES
         OF '*'
         IN i_name
         WITH '%'.
    SELECT *
           FROM demo_cr_customrs
           INTO CORRESPONDING FIELDS OF TABLE r_customers
           WHERE name LIKE i_name.
  ELSE.
    SELECT *
           FROM demo_cr_customrs
           INTO CORRESPONDING FIELDS OF TABLE r_customers
           WHERE name = i_name.
  ENDIF.

ENDMETHOD.
ENDCLASS.
