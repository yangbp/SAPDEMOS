@AbapCatalog.sqlViewName: 'DEMO_CDS_PTYPE'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define view demo_cds_parameter_type
 with parameters
 p_date :demodate,
 p_num :abap.dec( 10, 3 )
 as select from
 demo_expressions
 {
 key id,
 :p_date as col_date,
 :p_num + dec3 as col_num
 };            
  
  
  
 