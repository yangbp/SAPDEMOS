@AbapCatalog.sqlViewName: 'DEMO_CDS_ASSOC'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define view demo_cds_association(
 _spfli_scarr,
 id,
 carrier,
 flight,
 departure,
 destination
 )
 as select from
 spfli
 association [1..1] to scarr as _spfli_scarr on
 $projection.carrid = _spfli_scarr.carrid
 {
 _spfli_scarr,
 key spfli.carrid,
 key _spfli_scarr.carrname,
 key spfli.connid,
 spfli.cityfrom,
 spfli.cityto
 }            
  
  
  
 