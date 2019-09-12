@AbapCatalog.sqlViewName: 'DEMO_CDS_PARA'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions
@EndUserText.label: 'Demo für Parameter-View'
define view demo_cds_parameters
  with parameters
    p_distance_l :s_distance,
    p_distance_u :s_distance,
    p_unit       :s_distid
  as select from
    spfli
    {
      key carrid,
      key connid,
          cityfrom,
          cityto,
          distance,
          distid
    }
    where
          distid   =       :p_unit
      and distance between :p_distance_l and :p_distance_u;             
  
  
  
 