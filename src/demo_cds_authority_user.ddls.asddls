@AbapCatalog.sqlViewName: 'DEMO_CDS_USR'
@AccessControl.authorizationCheck: #CHECK
define view demo_cds_auth_user
  as select from
    abdocmode
    {
      key uname,
      key langu,
          flag
    };        
  
  
  
 