REPORT demo_sql_function_concat.

CLASS demo DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS main.
ENDCLASS.

CLASS demo IMPLEMENTATION.
  METHOD main.
    SELECT CONCAT_WITH_SPACE( CONCAT( carrid,
                              LPAD( carrname,21,' ' ) ),
                              RPAD( url,40,' ' ), 3 ) AS line
           FROM scarr
           INTO TABLE @DATA(result).
    cl_demo_output=>display( result ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  demo=>main( ).
