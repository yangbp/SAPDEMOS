REPORT demo_cds_timezone_functions.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DELETE FROM demo_expressions.
    INSERT demo_expressions FROM @( VALUE #( id = 'X' ) ).

    SELECT SINGLE *
           FROM demo_cds_timezone_functions
           INTO @DATA(result).

    DATA abap_system_tz TYPE timezone.
    CALL FUNCTION 'GET_SYSTEM_TIMEZONE'
      IMPORTING
        timezone = abap_system_tz.
    ASSERT result-system_tz = abap_system_tz.
    ASSERT result-user_tz   = sy-zonlo.

    cl_demo_output=>display( result ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
