REPORT demo_sql_function_string.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    DELETE FROM demo_expressions.
    INSERT demo_expressions FROM TABLE @( VALUE #(
      ( id = 'X'
        char1 = ' 0123'
        char2 = 'aAaA' ) ) ).

    SELECT SINGLE
           char1 AS text1,
           char2 AS text2,
           CONCAT(            char1,char2 )     AS concat,
           CONCAT_WITH_SPACE( char1,char2, 1 )  AS concat_with_space,
           INSTR(             char1,'12' )      AS instr,
           LEFT(              char1,3 )         AS left,
           LENGTH(            char1 )           AS length,
           LOWER(             char2 )           AS lower,
           LPAD(              char1,10,'x' )    AS lpad,
           LTRIM(             char1,' ' )       AS ltrim,
           REPLACE(           char1,'12','__' ) AS replace,
           RIGHT(             char1,3 )         as right,
           RPAD(              char1,10,'x' )    AS rpad,
           RTRIM(             char1,'3' )       AS rtrim,
           SUBSTRING(         char1,3,3 )       AS substring,
           UPPER(             char2 )           AS upper
           FROM demo_expressions
           INTO @DATA(result).

    cl_demo_output=>display( result ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
