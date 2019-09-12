REPORT demo_call_hana_db_procedure.

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
              VALUE #( ( cl_abap_dbfeatures=>call_database_procedure )
                       ( cl_abap_dbfeatures=>call_amdp_method ) ) ).
      cl_demo_output=>display(
      `Current database system does not support all procedure calls` ).
      RETURN.
    ENDIF.

    DATA carrier TYPE spfli-carrid VALUE 'LH'.
    cl_demo_input=>request( CHANGING field = carrier ).
    DATA(oref) =
      NEW cl_demo_call_hana_db_procedure( to_upper( carrier ) ).

    DATA(osql_result) = oref->osql( ).
    DATA(adbc_result) = oref->adbc( ).
    DATA(cdbp_result) = oref->cdbp( ).
    DATA(amdp_result) = oref->amdp( ).

    IF osql_result = adbc_result AND
       osql_result = cdbp_result AND
       osql_result = amdp_result.
      out->begin_section(
        `Result of Open SQL, ADBC, CALL DATABASE PROCEDURE, and AMDP`
        )->write( amdp_result ).
    ELSE.
      out->write( 'Error' ).
    ENDIF.
    out->display( ).

  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
