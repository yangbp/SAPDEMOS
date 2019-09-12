@AbapCatalog.sqlViewName: 'demo_cds_datfnc'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define view demo_cds_date_functions
 with parameters
 p_days :abap.int4,
 p_months :abap.int4
 as select from
 demo_expressions
 {
 id,
 dats1 as date1,
 dats_is_valid(dats1) as valid1,
 dats2 as date2,
 dats_is_valid(dats2) as valid2,
 dats_days_between(dats1,dats2) as difference,
 dats_add_days(dats1,:p_days,'INITIAL') as day1,
 dats_add_months(dats2,:p_months,'FAIL') as day2
 }            
  
  
  
 