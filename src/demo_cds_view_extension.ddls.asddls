@AbapCatalog.sqlViewAppendName: 'DEMO_CDS_EXTENS'
extend view demo_cds_original_view with demo_cds_view_extension
 {
 spfli.distance,
 spfli.distid as unit
 };            
  
  
  
 