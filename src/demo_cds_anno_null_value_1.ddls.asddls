@AbapCatalog.sqlViewName: 'DEMO_CDS_NULL1'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define view demo_cds_anno_null_value_1
  as select from
           spfli
      join scarr on
        scarr.carrid = spfli.carrid
    {          
          @EndUserText.heading: null
          @EndUserText.label: 'ID'
          @EndUserText.quickInfo: 'ID'
      key spfli.carrid                               as id,
          @EndUserText.label: 'Carrier'
          @EndUserText.quickInfo: 'Carrier'
      key scarr.carrname                             as carrier,
          @EndUserText.label: 'Flight'
          @EndUserText.quickInfo: 'Flight'
      key spfli.connid                               as flight
    }           
  
  
  
 