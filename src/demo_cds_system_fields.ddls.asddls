@AbapCatalog.sqlViewName: 'DEMO_CDS_SYST'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define view demo_cds_system_fields
 with parameters
 @Environment.systemField : #CLIENT
 p_mandt : syst_mandt,
 @Environment.systemField : #SYSTEM_DATE
 p_datum : syst_datum,
 @Environment.systemField : #SYSTEM_TIME
 p_uzeit : syst_uzeit,
 p_langu : syst_langu @<Environment.systemField : #SYSTEM_LANGUAGE,
 p_uname : syst_uname @<Environment.systemField : #USER
 as select from
 demo_expressions
 {
 :p_mandt as client,
 :p_datum as datum,
 :p_uzeit as uzeit,
 :p_langu as langu,
 :p_uname as uname
 }
 where
 id = '1';            
  
  
  
 