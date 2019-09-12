@AbapCatalog.sqlViewName: 'DEMO_CDS_T100_LG'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define view demo_cds_select_t100_langu
 with parameters
 @Environment.systemField:#SYSTEM_LANGUAGE
 p_langu : lang
 as select from
 t100
 {
 *
 }
 where
 sprsl = :p_langu
 and arbgb = 'SABAPDEMOS'            
  
  
  
 