REPORT demo_amdp_l_language.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.

    IF cl_db_sys=>is_in_memory_db = abap_false.
      cl_demo_output=>display(
        `Example can be executed on SAP HANA Database only` ).
      LEAVE PROGRAM.
    ENDIF.

    DATA(text) = `World`.
    cl_demo_input=>request( CHANGING field = text ).
    IF text IS INITIAL.
      RETURN.
    ENDIF.

    TRY.
        NEW cl_demo_amdp_l_hello_world(
              )->hello_world( EXPORTING text  = text
                              IMPORTING texts = DATA(texts) ).
      CATCH cx_amdp_error INTO DATA(amdp_error).
        cl_demo_output=>display( amdp_error->get_text( ) ).
        RETURN.
    ENDTRY.

    cl_demo_output=>display( texts ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
