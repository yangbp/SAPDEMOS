REPORT demo_amdp_vs_open_sql.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA(out) = cl_demo_output=>new( ).

    IF NOT cl_abap_dbfeatures=>use_features(
          EXPORTING
            requested_features =
              VALUE #( ( cl_abap_dbfeatures=>call_amdp_method ) ) ).
      cl_demo_output=>display(
        `Current database system does not support AMDP procedures` ).
      RETURN.
    ENDIF.

    DATA time_stamps TYPE TABLE OF timestampl.
    SELECT changed_at
           FROM snwd_so_inv_head UP TO 100 ROWS
           INTO TABLE time_stamps.                      "#EC CI_NOWHERE
    IF time_stamps IS INITIAL.
      out->display( 'You must create database entries' &
                    ' with program RS_EPM_DGC_HANA first ...' ).
      RETURN.
    ENDIF.
    DATA(rnd) =  cl_abap_random_int=>create(
                   seed = CONV i( sy-uzeit )
                   min  = 1
                   max  = lines( time_stamps ) )->get_next( ).
    CONVERT TIME STAMP time_stamps[ rnd ] TIME ZONE 'UTC'
                       INTO DATE DATA(payment_date).
    cl_demo_input=>request( CHANGING field = payment_date ).

    DATA(oref) = NEW cl_demo_amdp_vs_open_sql( ).

    TRY.
        GET RUN TIME FIELD DATA(t01).
        oref->amdp(
          EXPORTING iv_payment_date   = payment_date
                    iv_clnt           = sy-mandt
          IMPORTING et_invoice_header = DATA(invoice_header)
                    et_invoice_item   = DATA(invoice_item)
                    et_customer_info  = DATA(customer_info) ) .
        GET RUN TIME FIELD DATA(t02).
      CATCH cx_amdp_error INTO DATA(amdp_error).
        out->display( amdp_error->get_text( ) ).
        RETURN.
    ENDTRY.

    GET RUN TIME FIELD DATA(t11).
    oref->open_sql_nested_select(
      EXPORTING iv_payment_date   = payment_date
      IMPORTING et_invoice_header = DATA(invoice_header1)
                et_invoice_item   = DATA(invoice_item1)
                et_customer_info  = DATA(customer_info1) ) .
    GET RUN TIME FIELD DATA(t12).

    GET RUN TIME FIELD DATA(t21).
    oref->open_sql_for_all_entries(
      EXPORTING iv_payment_date   = payment_date
      IMPORTING et_invoice_header = DATA(invoice_header2)
                et_invoice_item   = DATA(invoice_item2)
                et_customer_info  = DATA(customer_info2) ) .
    GET RUN TIME FIELD DATA(t22).

    GET RUN TIME FIELD DATA(t31).
    oref->open_sql_subquery(
      EXPORTING iv_payment_date   = payment_date
      IMPORTING et_invoice_header = DATA(invoice_header3)
                et_invoice_item   = DATA(invoice_item3)
                et_customer_info  = DATA(customer_info3) ) .
    GET RUN TIME FIELD DATA(t32).

    IF lines( invoice_header ) IS INITIAL.
      out->display( 'Nothing found' ).
      RETURN.
    ENDIF.

    out->begin_section( `Lines of tables filled`
      )->write( |INVOICE_HEADER: {
                   lines( invoice_header ) }\n\n| &&
                |INVOICE_ITEM:   {
                   lines( invoice_item ) }\n\n|  &&
                |CUSTOMER_INFO:  {
                   lines( customer_info ) }| ).

    out->next_section( `Runtime AMDP `
      )->write( |{ CONV decfloat34(
                  ( t02 - t01 ) / 1000000 ) } seconds| ).

    IF invoice_header  = invoice_header1 AND
       invoice_item    = invoice_item1   AND
       customer_info   = customer_info1.
      out->next_section( `Runtime Open SQL with Nested SELECT`
        )->write( |{ CONV decfloat34(
                      ( t12 - t11 ) / 1000000 ) } seconds| ).
    ELSE.
      out->write( 'Different results in Open SQL with Nested SELECT' ).
    ENDIF.

    IF invoice_header  = invoice_header2 AND
       invoice_item    = invoice_item2   AND
       customer_info   = customer_info2.
      out->next_section( `Runtime Open SQL with FOR ALL ENTRIES`
        )->write( |{ CONV decfloat34(
                      ( t22 - t21 ) / 1000000 ) } seconds| ).
    ELSE.
      out->write(
        'Different results in Open SQL with FOR ALL ENTRIES' ).
    ENDIF.

    IF invoice_header  = invoice_header3 AND
       invoice_item    = invoice_item3   AND
       customer_info   = customer_info3.
      out->next_section( `Runtime Open SQL with Subquery`
        )->write( |{ CONV decfloat34(
                      ( t32 - t31 ) / 1000000 ) } seconds| ).
    ELSE.
      out->write( 'Different results in Open SQL with Subquery' ).
    ENDIF.


    out->display( ).

  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
