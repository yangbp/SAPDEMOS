@AbapCatalog.sqlViewName: 'DEMO_CDS_JN1'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define view demo_cds_join1
  as select from spfli
    inner join   scarr on
      spfli.carrid = scarr.carrid
  {
    scarr.carrname  as carrier,
    spfli.connid    as flight,
    spfli.cityfrom  as departure,
    spfli.cityto    as arrival
  } 
  
  
  
 