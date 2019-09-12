@AbapCatalog.sqlViewAppendName: 'DEMO_CDS_EXTAGG'
extend view demo_cds_aggregate with demo_cds_extend_aggregate
 {
 connid, 
 sum(distance) as sum_distance
 }
 group by
 connid;            
  
  
  
 