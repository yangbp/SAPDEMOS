@AbapCatalog.sqlViewName: 'DEMO_CDS_ANIN2'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define view demo_cds_anno_inheritance_2
  as select from
           spfli
      join scarr on
        scarr.carrid = spfli.carrid
    {
      key spfli.carrid                               as id,
      key scarr.carrname                             as carrier,
          @EndUserText.label: 'YYYYYYYYYY'
      key spfli.connid                               as flight,
          spfli.cityfrom                             as departure,
          cast( spfli.cityto as demo_destination )   as destination
    }            
  
  
  
 