REPORT demo_amdp_db_schema.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    IF NOT cl_abap_dbfeatures=>use_features(
          EXPORTING
            requested_features =
              VALUE #( ( cl_abap_dbfeatures=>call_amdp_method ) ) ).
      cl_demo_output=>display(
        `Current database system does not support AMDP procedures` ).
      RETURN.
    ENDIF.

    TRY.
        cl_demo_amdp_db_schema=>get_schemas_physical(
          IMPORTING schemas = DATA(schemas_test) ).
      CATCH cx_amdp_error INTO DATA(amdp_error).
        cl_demo_output=>display( amdp_error->get_text( ) ).
        RETURN.
    ENDTRY.

    TRY.
        cl_demo_amdp_db_schema=>get_schemas_logical(
          IMPORTING schemas = DATA(schemas) ).
      CATCH cx_amdp_error INTO amdp_error.
        cl_demo_output=>display( amdp_error->get_text( ) ).
        RETURN.
    ENDTRY.

    ASSERT schemas_test = schemas.
    cl_demo_output=>display( schemas ).

  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
