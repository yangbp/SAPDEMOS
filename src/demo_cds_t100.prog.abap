REPORT demo_cds_t100.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    SELECT *
           FROM demo_cds_select_t100_langu
           INTO TABLE @DATA(result1).

    SELECT *
           FROM demo_cds_select_t100
           INTO TABLE @DATA(result2).

    ASSERT result1 = result2.

    cl_demo_output=>display( result2 ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
