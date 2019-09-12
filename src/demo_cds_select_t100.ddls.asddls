@AbapCatalog.sqlViewName: 'DEMO_CDS_T100'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define view demo_cds_select_t100
 as select from
 demo_cds_select_t100_langu( p_langu: $session.system_language )
 {
 *
 }            
  
  
  
 