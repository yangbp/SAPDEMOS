@AbapCatalog.sqlViewName: 'S_BOOKINGSV'
@AbapCatalog.compiler.compareFilter: true
@EndUserText.label: 'Flight Bookings'
define view S_Bookings as select from sbook
   association [1]    to tcurc            as _ForeignCurrency    on $projection.ForeignCurrencyCode =   _ForeignCurrency.waers
   association [1]    to tcurc            as _LocalCurrency      on $projection.LocalCurrencyCode   =   _LocalCurrency.waers
   association [1]    to t006             as _WeightUnit         on $projection.WeightUnit          =   _WeightUnit.msehi
   association [1]    to S_Flights        as _Flight on $projection.CarrierId =  _Flight.CarrierId 
                                                           and $projection.ConnectionId = _Flight.ConnectionId
                                                           and $projection.FlightDate = _Flight.FlightDate                                                        
  association [1]    to S_Customers      as _Customer   on $projection.CustomerId =   _Customer.CustomerId                                                                    
 {
 
 key carrid  as CarrierId, 
 key connid  as ConnectionId, 
 key fldate  as FlightDate, 
 key bookid  as BookId, 
  customid   as CustomerId, 
  custtype   as CustomerType, 
  smoker     as Smoker, 
  luggweight as LuggageWeight, 
  wunit      as WeightUnit, 
  invoice    as InvoiceId, 
  class      as Class, 
  
  @Semantics.amount.currencyCode: 'ForeignCurrencyCode'
  forcuram   as ForeignCurrencyAmount, 
  forcurkey  as ForeignCurrencyCode , 
  @Semantics.amount.currencyCode: 'LocalCurrencyCode'
  loccuram   as LocalCurrencyAmount, 
  loccurkey  as LocalCurrencyCode ,
  order_date as OrderDate, 
  counter    as Counter, 
  agencynum  as AgencyNumber, 
  cancelled  as Cancelled, 
  reserved   as Reserved, 
  passname, 
  passform, 
  passbirth,
  
  _ForeignCurrency,
  _LocalCurrency,
  _Flight,
  _WeightUnit,
  _Customer
}  
