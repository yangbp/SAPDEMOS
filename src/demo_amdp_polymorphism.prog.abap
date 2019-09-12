REPORT demo_amdp_polymorphism.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA: iref TYPE REF TO if_demo_amdp_interface,
          cref TYPE REF TO cl_demo_amdp_superclass.

    IF cl_abap_dbfeatures=>use_features(
          EXPORTING
            requested_features =
              VALUE #( ( cl_abap_dbfeatures=>call_amdp_method ) ) ).
      cref = NEW cl_demo_amdp_subclass_hdb( ).
      iref = NEW cl_demo_amdp_implement_hdb( ).
    ELSE.
      cref = NEW cl_demo_amdp_subclass_open( ).
      iref = NEW cl_demo_amdp_implement_open( ).
    ENDIF.

    TRY.
        iref->get_scarr( EXPORTING clnt     = sy-mandt
                         IMPORTING carriers = DATA(result1) ).
        cref->get_scarr( EXPORTING clnt     = sy-mandt
                         IMPORTING carriers = DATA(result2) ).
      CATCH cx_amdp_error INTO DATA(amdp_error).
        cl_demo_output=>display( amdp_error->get_text( ) ).
        RETURN.
    ENDTRY.

    ASSERT result1 = result2.

    cl_demo_output=>display( name = 'Result'
                             data = result1 ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
