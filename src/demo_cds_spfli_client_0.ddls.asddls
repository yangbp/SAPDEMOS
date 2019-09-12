@AbapCatalog.sqlViewName: 'DEMO_CDS_PRJCTN0'
@AccessControl.authorizationCheck: #NOT_ALLOWED
@ClientHandling.type: #CLIENT_DEPENDENT
@ClientHandling.algorithm: #AUTOMATED
define view demo_cds_spfli_client_0
  as select from
    spfli
    {
      key spfli.carrid,
      key spfli.connid,
          spfli.cityfrom,
          spfli.cityto
    }
