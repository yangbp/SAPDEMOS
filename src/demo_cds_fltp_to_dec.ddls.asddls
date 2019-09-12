@AbapCatalog.sqlViewName: 'DEMO_CDS_FLTPDEC'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define view demo_cds_fltp_to_dec
  as select from
    demo_expressions
    {
      fltp_to_dec( fltp1 as abap.dec(10,0) ) as dec1_10_0,
      fltp_to_dec( fltp1 as abap.dec(10,3) ) as dec1_10_3,
      fltp_to_dec( fltp2 as abap.dec(10,0) ) as dec2_10_0,
      fltp_to_dec( fltp2 as abap.dec(10,3) ) as dec2_10_3
    }       
  
  
  
 