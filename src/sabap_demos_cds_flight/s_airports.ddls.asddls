@AbapCatalog.sqlViewName: 'S_AirportsV'
@AbapCatalog.compiler.compareFilter: true
@EndUserText.label: 'Airports'
define view S_Airports as select from sairport
association [1]    to S_Connections     as _Departures      on $projection.AirportId =  _Departures.AirportFrom
association [1]    to S_Connections     as _Arrivals        on $projection.AirportId =  _Arrivals.AirportTo

{
  key id as AirportId, 
  name as Name, 
  time_zone,
  _Departures,
  _Arrivals
}           
  
  
  
 