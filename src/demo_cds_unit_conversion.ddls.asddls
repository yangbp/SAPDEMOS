@AbapCatalog.sqlViewName: 'DEMO_CDS_UNTCNV'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define view demo_cds_unit_conversion
 with parameters
 to_unit :abap.unit( 3 )
 as select from
 demo_expressions
 {
 id,
 dec3 as original_value,
 cast( 'MI' as abap.unit(3) ) as original_unit,
 unit_conversion( quantity => dec3,
 source_unit => cast( 'MI' as abap.unit(3) ),
 target_unit => :to_unit,
 error_handling => 'SET_TO_NULL' ) as converted_value,
 :to_unit as converted_unit
 }            
  
  
  
 