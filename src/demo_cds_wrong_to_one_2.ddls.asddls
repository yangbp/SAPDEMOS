@AbapCatalog.sqlViewName: 'DEMOCDSWTO2'
define view demo_cds_wrong_to_one_2
  as select from
                             scarr as c
      left outer to one join spfli as p on
        c.carrid = p.carrid
    {
      c.carrid   as carrid,
      c.carrname as carrname
    }
