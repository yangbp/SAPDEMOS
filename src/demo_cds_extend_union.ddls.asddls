@AbapCatalog.sqlViewAppendName: 'DEMO_CDS_EXTUNI'
extend view demo_cds_union with demo_cds_extend_union
 {
 c as c3,
 d as c4
 }
union
 {
 f as c3,
 g as c4
 }
union all
 {
 k as c3,
 l as c4
 };            
  
  
  
 