@AbapCatalog.sqlViewName: 'DEMO_CDS_CSTCLNT'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define view demo_cds_cast_clnt
 as select from
 scarr
 {
 key cast ( 'XXX' as s_mandt )
 as pseudo_client,
 key carrid,
 carrname
 };            
  
  
  
 