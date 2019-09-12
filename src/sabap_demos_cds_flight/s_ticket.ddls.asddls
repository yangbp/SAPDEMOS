@AbapCatalog.sqlViewName: 'S_TicketV'
@AbapCatalog.compiler.compareFilter: true
@EndUserText.label: 'Tickets'
define view S_Tickets as select from sticket
 association [1]    to S_Customers      as _Customer   on $projection.CustomerId =   _Customer.CustomerId 
 association [1]    to S_Bookings       as _Booking    on $projection.BookId =   _Booking.BookId 
 {
  
 key carrid as CarrierId, 
 key connid as ConnectionId, 
 key fldate as FlightDate, 
 key bookid as BookId, 
 key customid as CustomerId, 
 key ticket, 
  place,
  _Customer,
  _Booking
} 
