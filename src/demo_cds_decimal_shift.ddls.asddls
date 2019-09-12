@AbapCatalog.sqlViewName: 'DEMO_CDS_DCSHFT'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define view demo_cds_decimal_shift
 as select from
 demo_prices
 {
 id,
 @Semantics.amount.currencyCode:'currency'
 amount as original,
 @Semantics.currencyCode
 currency,
 decimal_shift( amount => amount,
 currency => cast( '0 ' as abap.cuky(5) ),
 error_handling => 'SET_TO_NULL' ) as shift_0,
 decimal_shift( amount => amount,
 currency => cast( '1 ' as abap.cuky(5) ),
 error_handling => 'SET_TO_NULL' ) as shift_1,
 decimal_shift( amount => amount,
 currency => cast( '2 ' as abap.cuky(5) ),
 error_handling => 'SET_TO_NULL' ) as shift_2,
 decimal_shift( amount => amount,
 currency => cast( '3 ' as abap.cuky(5) ),
 error_handling => 'SET_TO_NULL' ) as shift_3,
 decimal_shift( amount => amount,
 currency => cast( '4 ' as abap.cuky(5) ),
 error_handling => 'SET_TO_NULL' ) as shift_4,
 decimal_shift( amount => amount,
 currency => cast( '5 ' as abap.cuky(5) ),
 error_handling => 'SET_TO_NULL' ) as shift_5
 }            
  
  
  
 