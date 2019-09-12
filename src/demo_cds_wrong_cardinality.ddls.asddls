@AbapCatalog.sqlViewName: 'DEMOCDSWRGC'
define view demo_cds_wrong_cardinality
  as select from
    scarr
    association to spfli as _spfli on
      _spfli.carrid = scarr.carrid
    {
      scarr.carrid   as carrid,
      scarr.carrname as carrname,
      _spfli.connid  as connid
    }
