@AbapCatalog.sqlViewName: 'S_CUSTOMERSV'
@AbapCatalog.compiler.compareFilter: true
@EndUserText.label: 'Flight Customers'
define view S_Customers as select from scustom
association [*]    to S_Bookings     as _Bookings   on $projection.CustomerId =   _Bookings.CustomerId 
association [1]    to t005           as _Country   on $projection.country =   _Country.land1
association [1]    to t002           as _Language   on $projection.langu =   _Language.spras
 {
 
  key id       as CustomerId, 
  name     ,
  form     ,
  street   ,
  postbox  ,
  postcode , 
  city     ,
  country  ,
  region   ,
  telephone, 
  custtype , 
  discount , 
  langu    , 
  email    , 
  webuser,
  _Bookings,
  _Country,
  _Language
} 
