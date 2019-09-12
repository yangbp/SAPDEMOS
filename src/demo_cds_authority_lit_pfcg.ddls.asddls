@AbapCatalog.sqlViewName: 'DEMO_CDS_LITPFCG'
@AccessControl.authorizationCheck: #CHECK
define view demo_cds_auth_lit_pfcg
 as select from
 scarr
 {
 key carrid,
 carrname,
 currcode,
 url
 };            
  
  
  
 