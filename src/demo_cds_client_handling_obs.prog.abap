REPORT demo_cds_client_handling_obs.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DATA(out) = cl_demo_output=>new( ).

    out->next_section( 'Data Types' ).

    out->write(
      name = 'Not client dependent, no client field, CDS entity'
      data = CAST cl_abap_structdescr(
                    cl_abap_typedescr=>describe_by_name(
                      'DEMO_CDS_SPFLI_CLIENT_2' )
                        )->components ).

    out->write(
      name = 'Not client dependent, no client field, database view'
      data = CAST cl_abap_structdescr(
                    cl_abap_typedescr=>describe_by_name(
                      'DEMO_CDS_PRJCTN2' )
                        )->components ).

    out->write(
      name = 'Not client dependent, client field, CDS entity'
      data = CAST cl_abap_structdescr(
                    cl_abap_typedescr=>describe_by_name(
                      'DEMO_CDS_SPFLI_CLIENT_3' )
                        )->components ).

    out->write(
      name = 'Not client dependent, client field, database view'
      data = CAST cl_abap_structdescr(
                    cl_abap_typedescr=>describe_by_name(
                      'DEMO_CDS_PRJCTN3' )
                        )->components ).

    out->next_section( 'SELECT Statements' ).

    SELECT *
           FROM demo_cds_spfli_client_2
           ORDER BY carrid, connid
           INTO TABLE @DATA(result1)
           UP TO 1 ROWS.
    out->write(
      name =  'Not client dependent, no client field, CDS entity'
      data = result1 ).

    SELECT *
           FROM demo_cds_prjctn2
           ORDER BY carrid, connid
           INTO TABLE @DATA(result2)
           UP TO 1 ROWS.
    out->write(
      name =  'Not client dependent, no client field, database view'
      data = result2 ).

    SELECT *
           FROM demo_cds_spfli_client_3
           WHERE mandt = @sy-mandt
           ORDER BY carrid, connid
           INTO TABLE @DATA(result3)
           UP TO 1 ROWS.
    out->write(
      name = 'Not client dependent, client field, CDS entity'
      data = result3 ).

    SELECT *
           FROM demo_cds_prjctn3 CLIENT SPECIFIED
           WHERE mandt = @sy-mandt
           ORDER BY carrid, connid
           INTO TABLE @DATA(result4)
           UP TO 1 ROWS.
    out->write(
      name = 'Not client dependent, client field, database view,' &
             ' CLIENT SPECIFIED'
      data = result4 ).

    out->display( ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
