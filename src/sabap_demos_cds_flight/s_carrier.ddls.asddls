@AbapCatalog.sqlViewName: 'S_CARRIERV'
@AbapCatalog.compiler.compareFilter: true
@EndUserText.label: 'Flight Carriers'
define view S_Carrier as select 
from scarr
association [1]    to tcurc            as _Currency   on $projection.currencyCode =   _Currency.waers
association [*]    to S_Connections    as _Connections   on $projection.CarrierId =   _Connections.CarrierId
association [*]    to S_Flights        as _Flights   on $projection.CarrierId =   _Flights.CarrierId
association [*]    to S_Bookings       as _Bookings   on $projection.CarrierId =   _Bookings.CarrierId
association [*]    to S_Tickets        as _Tickets   on $projection.CarrierId =   _Tickets.CarrierId

 {
   key carrid as CarrierId, 
   carrname as Name, 
   currcode as currencyCode, 
   url,
   _Currency,
   _Connections,
   _Flights,
   _Bookings,
   _Tickets
}                     
  
  
  
  
  
  
  
 