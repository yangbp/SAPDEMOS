REPORT demo_cds_association.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    SELECT *
           FROM demo_cds_association
           ORDER BY id, carrier, flight
           INTO TABLE @DATA(result1).

    SELECT id,
           \_spfli_scarr-carrname AS carrier,
           flight,
           departure,
           destination
           FROM demo_cds_association
           ORDER BY id, carrier, flight
           INTO TABLE @DATA(result2).

    SELECT *
           FROM demo_cds_scarr_spfli
           ORDER BY id, carrier, flight
           INTO TABLE @DATA(test).

    ASSERT result1 = result2.
    ASSERT result1 = test.

    cl_demo_output=>display( result1 ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
