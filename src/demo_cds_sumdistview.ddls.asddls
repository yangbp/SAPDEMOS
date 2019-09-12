@AbapCatalog.sqlViewName: 'DEMO_CDS_SUDIV'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define view demo_cds_sumdistview
 as select from
 demo_cds_sumdist
 {
 key client,
 key carrname,
 key distid,
 sum_distance
 }            
  
  
  
 