@AbapCatalog.sqlViewName: 'DEMO_CDS_ASC_SPF'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define view demo_cds_assoc_spfli
  as select from
    spfli
    association        to sflight  as _sflight  on
          spfli.carrid = _sflight.carrid
      and spfli.connid = _sflight.connid
    association [1..1] to sairport as _sairport on
      spfli.airpfrom = _sairport.id
    {
      _sflight,
      _sairport,
      carrid,
      connid,
      airpfrom
    }
