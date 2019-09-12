@AbapCatalog.sqlViewName: 'DEMO_CDS_NULL2'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define view demo_cds_anno_null_value_2
  as select from
    demo_cds_anno_null_value_1
    {
          @EndUserText: null
      key id,
          @EndUserText.heading: null
          @EndUserText.label: null
      key carrier,
          @EndUserText.heading: null
          @EndUserText.quickInfo: null
      key flight
    }             
  
  
  
 