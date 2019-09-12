@AbapCatalog.sqlViewName: 'S_CITYV'
@AbapCatalog.compiler.compareFilter: true
@EndUserText.label: 'Cities'
define view S_CityAirport as select from scitairp left outer join sgeocity 
  on scitairp.city = sgeocity.city and scitairp.country = sgeocity.country 
association [1]    to t005           as _Country   on $projection.Country =   _Country.land1
 {
  key scitairp.city    as City, 
  key scitairp.country as Country, 
  key airport as AirportId, 
  mastercity  as MasterCity,
  latitude,
  longitude,
  _Country
} 
