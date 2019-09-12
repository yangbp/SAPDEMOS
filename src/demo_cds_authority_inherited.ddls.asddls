@AbapCatalog.sqlViewName: 'DEMO_CDS_INH'
@AccessControl.authorizationCheck: #CHECK
define view demo_cds_auth_inherited
  as select from
    demo_cds_auth_lit_pfcg
    {
      key carrid,
          carrname,
          currcode,
          url
    };      
  
  
  
 