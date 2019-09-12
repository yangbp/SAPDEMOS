REPORT demo_cds_cross_join.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    SELECT *
           FROM demo_cds_cross_join
           INTO TABLE @DATA(itab)
           ORDER BY mandt, sprsl, msgnr.
    cl_demo_output=>display( itab ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
