@AbapCatalog.sqlViewName: 'demo_cds_tzfnc'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define view demo_cds_timezone_functions
  as select from
    demo_expressions
    {
      abap_system_timezone( $session.client,'NULL' )               
        as system_tz,
      abap_user_timezone(   $session.user,$session.client,'NULL' ) 
        as user_tz
    }         
  
  
  
 