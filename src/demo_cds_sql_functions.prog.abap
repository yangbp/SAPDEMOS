 REPORT demo_cds_sql_functions.

* Not maintained any longer
* Replaced by DEMO_CDS_SQL_FUNCTIONS_NUM, _STRING, _BYTE

 CLASS demo DEFINITION.
   PUBLIC SECTION.
     CLASS-METHODS: main.
 ENDCLASS.

 CLASS demo IMPLEMENTATION.
   METHOD main.
     SUBMIT demo_cds_sql_functions_num    AND RETURN.
     SUBMIT demo_cds_sql_functions_string AND RETURN.
     SUBMIT demo_cds_sql_functions_byte   AND RETURN.
   ENDMETHOD.
 ENDCLASS.

 START-OF-SELECTION.
   demo=>main( ).
