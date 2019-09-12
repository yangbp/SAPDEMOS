@AbapCatalog.sqlViewName: 'DEMO_CDS_ORIG'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@AbapCatalog.viewEnhancementCategory: [#PROJECTION_LIST]
define view demo_cds_original_view
 as select from
 spfli
 join scarr on
 scarr.carrid = spfli.carrid
 {
 key scarr.carrname as carrier,
 key spfli.connid as flight,
 spfli.cityfrom as departure,
 spfli.cityto as destination
 };            
  
  
  
 