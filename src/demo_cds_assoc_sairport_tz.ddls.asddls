@AbapCatalog.sqlViewName: 'DEMO_CDS_ASCSRTZ'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define view demo_cds_assoc_sairport_tz
  with parameters
    tz : s_tzone
  as select from sairport
  association to demo_cds_assoc_spfli_scarr as _spfli on
    sairport.id = _spfli.airpfrom
  {
    _spfli,
    id
  }
  where
    time_zone = :tz
