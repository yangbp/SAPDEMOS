@AbapCatalog.sqlViewName: 'DEMO_CDS_LITERAL'
@AccessControl.authorizationCheck: #CHECK
define view demo_cds_auth_literal
 as select from
 scarr
 {
 key carrid,
 carrname,
 currcode,
 url
 };            
  
  
  
 