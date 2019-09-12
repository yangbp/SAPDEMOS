@AbapCatalog.sqlViewName: 'demo_cds_timfnc'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define view demo_cds_time_functions
 as select from
 demo_expressions
 {
 id,
 tims1 as time1,
 tims_is_valid(tims1) as valid1
 }            
  
  
  
 