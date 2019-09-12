@AbapCatalog.sqlViewName: 'DEMO_CDS_JOIN'
@AccessControl.authorizationCheck: #NOT_ALLOWED
define view demo_cds_scarr_spfli(
    id,
    carrier,
    flight,
    departure,
    destination
  )
  as select from
           spfli
      join scarr on
        scarr.carrid = spfli.carrid
    {
      key spfli.carrid,
      key scarr.carrname,
      key spfli.connid,
          spfli.cityfrom,
          spfli.cityto
    }
