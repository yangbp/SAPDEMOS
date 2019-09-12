@AbapCatalog.sqlViewName: 'DEMO_CDS_JN2'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define view demo_cds_join2
  as select from spfli
  association to scarr as _scarr on
    spfli.carrid = _scarr.carrid
  {
    _scarr[inner].carrname as carrier,
    spfli.connid           as flight,
    spfli.cityfrom         as departure,
    spfli.cityto           as arrival
  } 
  
  
 