@AbapCatalog.sqlViewName: 'demo_cds_tsfnc'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define view demo_cds_timestamp_functions
 as select from
 demo_expressions
 {
 id,
 timestamp1 as timestamp1,
 tstmp_is_valid(timestamp1) as valid1,
 tstmp_seconds_between(
 tstmp_current_utctimestamp(),
 tstmp_add_seconds(
 timestamp1,
 cast( num1 as abap.dec(15,0) ),
 'FAIL'),
 'FAIL') as difference
 }            
  
  
  
 