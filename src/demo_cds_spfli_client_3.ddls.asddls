@AbapCatalog.sqlViewName: 'DEMO_CDS_PRJCTN3'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@ClientDependent: false
define view demo_cds_spfli_client_3
 as select from
 spfli
 {
 key spfli.mandt,
 key spfli.carrid,
 key spfli.connid,
 spfli.cityfrom,
 spfli.cityto
 }            
  
  
  
 