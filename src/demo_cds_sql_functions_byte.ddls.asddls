@AbapCatalog.sqlViewName: 'DEMO_CDS_BINFUNC'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define view demo_cds_sql_functions_byte
 as select from
 demo_expressions
 {
 bintohex( raw1 ) as r_bintohex,
 hextobin( char1 ) as r_hextobin
 }            
  
  
  
 