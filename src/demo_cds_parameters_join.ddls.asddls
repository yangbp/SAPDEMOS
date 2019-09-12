@AbapCatalog.sqlViewName: 'DEMO_CDS_PARJOIN'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define view demo_cds_parameters_join
  with parameters
    in_distance_l :s_distance,
    in_distance_u :s_distance,
    in_unit       :s_distid
  as select from
           demo_cds_parameters
      ( p_distance_l : $parameters.in_distance_l,
        p_distance_u : $parameters.in_distance_u,
        p_unit       : $parameters.in_unit ) as flights
      join scarr on
        scarr.carrid = flights.carrid
    {
      key scarr.carrname,
      key flights.connid,
          flights.cityfrom,
          flights.cityto,
          flights.distance,
          flights.distid
    };       
  
  
  
 