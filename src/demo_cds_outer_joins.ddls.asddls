@AbapCatalog.sqlViewName: 'DEMO_CDS_OUTJOIN'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define view demo_cds_outer_joins
 with parameters
 p_carrid :s_carrid
 as select from
 scarr
 left outer join spfli on
 spfli.carrid = scarr.carrid
 left outer join sflight on
 sflight.carrid = spfli.carrid
 and sflight.connid = spfli.connid
 left outer join sairport on
 sairport.id = spfli.airpfrom
 {
 scarr.carrname as carrname,
 spfli.connid as connid,
 sflight.fldate as fldate,
 sairport.name as name
 }
 where
 scarr.carrid = :p_carrid            
  
  
  
 