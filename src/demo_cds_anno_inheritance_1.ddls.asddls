@AbapCatalog.sqlViewName: 'DEMO_CDS_ANIN1'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define view demo_cds_anno_inheritance_1
  as select from
    demo_cds_anno_inheritance_2
    {
          @EndUserText.label: 'XXXXXXXXXX'
      key id,
      key carrier,
      key flight,
          departure,
          destination
    }              
  
  
  
 