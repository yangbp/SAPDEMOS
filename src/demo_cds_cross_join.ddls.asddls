@AbapCatalog.sqlViewName: 'DEMO_CDS_CRSJN'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define view demo_cds_cross_join
  as select from
                 t000
      cross join t100
    {
      t000.mandt,
      t000.mtext,
      t100.sprsl,
      t100.arbgb,
      t100.msgnr,
      t100.text
    }
    where
      t100.arbgb = 'SABAPDEMOS'         
  
  
  
 