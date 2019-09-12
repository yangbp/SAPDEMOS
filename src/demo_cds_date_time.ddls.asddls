@AbapCatalog.sqlViewName: 'demo_cds_datim'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define view demo_cds_date_time
  as select from
    demo_expressions
    {
      tstmp_current_utctimestamp() as tstmp,
      tstmp_to_dats( tstmp_current_utctimestamp(),
                     abap_system_timezone( $session.client,'NULL' ),
                     $session.client,
                     'NULL' )      as dat,
      tstmp_to_tims( tstmp_current_utctimestamp(),
                     abap_system_timezone( $session.client,'NULL' ),
                     $session.client,
                     'NULL' )      as tim,
      tstmp_to_dst( tstmp_current_utctimestamp(),
                    abap_system_timezone( $session.client,'NULL' ),
                    $session.client,
                    'NULL' )       as dst,
      dats_tims_to_tstmp( dats1,
                          tims1,
                          abap_system_timezone( $session.client,'NULL' ),
                          $session.client,
                         'NULL' )  as dat_tim
    }         
  
  
  
 