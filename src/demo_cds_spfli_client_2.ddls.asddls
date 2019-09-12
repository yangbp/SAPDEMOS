@AbapCatalog.sqlViewName: 'DEMO_CDS_PRJCTN2'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@ClientDependent: false
define view demo_cds_spfli_client_2
 as select from
 spfli
 {
 key spfli.carrid,
 key spfli.connid,
 spfli.cityfrom,
 spfli.cityto
 }            
  
  
  
 