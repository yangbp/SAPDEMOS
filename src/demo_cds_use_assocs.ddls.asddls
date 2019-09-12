@AbapCatalog.sqlViewName: 'DEMO_CDS_USE_ASC'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define view demo_cds_use_assocs
 with parameters
 p_carrid :s_carrid
 as select from
 demo_cds_assoc_scarr as scarr
 {
 scarr.carrname,
 scarr._spfli.connid,
 scarr._spfli._sflight.fldate,
 scarr._spfli._sairport.name
 }
 where
 scarr.carrid = :p_carrid            
  
  
  
 