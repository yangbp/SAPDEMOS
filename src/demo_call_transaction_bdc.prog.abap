REPORT demo_call_transaction_bdc.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.

    DATA class_name TYPE c LENGTH 30 VALUE 'CL_ABAP_BROWSER'.

    DATA bdcdata_tab TYPE TABLE OF bdcdata.

    DATA opt TYPE ctu_params.

    bdcdata_tab = VALUE #(
      ( program  = 'SAPLSEOD' dynpro   = '1000' dynbegin = 'X' )
      ( fnam = 'BDC_CURSOR'       fval = 'SEOCLASS-CLSNAME' )
      ( fnam = 'SEOCLASS-CLSNAME' fval = class_name )
      ( fnam = 'BDC_OKCODE'       fval = '=WB_DISPLAY' ) ).

    opt-dismode = 'E'.
    opt-defsize = 'X'.

    TRY.
        CALL TRANSACTION 'SE24' WITH AUTHORITY-CHECK
                                USING bdcdata_tab OPTIONS FROM opt.
      CATCH cx_sy_authorization_error ##NO_HANDLER.
    ENDTRY.

  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
