@AbapCatalog.sqlViewName: 'DEMO_CDS_SQLFUNC'
@AccessControl.authorizationCheck: #NOT_REQUIRED
//not maintained any longer
//replaced by demo_cds_sql_functions_num, _string, _byte
define view demo_cds_sql_functions
 as select from
 demo_expressions
 {
 'dummy' as dummy
 }            
  
  
  
 