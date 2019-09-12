@AbapCatalog.sqlViewName: 'DEMO_CDS_CAST_DE'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define view demo_cds_cast_data_element
 as select from
 demo_expressions
 {
 cast ( char1 as DEMO_CHAR_TEXT preserving type) as char_with_text
 };            
  
  
  
 