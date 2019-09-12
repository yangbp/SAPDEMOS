@AbapCatalog.sqlViewName: 'DEMO_CDS_SCASE'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define view demo_cds_searched_case
 as select from
 spfli
 {
 key carrid,
 key connid,
 distance,
 distid,
 case
 when distance >= 2000 then 'long-haul flight'
 when distance >= 1000 and
 distance < 2000 then 'medium-haul flight'
 when distance < 1000 then 'short-haul flight'
 else 'error'
 end as flight_type
 }
 where
 distid = 'MI'            
  
  
  
 