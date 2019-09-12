@AbapCatalog.sqlViewName: 'S_FLIGHTSV'
@AbapCatalog.compiler.compareFilter: true
@EndUserText.label: 'Flights'
define view S_Flights as select from sflight
    association [1..1]    to tcurc            as _Currency   on $projection.currencyCode =   _Currency.waers
    association [1]    to S_Carrier        as _Carrier on $projection.CarrierId =  _Carrier.CarrierId                                                    
    association [1]    to S_Connections   as _Connection on $projection.CarrierId =  _Connection.CarrierId 
                                                          and $projection.ConnectionId = _Connection.ConnectionId                                                                                                     
    association [1]    to S_Planes         as _Plane      on $projection.planetype =   _Plane.planetype
    association [*]    to S_Bookings       as _Bookings   on $projection.CarrierId =  _Bookings.CarrierId 
                                                           and $projection.ConnectionId = _Bookings.ConnectionId
                                                           and $projection.FlightDate = _Bookings.FlightDate                                                                                                     
 {

 key carrid as CarrierId, 
 key connid as ConnectionId, 
 key fldate as FlightDate, 
 
  price, 
  currency as currencyCode,  
  planetype, 
  seatsmax, 
  seatsocc, 
  paymentsum, 
  seatsmax_b, 
  seatsocc_b, 
  seatsmax_f, 
  seatsocc_f,
  
  _Currency,
  _Carrier,
  _Connection,
  _Plane,
  _Bookings
}    
