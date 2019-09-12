@AbapCatalog.sqlViewName: 'DEMO_CDS_PFCG'
@AccessControl.authorizationCheck: #CHECK
define view demo_cds_auth_pfcg
 as select from
 scarr
 {
 key carrid,
 carrname,
 currcode,
 url
 };            
  
  
  
 