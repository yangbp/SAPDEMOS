REPORT demo_open_sql_perfo.

GET RUN TIME FIELD DATA(t1).

* Bad example
SELECT carrid, CAST( ' ' AS CHAR( 20 ) ) AS carrname,
       connid, cityfrom, cityto
       FROM spfli
       ORDER BY carrid, connid, cityfrom, cityto
       INTO @DATA(wa).
  SELECT SINGLE carrname
         FROM scarr
         WHERE carrid = @wa-carrid
         INTO (@wa-carrname).
  DATA itab1 LIKE TABLE OF wa WITH EMPTY KEY.
  itab1 = VALUE #( BASE itab1 ( wa ) ).
ENDSELECT.

GET RUN TIME FIELD DATA(t2).

* Good example
SELECT p~carrid, c~carrname, p~connid, p~cityfrom, p~cityto
       FROM spfli AS p
          LEFT OUTER JOIN scarr AS c
            ON p~carrid = c~carrid
       ORDER BY p~carrid, p~connid, p~cityfrom, p~cityto
       INTO TABLE @DATA(itab2).

GET RUN TIME FIELD DATA(t3).

ASSERT itab1 = itab2.

cl_demo_output=>display( |Ratio: { ( t2 - t1 ) / ( t3 - t2 ) }| ).
