@AbapCatalog.sqlViewName: 'DEMO_CDS_SESSVAR'
@AccessControl.authorizationCheck: #NOT_ALLOWED
define view demo_cds_session_variables
  as select from
    demo_expressions 
    {
      id,
      $session.user            as system_user,
      $session.client          as system_client,
      $session.system_language as system_language,
      $session.system_date     as system_date
    }  
