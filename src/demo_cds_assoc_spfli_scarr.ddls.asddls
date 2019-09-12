@AbapCatalog.sqlViewName: 'DEMO_CDS_ASCSPSC'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define view demo_cds_assoc_spfli_scarr
 as select from
 spfli
 association to scarr as _scarr on
 spfli.carrid = _scarr.carrid
 {
 _scarr,
 carrid,
 airpfrom
 }            
  
  
  
 