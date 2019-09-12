REPORT demo_cds_searched_case.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    SELECT *
           FROM demo_cds_searched_case
           ORDER BY carrid, connid
           INTO TABLE @DATA(result).
    cl_demo_output=>display( result ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
