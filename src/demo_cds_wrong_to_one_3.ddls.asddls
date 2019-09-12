@AbapCatalog.sqlViewName: 'DEMOCDSWTO3'
define view demo_cds_wrong_to_one_3
  as select from
                             scarr as c
      left outer to one join spfli as p on
        c.carrid = p.carrid
    {
      count(*) as cnt
    }
