REPORT demo_cds_client_handling.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA(out) = cl_demo_output=>new( ).

    out->next_section( 'Data Types' ).

    out->write(
      name = 'Client dependent, no client field, CDS entity'
      data = CAST cl_abap_structdescr(
                    cl_abap_typedescr=>describe_by_name(
                      'DEMO_CDS_SPFLI_CLIENT_0' )
                        )->components ).

    out->write(
      name = 'Client dependent, no client field, database view'
      data = CAST cl_abap_structdescr(
                    cl_abap_typedescr=>describe_by_name(
                      'DEMO_CDS_PRJCTN0' )
                        )->components ).

    out->write(
      name = 'Client dependent, client field, CDS entity'
      data = CAST cl_abap_structdescr(
                    cl_abap_typedescr=>describe_by_name(
                      'DEMO_CDS_SPFLI_CLIENT_1' )
                        )->components ).

    out->write(
      name = 'Client dependent, client field, database view'
      data = CAST cl_abap_structdescr(
                    cl_abap_typedescr=>describe_by_name(
                      'DEMO_CDS_PRJCTN1' )
                        )->components ).

    out->next_section( 'SELECT Statements' ).

    SELECT *
           FROM demo_cds_spfli_client_0
           ORDER BY carrid, connid
           INTO TABLE @DATA(result1)
           UP TO 1 ROWS.
    out->write(
      name = 'Client dependent, no client field, CDS entity'
      data = result1 ).

    SELECT *
           FROM demo_cds_prjctn0
           ORDER BY carrid, connid
           INTO TABLE @DATA(result2)
           UP TO 1 ROWS.
    out->write(
      name = 'Client dependent, no client field, database view'
      data = result2 ).

    SELECT *
           FROM demo_cds_spfli_client_0
                CLIENT SPECIFIED demo_cds_spfli_client_0~myclient
           WHERE myclient = @sy-mandt
           ORDER BY carrid, connid
           INTO TABLE @DATA(result3)
           UP TO 1 ROWS.
    out->write(
      name = 'Client dependent, no client field, CDS entity,' &
             ' CLIENT SPECIFIED'
      data = result3 ).

    SELECT *
           FROM demo_cds_spfli_client_1
           ORDER BY carrid, connid
           INTO TABLE @DATA(result4)
           UP TO 1 ROWS.
    out->write(
      name = 'Client dependent, client field, CDS entity'
      data = result4 ).

    out->display( ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
