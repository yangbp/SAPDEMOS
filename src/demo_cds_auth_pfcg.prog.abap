REPORT demo_cds_auth_pfcg.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    "Select from CDS database view
    SELECT *
           FROM demo_cds_pfcg
           ORDER BY carrid
           INTO TABLE @DATA(result_auth_check).
    LOOP AT result_auth_check INTO DATA(wa_auth_check).
      AUTHORITY-CHECK OBJECT 'S_CARRID'
                          ID 'CARRID' FIELD wa_auth_check-carrid
                          ID 'ACTVT'  FIELD '03'.
      IF sy-subrc <> 0.
        DELETE result_auth_check.
      ENDIF.
    ENDLOOP.

    "Select from CDS entity
    SELECT *
           FROM demo_cds_auth_pfcg
           ORDER BY carrid
           INTO TABLE @DATA(result).

    "Check if results are the same
    TYPES t_demo_cds_auth_pfcg TYPE
                               STANDARD TABLE OF demo_cds_auth_pfcg
                               WITH EMPTY KEY.
    ASSERT VALUE t_demo_cds_auth_pfcg(
      FOR wa IN result_auth_check ( CORRESPONDING #( wa ) ) ) = result.

    cl_demo_output=>display( result ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
