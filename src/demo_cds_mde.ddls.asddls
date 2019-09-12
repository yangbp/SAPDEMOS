@AbapCatalog.sqlViewName: 'DEMOCDSVIEWMDE'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
define view Demo_Cds_MDE
  as select from
    demo_expressions
    {
        @UI.dataPoint.title: 'View, title'
        @UI.dataPoint.description: 'View, description'
        @UI.dataPoint.longDescription: 'View, longdescription'
      'X' as element
    }
    where
      id = 'X'              
  
  
  
 