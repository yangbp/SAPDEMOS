@AbapCatalog.sqlViewName: 'DEMOCDSAVG'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define view Demo_Cds_Avg
  as select from
    demo_expressions
    {
      avg(          num1                   ) as avg_no_type,
      avg( distinct num1                   ) as avg_no_type_distinct,
      avg(          num1 as abap.dec(10,0) ) as avg_dec0,
      avg( distinct num1 as abap.dec(10,0) ) as avg_dec0_distinct,
      avg(          num1 as abap.dec(12,2) ) as avg_dec2,
      avg( distinct num1 as abap.dec(12,2) ) as avg_dec2_distinct
    }            
  
  
  
 