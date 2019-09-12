@AbapCatalog.sqlViewName: 'DEMO_CDS_STRFUNC'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define view demo_cds_sql_functions_string
  as select from
    demo_expressions
    {
      length(            char1               ) as r_length,
      instr(             char1, 'CD'         ) as r_instr,
      concat(            char1, char2        ) as r_concat,
      concat_with_space( char1, char2, 10    ) as r_concat_with_space,
      left(              char1, 3            ) as r_left,
      lower(             char1               ) as r_lower,
      right(             char2, 3            ) as r_right,
      lpad(              char1, 10, 'x'      ) as r_lpad,
      rpad(              char2, 10, 'y'      ) as r_rpad,
      ltrim(             char1, 'A'          ) as r_ltrim,
      rtrim(             char1, 'E'          ) as r_rtrim,
      replace(           char2, 'GHI', 'XXX' ) as r_replace,
      substring(         char2, 2, 3         ) as r_substring,
      upper(             char2               ) as r_upper
    }       
  
  
  
 