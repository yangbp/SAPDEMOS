@AbapCatalog.sqlViewName: 'S_ConnectionsV'
@AbapCatalog.compiler.compareFilter: true
@EndUserText.label: 'Flight Connections'
define view S_Connections as select from spfli
association [1]    to S_Carrier    as _Carrier   on $projection.CarrierId =  _Carrier.CarrierId
association [*]    to S_Flights    as _Flights  on $projection.CarrierId =  _Flights.CarrierId 
                                                     and $projection.ConnectionId = _Flights.ConnectionId
association [1]    to S_Airports           as _FromAirport      on $projection.AirportFrom =  _FromAirport.AirportId
association [1]    to S_CityAirport        as _FromCity  on $projection.AirportFrom =  _FromCity.AirportId and $projection.CityFrom = _FromCity.City and $projection.CountryFrom = _FromCity.Country 
association [1]    to S_Airports           as _ToAirport      on $projection.AirportTo =  _ToAirport.AirportId
association [1]    to S_CityAirport        as _ToCity  on $projection.AirportTo =  _ToCity.AirportId and $projection.CityTo = _ToCity.City and $projection.CountryTo = _ToCity.Country
{

  key carrid as CarrierId, 
  key connid as ConnectionId, 
  
  countryfr as CountryFrom, 
  cityfrom  as CityFrom, 
  airpfrom  as AirportFrom, 
  
  countryto as CountryTo, 
  cityto    as CityTo, 
  airpto    as AirportTo,  
  
  fltime    as FlightTime ,   
  deptime   as DepartureTime, 
  arrtime   as ArrivalTime, 
  distance  as Distance, 
  distid    as DistanceUnitId, 
  fltype    as FlightType, 
  period    as ArrivalsDays,
  _Carrier,
  _Flights,
  _FromAirport,
  _FromCity,
  _ToAirport,
  _ToCity
  
}                     
  
  
  
  
  
  
  
 