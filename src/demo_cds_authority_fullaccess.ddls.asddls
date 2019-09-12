@AbapCatalog.sqlViewName: 'DEMO_CDS_FULLACC'
@AccessControl.authorizationCheck: #CHECK
define view demo_cds_auth_fullaccess
  as select from
    scarr
    {
      key carrid,
          carrname,
          currcode,
          url
    };      
  
  
  
 