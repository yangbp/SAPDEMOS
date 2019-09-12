@AbapCatalog.sqlViewName: 'DEMO_CDS_AGG'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@AbapCatalog.viewEnhancementCategory: [#PROJECTION_LIST,#GROUP_BY]
define view demo_cds_aggregate
 as select from
 spfli 
 {
 carrid,
 sum(fltime) as sum_fltime
 }
 group by
 carrid;            
  
  
  
 