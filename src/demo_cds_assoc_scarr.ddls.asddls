@AbapCatalog.sqlViewName: 'DEMO_CDS_ASC_CAR'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define view demo_cds_assoc_scarr
  as select from scarr
  association to demo_cds_assoc_spfli as _spfli on
    scarr.carrid = _spfli.carrid
  {
    _spfli,
    carrid,
    carrname
  }
