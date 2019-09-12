REPORT demo_amdp_mesh.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
  PRIVATE SECTION.
    TYPES:
      BEGIN OF output_line,
        position TYPE string,
        product  TYPE string,
      END OF output_line,
      output TYPE STANDARD TABLE OF output_line WITH EMPTY KEY.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA order_ids TYPE RANGE OF snwd_so-so_id.
    DATA(rows) = 1.
    cl_demo_input=>request( EXPORTING text = `Orders`
                            CHANGING field = rows ).
    SELECT 'I' AS sign, 'EQ' AS option, so_id AS low
           FROM snwd_so
           ORDER BY low
           INTO CORRESPONDING FIELDS OF TABLE @order_ids
           UP TO @rows ROWS. "#EC CI_NOWHERE

    DATA(out) = cl_demo_output=>new( ).
    TRY.
        DATA(order) = NEW cl_demo_amdp_mesh( )->select( order_ids ).
      CATCH cx_amdp_error INTO DATA(amdp_error).
        out->display( amdp_error->get_text( ) ).
        RETURN.
    ENDTRY.

    LOOP AT order-orders ASSIGNING FIELD-SYMBOL(<order>).
      out->begin_section( |Order #{ <order>-so_id }| ).
      ASSIGN order-orders\_buyers[ <order> ]
        TO FIELD-SYMBOL(<buyer>).
      out->begin_section(
        |Buyer: { <buyer>-company_name } | &&
        |in { order-bupas\_addresses[ <buyer> ]-city } | ).
      out->write(
        name  = 'Sales Order Items'
        data = VALUE output(
          FOR <item> IN order-orders\_items[ <order> ]
          ( position = <item>-so_item_pos
            product = order-items\_products[ <item> ]-product_id
          ) ) ).
      out->end_section( )->end_section( ).
    ENDLOOP.
    out->display( ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
