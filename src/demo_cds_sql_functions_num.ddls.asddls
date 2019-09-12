@AbapCatalog.sqlViewName: 'DEMO_CDS_NUMFUNC'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define view demo_cds_sql_functions_num
  as select from
    demo_expressions
    {
      abs(       num1          ) as r_abs,
      ceil(      fltp1         ) as r_ceil,
      floor(     dec1          ) as r_floor,
      div(       num1, num2    ) as r_div,
      mod(       num1, num2    ) as r_mod,
      division(  dec2, dec3, 3 ) as r_division,
      round(     dec3, 2       ) as r_round
    }       
  
  
  
 