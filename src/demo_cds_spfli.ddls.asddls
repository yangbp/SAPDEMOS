@AbapCatalog.sqlViewName: 'DEMO_CDS_PRJCTN'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define view demo_cds_spfli
 as select from
 spfli
 {
 key spfli.carrid,
 key spfli.connid,
 spfli.cityfrom,
 spfli.cityto
 }            
  
  
  
 