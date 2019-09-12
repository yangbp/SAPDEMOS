@AbapCatalog.sqlViewName: 'DEMO_CDS_CURRCO'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define view demo_cds_curr_conv
 with parameters
 to_currency :abap.cuky( 5 ),
 exc_date :abap.dats
 as select from
 demo_prices
 {
 id,
 currency_conversion( amount => amount,
 source_currency => currency,
 round => 'X',
 target_currency => :to_currency,
 exchange_rate_date => :exc_date,
 error_handling => 'SET_TO_NULL' ) as amount,
 :to_currency as currency
 }            
  
  
  
 