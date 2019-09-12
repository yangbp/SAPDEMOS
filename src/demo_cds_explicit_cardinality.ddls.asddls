@AbapCatalog.sqlViewName: 'DEMOCDSEXPC'
define view demo_cds_explicit_cardinality
  as select from
    scarr
    association [1..*] to spfli as _spfli on
      _spfli.carrid = scarr.carrid
    {
      scarr.carrid   as carrid,
      scarr.carrname as carrname,
      _spfli.connid  as connid
    }
