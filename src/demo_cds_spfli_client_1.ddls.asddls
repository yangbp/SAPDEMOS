@AbapCatalog.sqlViewName: 'DEMO_CDS_PRJCTN1'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@ClientHandling.type: #CLIENT_DEPENDENT
@ClientHandling.algorithm: #AUTOMATED
define view demo_cds_spfli_client_1
  as select from
    spfli
    {
      key spfli.mandt,
      key spfli.carrid,
      key spfli.connid,
          spfli.cityfrom,
          spfli.cityto
    }           
  
  
  
 