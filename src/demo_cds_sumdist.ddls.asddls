@AbapCatalog.sqlViewName: 'DEMO_CDS_SUDI'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define view demo_cds_sumdist(
 client,
 carrname,
 distid,
 sum_distance
 )
 as select from
 scarr as s
 join spfli as p on
 s.carrid = p.carrid
 {
 key s.mandt,
 key s.carrname,
 key p.distid,
 sum(p.distance)
 }
 group by
 s.mandt,
 s.carrname,
 p.distid            
  
  
  
 