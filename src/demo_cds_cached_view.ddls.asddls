//This view is cached in program DEMO_SELECT_EXTENDED_RESULT
@AbapCatalog.sqlViewName: 'DEMOCDSCACH'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define view Demo_Cds_Cached_View
  as select from
    sflight
    {
      carrid,
      fldate,
      price,
      seatsocc
    }          
  
  
  
 