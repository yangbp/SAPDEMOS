@AbapCatalog.sqlViewName: 'DEMO_CDS_ANIN1A'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.ignorePropagatedAnnotations: true
define view demo_cds_anno_inheritance_1A
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
  
  
  
 