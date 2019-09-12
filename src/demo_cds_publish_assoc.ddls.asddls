@AbapCatalog.sqlViewName: 'DEMO_CDS_PUBASC'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define view demo_cds_publish_assoc
 as select from
 scarr
 association to demo_cds_assoc_spfli as _spfli on
 scarr.carrid = _spfli.carrid
 {
 _spfli,
 scarr.carrid as scarr_carrid,
 _spfli._sflight,
 _spfli.carrid,
 _spfli.connid
 }            
  
  
  
 